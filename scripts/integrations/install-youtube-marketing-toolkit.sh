#!/usr/bin/env bash
# Optional, isolated installer for a pinned third-party YouTube growth toolkit.
# Does not authenticate to Google, edit channel metadata, or affect this app.
set -euo pipefail

command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
command -v npm >/dev/null || { echo "Node.js and npm are required" >&2; exit 1; }

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TARGET="${YOUTUBE_MARKETING_TOOL_DIR:-$ROOT/.local-tools/youtube-marketing-skills}"
UPSTREAM="https://github.com/adityaarsharma/youtube-marketing-skills.git"
PINNED_COMMIT="e9136cb39379a82801ee5ae542ff53a1d1109bd2"

if [[ -e "$TARGET" ]]; then
  echo "Target already exists: $TARGET" >&2
  echo "Refusing to overwrite. Move it aside or choose YOUTUBE_MARKETING_TOOL_DIR." >&2
  exit 2
fi

mkdir -p "$(dirname "$TARGET")"
git clone "$UPSTREAM" "$TARGET"
git -C "$TARGET" checkout --detach "$PINNED_COMMIT"
npm --prefix "$TARGET" ci --ignore-scripts --no-fund

echo "Third-party toolkit downloaded and dependencies installed at: $TARGET"
echo "Google OAuth is NOT configured. No YouTube channel changes have been made."
echo "Review docs/YOUTUBE-ORGANIC-GROWTH-TOOLKIT.md before any authorization."
