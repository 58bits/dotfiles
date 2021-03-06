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
  formated_uptime=$(awk -v boot="$boot" -v now="$now" '
    BEGIN {
      uptime = now - boot
      d = int(uptime / 86400)
      h = int(uptime / 3600) % 24
      m = int(uptime / 60) % 60
      s = int(uptime) % 60

      df = (d > 0) ? d"d " : ""
      hf = (h > 0) ? h"h " : ""
      mf = (m > 0) ? m"m " : ""
      sf = (s > 0) ? s"s " : ""
      
      print df hf mf;
    }')
  
  echo "" "↑ $formated_uptime"
  return 0
}

_uptime
