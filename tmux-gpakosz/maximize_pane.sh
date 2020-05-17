#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_maximize_pane() {
  current_session=${1:-$(tmux display -p '#{session_name}')}
  current_pane=${2:-$(tmux display -p '#{pane_id}')}

  dead_panes=$(tmux list-panes -s -t "$current_session" -F '#{pane_dead} #{pane_id} #{pane_start_command}' | grep -o '^1 %.\+maximized.\+$' || true)
  restore=$(echo "$dead_panes" | sed -n -E -e "s/^1 $current_pane .+maximized.+'(%[0-9]+)'$/tmux swap-pane -s \1 -t $current_pane \; kill-pane -t $current_pane/p" -e "s/^1 (%[0-9]+) .+maximized.+'$current_pane'$/tmux swap-pane -s \1 -t $current_pane \; kill-pane -t \1/p" )

  if [ -z "$restore" ]; then
    [ "$(tmux list-panes -t "$current_session:" | wc -l | sed 's/^ *//g')" -eq 1 ] && tmux display "Can't maximize with only one pane" && return
    window=$(tmux new-window -t "$current_session:" -P "exec maximized... 2> /dev/null & tmux setw -t \"$current_session:\" remain-on-exit on; printf \"Pane has been maximized, press <prefix>+ to restore. %s\" '$current_pane'")
    window=${window%.*}

    guard=10
    while [ x"$(tmux list-panes -t "$window" -F '#{session_name}:#{window_index} #{pane_dead}' 2>/dev/null)" != x"$window 1" ] && [ "$guard" -ne 0 ]; do
      sleep 0.01
      guard=$((guard - 1))
    done
    if [ "$guard" -eq 0 ]; then
      tmux display 'Unable to maximize pane'
    fi

    new_pane=$(tmux display -t "$window" -p '#{pane_id}')
    tmux setw -t "$window" remain-on-exit off \; swap-pane -s "$current_pane" -t "$new_pane"
  else
    $restore || tmux kill-pane
  fi
}
_maximize_pane
