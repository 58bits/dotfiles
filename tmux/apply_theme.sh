#!/bin/bash
# Adapted from Gregory Pakosz's amazing tmux config at https://github.com/gpakosz/.tmux
_apply_theme() {

  # -- panes -------------------------------------------------------------

  tmux_conf_theme_window_fg=${tmux_conf_theme_window_fg:-default}
  tmux_conf_theme_window_bg=${tmux_conf_theme_window_bg:-default}
  tmux_conf_theme_highlight_focused_pane=${tmux_conf_theme_highlight_focused_pane:-false}
  tmux_conf_theme_focused_pane_fg=${tmux_conf_theme_focused_pane_fg:-'default'} # default
  tmux_conf_theme_focused_pane_bg=${tmux_conf_theme_focused_pane_bg:-'#0087d7'} # light blue

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


  # -- date and time formats
  tmux_conf_date_format=${tmux_conf_date_format:-"%F"}
  tmux_conf_time_format=${tmux_conf_time_format:-"%H:%M"}

  # -- separators

  tmux_conf_theme_left_separator_main=${tmux_conf_theme_left_separator_main:-''}
  tmux_conf_theme_left_separator_sub=${tmux_conf_theme_left_separator_sub:-'|'}
  tmux_conf_theme_right_separator_main=${tmux_conf_theme_right_separator_main:-''}
  tmux_conf_theme_right_separator_sub=${tmux_conf_theme_right_separator_sub:-'|'}
  tmux_conf_theme_left_separator_main=${tmux_conf_theme_left_separator_main:-''} # /!\ you don't need to install Powerline
  tmux_conf_theme_left_separator_sub=${tmux_conf_theme_left_separator_sub:-''}  #   you only need fonts patched with
  tmux_conf_theme_right_separator_main=${tmux_conf_theme_right_separator_main:-''} #   Powerline symbols or the standalone
  tmux_conf_theme_right_separator_sub=${tmux_conf_theme_right_separator_sub:-''}  #   PowerlineSymbols.otf font

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

  tmux set -g status-bg colour235 \; set -g status-fg white \;\
    set -g message-fg white \; set -g message-bg colour235 \;\
    set -g message-attr bright

  # -- left status

  status_left=""
  status_left="#[fg=black,dim,bg=#d7d787]#(~/.tmux/uptime.sh)#[fg=#d7d787,bg=#005f5f]$tmux_conf_theme_left_separator_main "
  status_left=${status_left}"#[fg=white,bg=#005f5f]#(~/.tmux/hostname.sh)#[fg=#005f5f,bg=#005f87]$tmux_conf_theme_left_separator_main "
  status_left=${status_left}"#[fg=white,bg=#005faf]#(~/.tmux/lan_ip.sh)#[fg=#005faf,bg=colour235]$tmux_conf_theme_left_separator_main"

  # -- right status

  status_right=""
  #status_right=#{?client_prefix,$tmux_conf_theme_prefix,}
  status_right=${status_right}"#[fg=#005faf,bg=colour235]$tmux_conf_theme_right_separator_main#[fg=white,bg=#005faf]#(~/.tmux/date_time_formated.sh)"

  # -- set left and right status length and properties

  tmux  set -g status-left-length 1000 \; set -g status-left "$status_left" \;\
    set -g status-right-length 1000 \; set -g status-right "$status_right"

}

_apply_theme
