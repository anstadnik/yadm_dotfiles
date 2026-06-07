#!/usr/bin/env bash
# Shared PostToolUse(Edit|Write) formatter. Used by both
# ~/.claude/settings.json and ~/.codex/hooks.json. Hook JSON arrives on stdin.
path=$(jq -r '.tool_input.file_path // empty')
case "$path" in
  *.py) uvx --quiet ruff format "$path" >/dev/null 2>&1 ;;
  *.cpp|*.cc|*.h|*.hpp|*.c) clang-format -i "$path" >/dev/null 2>&1 ;;
esac
exit 0
