#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_root() {
  tty=${1:-$(tmux display -p '#{pane_tty}')}
  username=$(_username "$tty" false)

  if [ x"$username" = x"root" ]; then
    tmux show -gqv '@root'
  else
    echo ""
  fi
}

_root
