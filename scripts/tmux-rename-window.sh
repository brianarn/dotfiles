#!/usr/bin/env bash
# Renames a tmux window to the ticket ref in the pane's git branch
# (e.g. feature/example-123 -> EXAMPLE-123). Falls back to a blank
# rename-window prompt when no ticket-shaped branch is found.
dir="$1"
target="$2"
client="$3"

branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null)
ticket=""
[[ ${branch##*/} =~ ^([A-Za-z0-9]+-[0-9]+)($|--) ]] && ticket=$(tr '[:lower:]' '[:upper:]' <<< "${BASH_REMATCH[1]}")

if [ -n "$ticket" ]; then
  tmux rename-window -t "$target" "$ticket"
else
  tmux command-prompt -t "$client" -I "" "rename-window -t '$target' -- '%%'"
fi
