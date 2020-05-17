#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_loadavg() {
  case $(uname -s) in
    *Darwin*)
      tmux set -g @loadavg "$(sysctl -q -n vm.loadavg | cut -d' ' -f2)"
      ;;
    *Linux*)
      tmux set -g @loadavg "$(cut -d' ' -f1 < /proc/loadavg)"
      ;;
    *OpenBSD*)
      tmux set -g @loadavg "$(sysctl -q -n vm.loadavg | cut -d' ' -f1)"
      ;;
  esac
}

_loadavg
