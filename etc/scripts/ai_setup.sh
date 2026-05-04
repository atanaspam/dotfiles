#!/bin/bash
# One-time setup for the heavy AI model in the local AI stack.
# Pulls the model into Ollama and registers it as a named model in Open WebUI.
#
# Prerequisites (must be running before executing this script):
#   1. Run `ai up` and wait ~30s for both Ollama and Open WebUI to become ready
#
# This script is safe to re-run: Ollama skips the pull if already present,
# and the Open WebUI model entry is recreated if it exists.

set -euo pipefail

OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
OPENWEBUI_URL="${OPENWEBUI_URL:-http://localhost:3030}"
HEAVY_MODEL="${HEAVY_MODEL:-hf.co/unsloth/Qwen3.5-122B-A10B-GGUF:Q4_K_M}"
MODEL_ID="heavy-ai"
MODEL_NAME="Heavy AI"
LOCAL_EMAIL="admin@local.ai"
LOCAL_PASSWORD="localonly"

echo "Checking Ollama is reachable at ${OLLAMA_URL}..."
if ! curl -sf "${OLLAMA_URL}" > /dev/null; then
  echo "ERROR: Ollama is not reachable. Run \`ai up\` first."
  exit 1
fi

echo "Pulling model ${HEAVY_MODEL} (this will take a while on first run)..."
ollama pull "${HEAVY_MODEL}"

echo "Checking Open WebUI is reachable at ${OPENWEBUI_URL}..."
if ! curl -sf "${OPENWEBUI_URL}/health" > /dev/null 2>&1; then
  echo "ERROR: Open WebUI is not reachable. Run \`ai up\` and wait ~30s for it to become healthy."
  exit 1
fi

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

echo "Registering '${MODEL_NAME}' model in Open WebUI..."
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
    --arg base "$HEAVY_MODEL" \
    --arg name "$MODEL_NAME" \
    '{
      id: $id,
      base_model_id: $base,
      name: $name,
      params: {},
      meta: {
        description: "Qwen3.5 122B (A10B active) — general purpose, no knowledge base"
      }
    }')" > /dev/null

echo "'${MODEL_NAME}' model is ready in Open WebUI."
echo "Open WebUI is available at ${OPENWEBUI_URL}"
