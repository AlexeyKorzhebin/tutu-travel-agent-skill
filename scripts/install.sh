#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install the tutu-travel-agent skill into Codex and/or OpenClaw.

Usage:
  ./scripts/install.sh [--target codex|openclaw|all] [--dest PATH] [--force] [--link]

Options:
  --target   Install target. Default: codex
  --dest     Explicit skills directory. Overrides --target.
  --force    Replace existing destination folder if it exists.
  --link     Create a symlink instead of copying.

Examples:
  ./scripts/install.sh
  ./scripts/install.sh --target openclaw
  ./scripts/install.sh --target all --force
  ./scripts/install.sh --dest "$HOME/.codex/skills" --link
EOF
}

TARGET="codex"
DEST=""
FORCE="false"
LINK="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
      shift 2
      ;;
    --dest)
      DEST="${2:-}"
      shift 2
      ;;
    --force)
      FORCE="true"
      shift
      ;;
    --link)
      LINK="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILL_SRC="$REPO_ROOT/skill/tutu-travel-agent"

if [[ ! -d "$SKILL_SRC" ]]; then
  echo "Skill source not found: $SKILL_SRC" >&2
  exit 1
fi

copy_one() {
  local skills_dir="$1"
  local skill_dest="$skills_dir/tutu-travel-agent"

  mkdir -p "$skills_dir"

  if [[ -e "$skill_dest" || -L "$skill_dest" ]]; then
    if [[ "$FORCE" != "true" ]]; then
      echo "Destination already exists: $skill_dest" >&2
      echo "Re-run with --force to replace it." >&2
      return 1
    fi
    rm -rf "$skill_dest"
  fi

  if [[ "$LINK" == "true" ]]; then
    ln -s "$SKILL_SRC" "$skill_dest"
    echo "Linked: $skill_dest -> $SKILL_SRC"
  else
    cp -R "$SKILL_SRC" "$skill_dest"
    echo "Installed: $skill_dest"
  fi
}

codex_dir() {
  printf '%s\n' "${CODEX_HOME:-$HOME/.codex}/skills"
}

openclaw_dir() {
  printf '%s\n' "$HOME/.openclaw/workspace/skills"
}

if [[ -n "$DEST" ]]; then
  copy_one "$DEST"
  exit 0
fi

case "$TARGET" in
  codex)
    copy_one "$(codex_dir)"
    ;;
  openclaw)
    copy_one "$(openclaw_dir)"
    ;;
  all)
    copy_one "$(codex_dir)"
    copy_one "$(openclaw_dir)"
    ;;
  *)
    echo "Unsupported target: $TARGET" >&2
    usage >&2
    exit 2
    ;;
esac
