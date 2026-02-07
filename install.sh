#!/bin/bash
set -e

# X Bookmark Research - Installer
# Copies the slash command and skill into your ~/.claude/ directory

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing X Bookmark Research..."

# Ensure target directories exist
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/skills/x-bookmark-research/references

# Copy command
cp "$SCRIPT_DIR/commands/research-bookmarks.md" ~/.claude/commands/research-bookmarks.md
echo "  Installed command: ~/.claude/commands/research-bookmarks.md"

# Copy skill files
cp "$SCRIPT_DIR/skills/x-bookmark-research/SKILL.md" ~/.claude/skills/x-bookmark-research/SKILL.md
cp "$SCRIPT_DIR/skills/x-bookmark-research/references/output-format.md" ~/.claude/skills/x-bookmark-research/references/output-format.md
echo "  Installed skill:   ~/.claude/skills/x-bookmark-research/"

# Create config from example if none exists
if [ ! -f ~/.claude/skills/x-bookmark-research/config.yml ]; then
  cp "$SCRIPT_DIR/config/bookmark-research.example.yml" ~/.claude/skills/x-bookmark-research/config.yml
  echo ""
  echo "  Created config:    ~/.claude/skills/x-bookmark-research/config.yml"
  echo ""
  echo "  >>> Edit this file with your settings before first use! <<<"
  echo "      - Set your output directory"
  echo "      - Add your interests/projects"
  echo "      - Choose your default research depth"
else
  echo "  Config exists:     ~/.claude/skills/x-bookmark-research/config.yml (not overwritten)"
fi

echo ""
echo "Done! Restart Claude Code, then run /research-bookmarks to get started."
