#!/bin/bash
# Indexes the Obsidian Knowledgebase folder into Open WebUI's RAG knowledge base.
# Safe to re-run: deletes and recreates the knowledge collection each time.
#
# Optional env vars:
#   OPENWEBUI_URL          - defaults to http://localhost:3030
#   VAULTS_LOCATION        - parent directory containing all vaults (defaults to ~/vaults)
#   TARGET_VAULT           - vault to index (defaults to $DEFAULT_VAULT, then "personal")
#   VAULT_KB_SUBDIR        - subfolder within the vault to index (defaults to "Knowledge Base")
#   BASE_MODEL             - Ollama model to use for the Local KB model (defaults to llama3:8b)

set -euo pipefail

OPENWEBUI_URL="${OPENWEBUI_URL:-http://localhost:3030}"
VAULTS_LOCATION="${VAULTS_LOCATION:-$HOME/vaults}"
TARGET_VAULT="${TARGET_VAULT:-${DEFAULT_VAULT:-personal}}"
VAULT_KB_SUBDIR="${VAULT_KB_SUBDIR:-Knowledge Base}"
KB_NAME="${TARGET_VAULT} Knowledgebase"
LOCAL_EMAIL="admin@local.ai"
LOCAL_PASSWORD="localonly"
BASE_MODEL="${BASE_MODEL:-llama3:8b}"
MODEL_ID="${TARGET_VAULT}-kb"

VAULT_KB_PATH="${VAULTS_LOCATION}/${TARGET_VAULT}/${VAULT_KB_SUBDIR}"
if [[ ! -d "$VAULT_KB_PATH" ]]; then
  echo "ERROR: Knowledge base directory not found: ${VAULT_KB_PATH}"
  echo "       Check VAULTS_LOCATION, TARGET_VAULT, and VAULT_KB_SUBDIR are correct."
  exit 1
fi

echo "Checking Open WebUI is reachable at ${OPENWEBUI_URL}..."
if ! curl -sf "${OPENWEBUI_URL}/health" > /dev/null 2>&1; then
  echo "ERROR: Open WebUI is not reachable. Run \`ai up\` first."
  exit 1
fi

# Auto-authenticate: try signup (silent if account already exists), then signin for a session token
curl -sf -X POST "${OPENWEBUI_URL}/api/v1/auths/signup" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"Admin\", \"email\": \"${LOCAL_EMAIL}\", \"password\": \"${LOCAL_PASSWORD}\"}" \
  > /dev/null 2>&1 || true

TOKEN=$(curl -sf -X POST "${OPENWEBUI_URL}/api/v1/auths/signin" \
  -H "Content-Type: application/json" \
  -d "{\"email\": \"${LOCAL_EMAIL}\", \"password\": \"${LOCAL_PASSWORD}\"}" \
  | jq -r '.token')

if [[ -z "$TOKEN" || "$TOKEN" == "null" ]]; then
  echo "ERROR: Failed to authenticate with Open WebUI."
  exit 1
fi

AUTH_ARGS=(-H "Authorization: Bearer ${TOKEN}")

api() {
  local method="$1"; shift
  local path="$1"; shift
  curl -sf -X "$method" "${OPENWEBUI_URL}${path}" "${AUTH_ARGS[@]}" "$@"
}

echo "Locating existing '${KB_NAME}' knowledge base(s)..."
api GET /api/v1/knowledge/ \
  -H "Content-Type: application/json" \
  | jq -r --arg name "$KB_NAME" '.items[] | select(.name == $name) | .id' 2>/dev/null \
  | while read -r id; do
    echo "Deleting existing knowledge base (${id})..."
    api DELETE "/api/v1/knowledge/${id}/delete" \
      -H "Content-Type: application/json" > /dev/null
  done

echo "Creating knowledge base '${KB_NAME}'..."
KB_ID=$(api POST /api/v1/knowledge/create \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"${KB_NAME}\", \"description\": \"Indexed from ${VAULT_KB_PATH}\"}" \
  | jq -r '.id')

if [[ -z "$KB_ID" || "$KB_ID" == "null" ]]; then
  echo "ERROR: Failed to create knowledge base. Check Open WebUI logs."
  exit 1
fi
echo "Created with id: ${KB_ID}"

echo "Indexing markdown files from ${VAULT_KB_PATH}..."
SUCCESS=0
FAILED=0

while IFS= read -r -d '' file; do
  filename="$(basename "$file")"
  printf "  Uploading: %s ... " "$filename"

  FILE_ID=$(api POST /api/v1/files/ \
    -F "file=@${file};type=text/plain" \
    | jq -r '.id' 2>/dev/null || true)

  if [[ -z "$FILE_ID" || "$FILE_ID" == "null" ]]; then
    echo "FAILED (upload)"
    FAILED=$((FAILED + 1))
    continue
  fi

  RESULT=$(api POST "/api/v1/knowledge/${KB_ID}/file/add" \
    -H "Content-Type: application/json" \
    -d "{\"file_id\": \"${FILE_ID}\"}" \
    | jq -r '.id' 2>/dev/null || true)

  if [[ -z "$RESULT" || "$RESULT" == "null" ]]; then
    echo "FAILED (add to KB)"
    FAILED=$((FAILED + 1))
  else
    echo "ok"
    SUCCESS=$((SUCCESS + 1))
  fi
done < <(find "$VAULT_KB_PATH" -name "*.md" -type f -print0)

echo ""
echo "Indexing complete: ${SUCCESS} succeeded, ${FAILED} failed."

echo "Creating 'Local KB' model with knowledge base attached..."
EXISTING_MODEL=$(api GET "/api/v1/models/model?id=${MODEL_ID}" \
  -H "Content-Type: application/json" 2>/dev/null | jq -r '.id' || true)

if [[ -n "$EXISTING_MODEL" && "$EXISTING_MODEL" != "null" ]]; then
  api POST /api/v1/models/model/delete \
    -H "Content-Type: application/json" \
    -d "{\"id\": \"${MODEL_ID}\"}" > /dev/null
fi

api POST /api/v1/models/create \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg id "$MODEL_ID" \
    --arg base "$BASE_MODEL" \
    --arg kb_id "$KB_ID" \
    --arg kb_name "$KB_NAME" \
    --arg desc "${BASE_MODEL} with Obsidian Knowledgebase attached by default" \
    '{
      id: $id,
      base_model_id: $base,
      name: "Local KB",
      params: {},
      meta: {
        description: $desc,
        knowledge: [{id: $kb_id, name: $kb_name, type: "collection"}]
      }
    }')" > /dev/null

echo "Local KB model ready."
echo "Knowledge base '${KB_NAME}' is available in Open WebUI."
