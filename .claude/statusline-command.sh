#!/usr/bin/env bash
# Claude Code status line — mirrors Starship defaults (dir, git, model, context)

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

home="$HOME"
short_cwd="${cwd/#$home/\~}"

git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree --no-optional-locks >/dev/null 2>&1; then
    git_branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
                 || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

parts=()
parts+=("$(printf '\033[1;36m%s\033[0m' "$short_cwd")")

if [ -n "$git_branch" ]; then
    parts+=("$(printf '\033[35m %s\033[0m' "$git_branch")")
fi

if [ -n "$model" ]; then
    parts+=("$(printf '\033[2m%s\033[0m' "$model")")
fi

if [ -n "$used_pct" ]; then
    used_int=$(printf '%.0f' "$used_pct")
    if [ "$used_int" -ge 80 ]; then
        color='\033[31m'
    elif [ "$used_int" -ge 50 ]; then
        color='\033[33m'
    else
        color='\033[2m'
    fi
    parts+=("$(printf "${color}ctx:%d%%\033[0m" "$used_int")")
fi

printf '%s' "${parts[0]}"
for part in "${parts[@]:1}"; do
    printf '  %s' "$part"
done
printf '\n'
