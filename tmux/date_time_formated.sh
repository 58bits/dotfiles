#!/bin/bash
# Adapted from Erik Westrup's https://github.com/erikw/tmux-powerline

_formatted_date_time() {
	echo "" $(date +"%a") $tmux_conf_theme_right_separator_sub $(date +"$tmux_conf_date_format") $tmux_conf_theme_right_separator_sub $(date +"$tmux_conf_time_format") ""
	return 0
}

_formatted_date_time
