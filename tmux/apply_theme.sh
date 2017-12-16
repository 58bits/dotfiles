#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux
_is_enabled() {
  ( ([ x"$1" = x"enabled" ] || [ x"$1" = x"true" ] || [ x"$1" = x"yes" ] || [ x"$1" = x"1" ]) && return 0 ) || return 1
}

_apply_theme() {

  # -- panes -------------------------------------------------------------

  tmux_conf_theme_window_fg=${tmux_conf_theme_window_fg:-default}
  tmux_conf_theme_window_bg=${tmux_conf_theme_window_bg:-default}
  tmux_conf_theme_highlight_focused_pane=${tmux_conf_theme_highlight_focused_pane:-false}
  tmux_conf_theme_focused_pane_fg=${tmux_conf_theme_focused_pane_fg:-'default'} # default
  tmux_conf_theme_focused_pane_bg=${tmux_conf_theme_focused_pane_bg:-'#0087d7'} # light blue

  # tmux 1.9 doesn't really like set -q
  if tmux show -g -w | grep -q window-style; then
    tmux setw -g window-style "fg=$tmux_conf_theme_window_fg,bg=$tmux_conf_theme_window_bg"

    if _is_enabled "$tmux_conf_theme_highlight_focused_pane"; then
      tmux setw -g window-active-style "fg=$tmux_conf_theme_focused_pane_fg,bg=$tmux_conf_theme_focused_pane_bg"
    else
      tmux setw -g window-active-style default
    fi
  fi

  tmux_conf_theme_pane_border_style=${tmux_conf_theme_pane_border_style:-thin}
  tmux_conf_theme_pane_border=${tmux_conf_theme_pane_border:-'#444444'}               # light gray
  tmux_conf_theme_pane_active_border=${tmux_conf_theme_pane_active_border:-'#00afff'} # light blue
  tmux_conf_theme_pane_border_fg=${tmux_conf_theme_pane_border_fg:-$tmux_conf_theme_pane_border}
  tmux_conf_theme_pane_active_border_fg=${tmux_conf_theme_pane_active_border_fg:-$tmux_conf_theme_pane_active_border}
  case "$tmux_conf_theme_pane_border_style" in
    fat)
      tmux_conf_theme_pane_border_bg=${tmux_conf_theme_pane_border_bg:-$tmux_conf_theme_pane_border_fg}
      tmux_conf_theme_pane_active_border_bg=${tmux_conf_theme_pane_active_border_bg:-$tmux_conf_theme_pane_active_border_fg}
      ;;
    thin|*)
      tmux_conf_theme_pane_border_bg=${tmux_conf_theme_pane_border_bg:-'default'}
      tmux_conf_theme_pane_active_border_bg=${tmux_conf_theme_pane_active_border_bg:-'default'}
      ;;
  esac
  tmux setw -g pane-border-style "fg=$tmux_conf_theme_pane_border_fg,bg=$tmux_conf_theme_pane_border_bg" \; set -g pane-active-border-style "fg=$tmux_conf_theme_pane_active_border_fg,bg=$tmux_conf_theme_pane_active_border_bg"

  tmux_conf_theme_pane_indicator=${tmux_conf_theme_pane_indicator:-'#00afff'}               # light blue
  tmux_conf_theme_pane_active_indicator=${tmux_conf_theme_pane_active_indicator:-'#00afff'} # light blue

  tmux set -g display-panes-colour "$tmux_conf_theme_pane_indicator" \; set -g display-panes-active-colour "$tmux_conf_theme_pane_active_indicator"

  # -- status line -------------------------------------------------------

  tmux_conf_theme_left_separator_main=${tmux_conf_theme_left_separator_main-''}
  tmux_conf_theme_left_separator_sub=${tmux_conf_theme_left_separator_sub-'|'}
  tmux_conf_theme_right_separator_main=${tmux_conf_theme_right_separator_main-''}
  tmux_conf_theme_right_separator_sub=${tmux_conf_theme_right_separator_sub-'|'}

  tmux_conf_theme_message_fg=${tmux_conf_theme_message_fg:-'#000000'}   # black
  tmux_conf_theme_message_bg=${tmux_conf_theme_message_bg:-'#ffff00'}   # yellow
  tmux_conf_theme_message_attr=${tmux_conf_theme_message_attr:-'bold'}
  tmux set -g message-style "fg=$tmux_conf_theme_message_fg,bg=$tmux_conf_theme_message_bg,$tmux_conf_theme_message_attr"

  tmux_conf_theme_message_command_fg=${tmux_conf_theme_message_command_fg:-'#ffff00'} # yellow
  tmux_conf_theme_message_command_bg=${tmux_conf_theme_message_command_bg:-'#000000'} # black
  tmux_conf_theme_message_command_attr=${tmux_conf_theme_message_command_attr:-'bold'}
  tmux set -g message-command-style "fg=$tmux_conf_theme_message_command_fg,bg=$tmux_conf_theme_message_command_bg,$tmux_conf_theme_message_command_attr"

  tmux_conf_theme_mode_fg=${tmux_conf_theme_mode_fg:-'#000000'} # black
  tmux_conf_theme_mode_bg=${tmux_conf_theme_mode_bg:-'#ffff00'} # yellow
  tmux_conf_theme_mode_attr=${tmux_conf_theme_mode_attr:-'bold'}
  tmux setw -g mode-style "fg=$tmux_conf_theme_mode_fg,bg=$tmux_conf_theme_mode_bg,$tmux_conf_theme_mode_attr"

  tmux_conf_theme_status_fg=${tmux_conf_theme_status_fg:-'#8a8a8a'} # white
  tmux_conf_theme_status_bg=${tmux_conf_theme_status_bg:-'#080808'} # dark gray
  tmux_conf_theme_status_attr=${tmux_conf_theme_status_attr:-'none'}
  tmux  set -g status-style "fg=$tmux_conf_theme_status_fg,bg=$tmux_conf_theme_status_bg,$tmux_conf_theme_status_attr"        \;\
        set -g status-left-style "fg=$tmux_conf_theme_status_fg,bg=$tmux_conf_theme_status_bg,$tmux_conf_theme_status_attr"   \;\
        set -g status-right-style "fg=$tmux_conf_theme_status_fg,bg=$tmux_conf_theme_status_bg,$tmux_conf_theme_status_attr"

  tmux_conf_theme_window_status_fg=${tmux_conf_theme_window_status_fg:-'#8a8a8a'} # white
  tmux_conf_theme_window_status_bg=${tmux_conf_theme_window_status_bg:-'#080808'} # dark gray
  tmux_conf_theme_window_status_attr=${tmux_conf_theme_window_status_attr:-'none'}
  tmux_conf_theme_window_status_format=${tmux_conf_theme_window_status_format:-'#I #W'}

  tmux_conf_theme_window_status_current_fg=${tmux_conf_theme_window_status_current_fg:-'#000000'} # black
  tmux_conf_theme_window_status_current_bg=${tmux_conf_theme_window_status_current_bg:-'#00afff'} # light blue
  tmux_conf_theme_window_status_current_attr=${tmux_conf_theme_window_status_current_attr:-'bold'}
  tmux_conf_theme_window_status_current_format=${tmux_conf_theme_window_status_current_format:-'#I #W'}
  if [ x"$(tmux show -g -v status-justify)" = x"right" ]; then
    tmux_conf_theme_window_status_current_format="#[fg=$tmux_conf_theme_window_status_current_bg,bg=$tmux_conf_theme_window_status_bg]$tmux_conf_theme_right_separator_main#[fg=default,bg=default,default] $tmux_conf_theme_window_status_current_format #[fg=$tmux_conf_theme_window_status_bg,bg=$tmux_conf_theme_window_status_current_bg,none]$tmux_conf_theme_right_separator_main"
  else
    tmux_conf_theme_window_status_current_format="#[fg=$tmux_conf_theme_window_status_bg,bg=$tmux_conf_theme_window_status_current_bg]$tmux_conf_theme_left_separator_main#[fg=default,bg=default,default] $tmux_conf_theme_window_status_current_format #[fg=$tmux_conf_theme_window_status_current_bg,bg=$tmux_conf_theme_status_bg,none]$tmux_conf_theme_left_separator_main"
  fi

  tmux_conf_theme_window_status_format=$(echo "$tmux_conf_theme_window_status_format" | sed 's%#{circled_window_index}%#(sh -s _circled_digit #I)%g')
  tmux_conf_theme_window_status_current_format=$(echo "$tmux_conf_theme_window_status_current_format" | sed 's%#{circled_window_index}%#(sh -s _circled_digit #I)%g')

  tmux  setw -g window-status-style "fg=$tmux_conf_theme_window_status_fg,bg=$tmux_conf_theme_window_status_bg,$tmux_conf_theme_window_status_attr" \;\
        setw -g window-status-format "$tmux_conf_theme_window_status_format" \;\
        setw -g window-status-current-style "fg=$tmux_conf_theme_window_status_current_fg,bg=$tmux_conf_theme_window_status_current_bg,$tmux_conf_theme_window_status_current_attr" \;\
        setw -g window-status-current-format "$tmux_conf_theme_window_status_current_format"

  tmux_conf_theme_window_status_activity_fg=${tmux_conf_theme_window_status_activity_fg:-'default'}
  tmux_conf_theme_window_status_activity_bg=${tmux_conf_theme_window_status_activity_bg:-'default'}
  tmux_conf_theme_window_status_activity_attr=${tmux_conf_theme_window_status_activity_attr:-'underscore'}
  tmux setw -g window-status-activity-style "fg=$tmux_conf_theme_window_status_activity_fg,bg=$tmux_conf_theme_window_status_activity_bg,$tmux_conf_theme_window_status_activity_attr"

  tmux_conf_theme_window_status_bell_fg=${tmux_conf_theme_window_status_bell_fg:-'#ffff00'} # yellow
  tmux_conf_theme_window_status_bell_bg=${tmux_conf_theme_window_status_bell_bg:-'default'}
  tmux_conf_theme_window_status_bell_attr=${tmux_conf_theme_window_status_bell_attr:-'blink,bold'}
  tmux setw -g window-status-bell-style "fg=$tmux_conf_theme_window_status_bell_fg,bg=$tmux_conf_theme_window_status_bell_bg,$tmux_conf_theme_window_status_bell_attr"

  tmux_conf_theme_window_status_last_fg=${tmux_conf_theme_window_status_last_fg:-'#00afff'} # light blue
  tmux_conf_theme_window_status_last_bg=${tmux_conf_theme_window_status_last_bg:-'default'}
  tmux_conf_theme_window_status_last_attr=${tmux_conf_theme_window_status_last_attr:-'none'}
  tmux setw -g window-status-last-style "fg=$tmux_conf_theme_window_status_last_fg,bg=$tmux_conf_theme_window_status_last_bg,$tmux_conf_theme_window_status_last_attr"

  # -- indicators

  tmux_conf_theme_pairing=${tmux_conf_theme_pairing:-'👓'}            # U+1F453
  tmux_conf_theme_pairing_fg=${tmux_conf_theme_pairing_fg:-'#e4e4e4'} # white
  tmux_conf_theme_pairing_bg=${tmux_conf_theme_pairing_bg:-'none'}
  tmux_conf_theme_pairing_attr=${tmux_conf_theme_pairing_attr:-'none'}

  tmux_conf_theme_prefix=${tmux_conf_theme_prefix:-'⌨'}             # U+2328
  tmux_conf_theme_prefix_fg=${tmux_conf_theme_prefix_fg:-'#e4e4e4'} # white
  tmux_conf_theme_prefix_bg=${tmux_conf_theme_prefix_bg:-'none'}
  tmux_conf_theme_prefix_attr=${tmux_conf_theme_prefix_attr:-'none'}

  tmux_conf_theme_root=${tmux_conf_theme_root:-'!'}
  tmux_conf_theme_root_fg=${tmux_conf_theme_root_fg:-'none'}
  tmux_conf_theme_root_bg=${tmux_conf_theme_root_bg:-'none'}
  tmux_conf_theme_root_attr=${tmux_conf_theme_root_attr:-'bold,blink'}

  # -- status left style

  tmux_conf_theme_status_left=${tmux_conf_theme_status_left-' ❐ #S '}
  tmux_conf_theme_status_left_fg=${tmux_conf_theme_status_left_fg:-'#000000,#e4e4e4,#e4e4e4'}  # black, white , white
  tmux_conf_theme_status_left_bg=${tmux_conf_theme_status_left_bg:-'#ffff00,#ff00af,#00afff'}  # yellow, pink, white blue
  tmux_conf_theme_status_left_attr=${tmux_conf_theme_status_left_attr:-'bold,none,none'}

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg]#[bg=$tmux_conf_theme_pairing_bg]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing,}/g")

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg]#[bg=$tmux_conf_theme_prefix_bg]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix,}/g")

  tmux_conf_theme_status_left=$(echo "$tmux_conf_theme_status_left" | sed \
    -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg]#[bg=$tmux_conf_theme_root_bg]#[$tmux_conf_theme_root_attr]#(sh -s _root #{pane_tty} #D)#[inherit]%g")

  if [ -n "$tmux_conf_theme_status_left" ]; then
    status_left=$(awk \
                      -v fg_="$tmux_conf_theme_status_left_fg" \
                      -v bg_="$tmux_conf_theme_status_left_bg" \
                      -v attr_="$tmux_conf_theme_status_left_attr" \
                      -v mainsep="$tmux_conf_theme_left_separator_main" \
                      -v subsep="$tmux_conf_theme_left_separator_sub" '
      function subsplit(s,   l, i, a, r)
      {
        l = split(s, a, ",")
        for (i = 1; i <= l; ++i)
        {
          o = split(a[i], _, "(") - 1
          c = split(a[i], _, ")") - 1
          open += o - c
          o_ = split(a[i], _, "{") - 1
          c_ = split(a[i], _, "}") - 1
          open_ += o_ - c_
          o__ = split(a[i], _, "[") - 1
          c__ = split(a[i], _, "]") - 1
          open__ += o__ - c__

          if (i == l)
            r = sprintf("%s%s", r, a[i])
          else if (open || open_ || open__)
            r = sprintf("%s%s,", r, a[i])
          else
            r = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", r, a[i], fg[j], bg[j], attr[j], subsep)
        }

        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
        return r
      }
      BEGIN {
        FS = "|"
        l1 = split(fg_, fg, ",")
        l2 = split(bg_, bg, ",")
        l3 = split(attr_, attr, ",")
        l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
      }
      {
        for (i = j = 1; i <= NF; ++i)
        {
          if (open || open_ || open__)
            printf "|%s", subsplit($i)
          else
          {
            if (i > 1)
              printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j_], bg[j], mainsep, fg[j], bg[j], attr[j], subsplit($i)
            else
              printf "#[fg=%s,bg=%s,%s]%s", fg[j], bg[j], attr[j], subsplit($i)
          }

          if (!open && !open_ && !open__)
          {
            j_ = j
            j = j % l + 1
          }
        }
        printf "#[fg=%s,bg=%s,none]%s", bg[j_], "default", mainsep
      }' << EOF
$tmux_conf_theme_status_left
EOF
    )
  fi

  status_left="$status_left "

  # -- status right style

  tmux_conf_theme_status_right=${tmux_conf_theme_status_right-'#{pairing}#{prefix} #{battery_status} #{battery_bar} #{battery_percentage} , %R , %d %b | #{username} | #{hostname} '}
  tmux_conf_theme_status_right_fg=${tmux_conf_theme_status_right_fg:-'#8a8a8a,#e4e4e4,#000000'} # light gray, white, black
  tmux_conf_theme_status_right_bg=${tmux_conf_theme_status_right_bg:-'#080808,#d70000,#e4e4e4'} # dark gray, red, white
  tmux_conf_theme_status_right_attr=${tmux_conf_theme_status_right_attr:-'none,none,bold'}

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg]#[bg=$tmux_conf_theme_pairing_bg]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing,}/g")

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg]#[bg=$tmux_conf_theme_prefix_bg]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix,}/g")

  tmux_conf_theme_status_right=$(echo "$tmux_conf_theme_status_right" | sed \
    -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg]#[bg=$tmux_conf_theme_root_bg]#[$tmux_conf_theme_root_attr]#(sh -s _root #{pane_tty} #D)#[inherit]%g")

  if [ -n "$tmux_conf_theme_status_right" ]; then
    status_right=$(awk \
                      -v fg_="$tmux_conf_theme_status_right_fg" \
                      -v bg_="$tmux_conf_theme_status_right_bg" \
                      -v attr_="$tmux_conf_theme_status_right_attr" \
                      -v mainsep="$tmux_conf_theme_right_separator_main" \
                      -v subsep="$tmux_conf_theme_right_separator_sub" '
      function subsplit(s,   l, i, a, r)
      {
        l = split(s, a, ",")
        for (i = 1; i <= l; ++i)
        {
          o = split(a[i], _, "(") - 1
          c = split(a[i], _, ")") - 1
          open += o - c
          o_ = split(a[i], _, "{") - 1
          c_ = split(a[i], _, "}") - 1
          open_ += o_ - c_
          o__ = split(a[i], _, "[") - 1
          c__ = split(a[i], _, "]") - 1
          open__ += o__ - c__

          if (i == l)
            r = sprintf("%s%s", r, a[i])
          else if (open || open_ || open__)
            r = sprintf("%s%s,", r, a[i])
          else
            r = sprintf("%s%s#[fg=%s,bg=%s,%s]%s", r, a[i], fg[j], bg[j], attr[j], subsep)
        }

        gsub(/#\[inherit\]/, sprintf("#[default]#[fg=%s,bg=%s,%s]", fg[j], bg[j], attr[j]), r)
        return r
      }
      BEGIN {
        FS = "|"
        l1 = split(fg_, fg, ",")
        l2 = split(bg_, bg, ",")
        l3 = split(attr_, attr, ",")
        l = l1 < l2 ? (l1 < l3 ? l1 : l3) : (l2 < l3 ? l2 : l3)
      }
      {
        for (i = j = 1; i <= NF; ++i)
        {
          if (open_ || open || open__)
            printf "|%s", subsplit($i)
          else
            printf "#[fg=%s,bg=%s,none]%s#[fg=%s,bg=%s,%s]%s", bg[j], (i == 1) ? "default" : bg[j_], mainsep, fg[j], bg[j], attr[j], subsplit($i)

          if (!open && !open_ && !open__)
          {
            j_ = j
            j = j % l + 1
          }
        }
      }' << EOF
$tmux_conf_theme_status_right
EOF
    )
  fi

  # -- variables

  #tmux set -g '@root' "$tmux_conf_theme_root"

  #tmux_conf_battery_bar_symbol_full=${tmux_conf_battery_bar_symbol_full:-'◼'}
  #tmux_conf_battery_bar_symbol_empty=${tmux_conf_battery_bar_symbol_empty:-'◻'}
  #tmux_conf_battery_bar_length=${tmux_conf_battery_bar_length:-'auto'}
  #tmux_conf_battery_bar_palette=${tmux_conf_battery_bar_palette:-'gradient'}
  #tmux_conf_battery_hbar_palette=${tmux_conf_battery_hbar_palette:-'gradient'} # red, orange, green
  #tmux_conf_battery_vbar_palette=${tmux_conf_battery_vbar_palette:-'gradient'} # red, orange, green
  #tmux_conf_battery_status_charging=${tmux_conf_battery_status_charging:-'↑'}       # U+2191
  #tmux_conf_battery_status_discharging=${tmux_conf_battery_status_discharging:-'↓'} # U+2193

  #case "$status_left $status_right" in
  #  *'#{battery_status}'*|*'#{battery_bar}'*|*'#{battery_hbar}'*|*'#{battery_vbar}'*|*'#{battery_percentage}'*)
  #    status_left=$(echo "$status_left" | sed -E \
  #      -e 's/#\{(\?)?battery_bar/#\{\1@battery_bar/g' \
  #      -e 's/#\{(\?)?battery_hbar/#\{\1@battery_hbar/g' \
  #      -e 's/#\{(\?)?battery_vbar/#\{\1@battery_vbar/g' \
  #      -e 's/#\{(\?)?battery_status/#\{\1@battery_status/g' \
  #      -e 's/#\{(\?)?battery_percentage/#\{\1@battery_percentage/g')
  #    status_right=$(echo "$status_right" | sed -E \
  #      -e 's/#\{(\?)?battery_bar/#\{\1@battery_bar/g' \
  #      -e 's/#\{(\?)?battery_hbar/#\{\1@battery_hbar/g' \
  #      -e 's/#\{(\?)?battery_vbar/#\{\1@battery_vbar/g' \
  #      -e 's/#\{(\?)?battery_status/#\{\1@battery_status/g' \
  #      -e 's/#\{(\?)?battery_percentage/#\{\1@battery_percentage/g')

  #    tmux  set -g '@battery_bar_symbol_full' "$tmux_conf_battery_bar_symbol_full" \;\
  #          set -g '@battery_bar_symbol_empty' "$tmux_conf_battery_bar_symbol_empty" \;\
  #          set -g '@battery_bar_length' "$tmux_conf_battery_bar_length" \;\
  #          set -g '@battery_bar_palette' "$tmux_conf_battery_bar_palette" \;\
  #          set -g '@battery_hbar_palette' "$tmux_conf_battery_hbar_palette" \;\
  #          set -g '@battery_vbar_palette' "$tmux_conf_battery_vbar_palette" \;\
  #          set -g '@battery_status_charging' "$tmux_conf_battery_status_charging" \;\
  #          set -g '@battery_status_discharging' "$tmux_conf_battery_status_discharging"
  #    status_right="#(cut -c3- ~/.tmux.conf | sh -s _battery)$status_right"
  #    ;;
  #esac
  
  
  case "$status_left $status_right" in
    *'#{username}'*|*'#{hostname}'*|*'#{username_ssh}'*|*'#{hostname_ssh}'*)
      status_left=$(echo "$status_left" | sed \
        -e 's%#{username}%#(~/.tmux/username.sh #{pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(~/.tmux/hostname.sh #{pane_tty} false #D)%g' \
        -e 's%#{username_ssh}%#(~/.tmux/username.sh #{pane_tty} false #D)%g' \
        -e 's%#{hostname_ssh}%#(~/.tmux/hostname.sh #{pane_tty} false #D)%g')
      status_right=$(echo "$status_right" | sed \
        -e 's%#{username}%#(~/.tmux/username.sh #{pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(~/.tmux/hostname.sh #{pane_tty} false #D)%g' \
        -e 's%#{username_ssh}%#(~/.tmux/username.sh #{pane_tty} false #D)%g' \
        -e 's%#{hostname_ssh}%#(~/.tmux/hostname.sh #{pane_tty} false #D)%g')
      ;;
  esac

  case "$status_left $status_right" in
    *'#{uptime_d}'*|*'#{uptime_h}'*|*'#{uptime_m}'*)
      status_left=$(echo "$status_left" | sed -E \
        -e 's/#\{(\?)?uptime_d/#\{\1@uptime_d/g' \
        -e 's/#\{(\?)?uptime_h/#\{\1@uptime_h/g' \
        -e 's/#\{(\?)?uptime_m/#\{\1@uptime_m/g' \
        -e 's/#\{(\?)?uptime_s/#\{\1@uptime_s/g')
      status_right=$(echo "$status_right" | sed -E \
        -e 's/#\{(\?)?uptime_d/#\{\1@uptime_d/g' \
        -e 's/#\{(\?)?uptime_h/#\{\1@uptime_h/g' \
        -e 's/#\{(\?)?uptime_m/#\{\1@uptime_m/g' \
        -e 's/#\{(\?)?uptime_s/#\{\1@uptime_s/g')
      #status_right="#(sh -s _uptime)$status_right"
      status_right="#(~/.tmux/uptime.sh)$status_right"
      ;;
  esac

  case "$status_left $status_right" in
    *'#{loadavg}'*)
      status_left=$(echo "$status_left" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_right=$(echo "$status_right" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_right="#{_loadavg}$status_right"
      ;;
  esac

  status_right=$(echo "$status_right" | sed 's%#{circled_session_name}%#(_circled_digit #S)%g')
  status_left=$(echo "$status_left" | sed 's%#{circled_session_name}%#(_circled_digit #S)%g')

  tmux  set -g status-left-length 1000 \; set -g status-left "$status_left" \;\
        set -g status-right-length 1000 \; set -g status-right "$status_right"

  # -- clock -------------------------------------------------------------

  tmux_conf_theme_clock_colour=${tmux_conf_theme_clock_colour:-'#00afff'} # light blue
  tmux_conf_theme_clock_style=${tmux_conf_theme_clock_style:-'24'}
  tmux  setw -g clock-mode-colour "$tmux_conf_theme_clock_colour" \;\
        setw -g clock-mode-style "$tmux_conf_theme_clock_style"

}

_apply_theme
