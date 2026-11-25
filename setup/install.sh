#!/usr/bin/env bash
# One-shot, idempotent install. Safe to re-run after `git pull`.
#   1. installs the ob-* skills for Claude Code / other agents
#   2. creates your owner profile from the template (if missing)
#   3. installs each bot's SOUL.md + OWNER.md into the bots that exist
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONF="${ORCA_BOTS_CONFIG:-$HOME/.config/orca-bots}"
AGENTS_SKILLS="$HOME/.agents/skills"
CLAUDE_SKILLS="$HOME/.claude/skills"

echo "== skills"
mkdir -p "$AGENTS_SKILLS" "$CLAUDE_SKILLS"
for s in "$ROOT"/skills/ob-*; do
  n="$(basename "$s")"
  rsync -a --delete "$s/" "$AGENTS_SKILLS/$n/"
  [[ -e "$CLAUDE_SKILLS/$n" ]] || ln -s "$AGENTS_SKILLS/$n" "$CLAUDE_SKILLS/$n"
  echo "  $n"
done

echo "== owner profile"
mkdir -p "$CONF"
if [[ -f "$CONF/OWNER.md" ]]; then
  echo "  kept $CONF/OWNER.md"
else
  cp "$ROOT/templates/OWNER.md" "$CONF/OWNER.md"
  echo "  created $CONF/OWNER.md (Captain fills it with you: say 'set up my owner profile')"
fi
touch "$CONF/folders"

echo "== bots"
bash "$ROOT/setup/sync.sh" adopt >/dev/null 2>&1 || true
bash "$ROOT/setup/sync.sh" apply || true

echo
echo "Done. Missing bots? In Captain's chat: 'offer the orca-bots specialists'."
