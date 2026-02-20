#!/usr/bin/env bash
# Battery for tmux status bar (macOS only)
# Shows when discharging and ≤75%; color-coded by level
[[ "$(uname)" == "Darwin" ]] || exit 0

batt_info=$(pmset -g batt 2>/dev/null) || exit 0
[[ "$batt_info" == *"discharging"* ]] || exit 0

pct=$(grep -o '[0-9]*%' <<< "$batt_info" | head -1 | tr -d '%')
[[ -n "$pct" ]] || exit 0
(( pct > 75 )) && exit 0

if (( pct <= 20 )); then
  printf ' #[fg=colour1,bold]%s%%' "$pct"
elif (( pct <= 50 )); then
  printf ' #[fg=colour3]%s%%' "$pct"
else
  printf ' #[fg=colour2]%s%%' "$pct"
fi
