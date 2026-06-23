#!/bin/bash
# One-time setup for the local knowledge base stack.
#
# Prerequisites (must be running before executing this script):
#   1. Run `ai up` and wait ~30s for both Ollama and Open WebUI to become ready
#
# This script is safe to re-run but will re-pull models and re-index the vault.

set -euo pipefail

OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
OPENWEBUI_URL="${OPENWEBUI_URL:-http://localhost:3030}"
CHAT_MODEL="${CHAT_MODEL:-llama3:8b}"
EMBED_MODEL="${EMBED_MODEL:-nomic-embed-text}"

echo "Checking Ollama is reachable at ${OLLAMA_URL}..."
if ! curl -sf "${OLLAMA_URL}" > /dev/null; then
  echo "ERROR: Ollama is not reachable. Start it via the Ollama menubar app or \`ollama serve\`."
  exit 1
fi

echo "Pulling Ollama models (this may take a while on first run)..."
ollama pull "${CHAT_MODEL}"
ollama pull "${EMBED_MODEL}"

echo "Checking Open WebUI is reachable at ${OPENWEBUI_URL}..."
if ! curl -sf "${OPENWEBUI_URL}/health" > /dev/null 2>&1; then
  echo "ERROR: Open WebUI is not reachable. Run \`ai up\` and wait ~30s for it to become healthy."
  exit 1
fi

echo "Indexing Obsidian vault..."
kb_index.sh

echo ""
echo "Done. Open WebUI is available at ${OPENWEBUI_URL}"
echo "Select the 'Local KB' model in the chat to query your knowledge base."
