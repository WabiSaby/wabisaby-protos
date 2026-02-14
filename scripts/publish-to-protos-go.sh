#!/usr/bin/env bash
# Generate Go code for wabisaby-protos-go with module path github.com/wabisaby/wabisaby-protos-go.
# Usage: ./scripts/publish-to-protos-go.sh <path-to-wabisaby-protos-go-clone>
# Example: ./scripts/publish-to-protos-go.sh ../wabisaby-protos-go

set -e
PROTOS_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="${1:?Usage: $0 <path-to-wabisaby-protos-go-clone>}"
OUT_DIR="$(cd "$OUT_DIR" 2>/dev/null || true)"
if [[ -z "$OUT_DIR" || ! -d "$OUT_DIR" ]]; then
  echo "Error: output directory does not exist: $1"
  exit 1
fi
cd "$PROTOS_ROOT"
make proto-for-go OUT_DIR="$OUT_DIR"
echo "Done. Next: in $OUT_DIR run 'go mod tidy', commit, push, and tag (e.g. v0.0.1)."
