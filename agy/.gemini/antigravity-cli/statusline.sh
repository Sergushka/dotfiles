#!/bin/sh
out=$(jq -r --arg home "$HOME" '
  (.workspace.current_dir // .cwd // "") as $raw |
  ($raw | if . == $home then "~"
          elif startswith($home + "/") then "~" + .[$home | length:]
          else . end) as $dir |
  (.vcs.type // "") as $vcs |
  (.model.display_name // .model.id // "") as $m |
  (.model.effort // "") as $e |
  (if $m == "" then ""
   elif $e != "" and (($m | ascii_downcase | endswith("(" + ($e | ascii_downcase) + ")")) | not)
     then "\($m) (\($e))"
   else $m end) as $model |
  .context_window.used_percentage as $pct |
  (if $pct == null then "\u001b[2m░░░░░░░░░░ --\u001b[0m"
   else
     ((($pct * 10) | round) / 10) as $disp |
     ((($pct / 10) | round) | if . < 0 then 0 elif . > 10 then 10 else . end) as $n |
     (if $disp > 50 then "\u001b[1;31m" else "\u001b[32m" end) as $c |
     "\($c)\(("█" * $n) // "")\u001b[0;2m\(("░" * (10 - $n)) // "")\u001b[0m \($c)\($disp)%\u001b[0m"
   end) as $ctx |
  $raw, $dir, $vcs, $model, $ctx
') || exit 0

{
  IFS= read -r raw
  IFS= read -r dir
  IFS= read -r vcs
  IFS= read -r model
  IFS= read -r ctx
} <<EOF
$out
EOF

branch=""
if [ "$vcs" = "git" ] && [ -n "$raw" ]; then
  # Fast path avoids spawning git at repo root.
  if [ -f "$raw/.git/HEAD" ] && IFS= read -r head < "$raw/.git/HEAD"; then
    case "$head" in
      ref:\ refs/heads/*) branch=${head#ref: refs/heads/} ;;
      *) branch=$(printf '%.7s' "$head") ;;
    esac
  elif [ -d "$raw" ]; then
    branch=$(git -C "$raw" symbolic-ref --short HEAD 2>/dev/null || git -C "$raw" rev-parse --short HEAD 2>/dev/null)
  fi
fi

esc=$(printf '\033')
sep=" ${esc}[2m│${esc}[0m "
line=""
[ -n "$dir" ] && line="${esc}[36m${dir}${esc}[0m"
[ -n "$branch" ] && line="${line} ${esc}[35m(${branch})${esc}[0m"
[ -n "$model" ] && line="${line:+${line}${sep}}${esc}[34m${model}${esc}[0m"
printf '%s\n' "${line:+${line}${sep}}${ctx}"
