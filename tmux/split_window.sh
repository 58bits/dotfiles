#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_split_window() {
  tty=${1:-$(tmux display -p '#{pane_tty}')}
  shift
  # shellcheck disable=SC2039
  if [ x"$OSTYPE" = x"cygwin" ]; then
    pid=$(ps -a | sort -d | awk -v tty="${tty##/dev/}" '$5 == tty && /ssh/ && !/-W/ { print $1; exit 0 }')
    [ -n "$pid" ] && ssh=$(tr '\0' ' ' < "/proc/$pid/cmdline")
  else
    ssh=$(ps -t "$tty" -o command= | sort -d | awk '/ssh/ && !/-W/ { print $0; exit 0 }')
  fi
  if [ -n "$ssh" ]; then
    # shellcheck disable=SC2046
    tmux split-window "$@" $(echo "$ssh" | sed -e "s/;/\\\\;/g")
  else
    tmux split-window "$@"
  fi
}

_split_window
