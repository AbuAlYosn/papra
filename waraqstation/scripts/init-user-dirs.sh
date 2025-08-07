#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
UD="$ROOT_DIR/user-data"
mkdir -p "$UD/media" "$UD/export" "$UD/consume" "$UD/trash"
chmod -R 777 "$UD"
echo "Created user-data folders at $UD"