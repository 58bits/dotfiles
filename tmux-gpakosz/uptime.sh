#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux

_uptime() {
  case $(uname -s) in
    *Darwin*)
      boot=$(sysctl -q -n kern.boottime | awk -F'[ ,:]+' '{ print $4 }')
      now=$(date +%s)
      ;;
    *Linux*|*CYGWIN*|*MSYS*|*MINGW*)
      now=$(cut -d' ' -f1 < /proc/uptime)
      ;;
    *OpenBSD*)
      boot=$(sysctl -n kern.boottime)
      now=$(date +%s)
  esac
  # shellcheck disable=SC1004
  awk -v boot="$boot" -v now="$now" '
    BEGIN {
      uptime = now - boot
      d = int(uptime / 86400)
      h = int(uptime / 3600) % 24
      m = int(uptime / 60) % 60
      s = int(uptime) % 60

      system("tmux  set -g @uptime_d " d + 0 " \\; " \
                   "set -g @uptime_h " h + 0 " \\; " \
                   "set -g @uptime_m " m + 0 " \\; " \
                   "set -g @uptime_s " s + 0)
    }'
}

_uptime
