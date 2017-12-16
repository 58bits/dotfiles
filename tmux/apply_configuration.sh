#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_apply_configuration() {
  # see https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
  if command -v reattach-to-user-namespace > /dev/null 2>&1; then
    default_shell="$(tmux show -gv default-shell)"
    case "$default_shell" in
      *fish)
        tmux set -g default-command "reattach-to-user-namespace -l $default_shell"
        ;;
      *sh)
        tmux set -g default-command "exec $default_shell... 2> /dev/null & reattach-to-user-namespace -l $default_shell"
        ;;
    esac
  fi

  #_apply_overrides
  #_apply_bindings
  source ./apply_theme.sh
  for name in $(printenv | grep -Eo '^tmux_conf_[^=]+'); do tmux setenv -gu "$name"; done;
}

_apply_configuration
