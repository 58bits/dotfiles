#!/bin/bash
# Adapted from Erik Westrup's https://github.com/erikw/tmux-powerline
_formatted_time() {
	echo $(date +"$tmux_conf_date_format")
	return 0
}

_formatted_time
