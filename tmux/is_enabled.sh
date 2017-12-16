#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_is_enabled() {
  ( ([ x"$1" = x"enabled" ] || [ x"$1" = x"true" ] || [ x"$1" = x"yes" ] || [ x"$1" = x"1" ]) && return 0 ) || return 1
}
_is_enabled
