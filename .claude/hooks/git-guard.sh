#!/usr/bin/env bash
# Shared PreToolUse(Bash) guard: block destructive git ops. Used by both
# ~/.claude/settings.json and ~/.codex/hooks.json. Hook JSON arrives on stdin.
cmd=$(jq -r '.tool_input.command // empty')
echo "$cmd" | grep -qE 'git +(reset +--hard|clean +-[a-z]*f|push +.*--force(-with-lease)?|branch +-D)' && {
  echo 'BLOCKED: destructive git op. Re-run with explicit user approval.' >&2
  exit 2
} || exit 0
