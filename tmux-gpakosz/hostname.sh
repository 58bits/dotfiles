#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_hostname() {
  tty=${1:-$(tmux display -p '#{pane_tty}')}
  ssh_only=$2
  # shellcheck disable=SC2039
  if [ x"$OSTYPE" = x"cygwin" ]; then
    pid=$(ps -a | awk -v tty="${tty##/dev/}" '$5 == tty && /ssh/ && !/vagrant ssh/ && !/autossh/ && !/-W/ { print $1 }')
    [ -n "$pid" ] && ssh_parameters=$(tr '\0' ' ' < "/proc/$pid/cmdline" | sed 's/^ssh //')
  else
    ssh_parameters=$(ps -t "$tty" -o command= | awk '/ssh/ && !/vagrant ssh/ && !/autossh/ && !/-W/ { $1=""; print $0; exit }')
  fi
  if [ -n "$ssh_parameters" ]; then
    # shellcheck disable=SC2086
    hostname=$(ssh -G $ssh_parameters 2>/dev/null | awk 'NR > 2 { exit } ; /^hostname / { print $2 }')
    # shellcheck disable=SC2086
    [ -z "$hostname" ] && hostname=$(ssh -T -o ControlPath=none -o ProxyCommand="sh -c 'echo %%hostname%% %h >&2'" $ssh_parameters 2>&1 | awk '/^%hostname% / { print $2; exit }')
    #shellcheck disable=SC1004
    hostname=$(echo "$hostname" | awk '\
    { \
      if ($1~/^[0-9.:]+$/) \
        print $1; \
      else \
        split($1, a, ".") ; print a[1] \
    }')
  else
    if ! _is_enabled "$ssh_only"; then
      hostname=$(command hostname -s)
    fi
  fi

  echo "$hostname"
}

_hostname
