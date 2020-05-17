#!/bin/bash
# Prints the local network IPv4 address for a statically defined NIC or search for an IPv4 address on all active NICs.
# Adapted from Erik Westrup's https://github.com/erikw/tmux-powerline

_lan_ip() {
	case $(uname -s) in
		*Darwin*|*OpenBSD*)
			all_nics=$(ifconfig 2>/dev/null | awk -F':' '/^[a-z]/ && !/^lo/ { print $1 }')
			for nic in ${all_nics[@]}; do
				ipv4s_on_nic=$(ifconfig ${nic} 2>/dev/null | awk '$1 == "inet" { print $2 }')
				for lan_ip in ${ipv4s_on_nic[@]}; do
					[[ -n "${lan_ip}" ]] && break
				done
				[[ -n "${lan_ip}" ]] && break
			done
			;;
		*Linux*|*CYGWIN*|*MSYS*|*MINGW*)
			# Get the names of all attached NICs.
			all_nics="$(ip addr show | cut -d ' ' -f2 | tr -d :)"
			all_nics=(${all_nics[@]//lo/})	 # Remove lo interface.

			for nic in "${all_nics[@]}"; do
				# Parse IP address for the NIC.
				lan_ip="$(ip addr show ${nic} | grep '\<inet\>' | tr -s ' ' | cut -d ' ' -f3)"
				# Trim the CIDR suffix.
				lan_ip="${lan_ip%/*}"
				# Only display the last entry
				lan_ip="$(echo "$lan_ip" | tail -1)"

				[ -n "$lan_ip" ] && break
			done
			;;
	esac

	echo "ⓛ ${lan_ip-N/a} "
	return 0
}

_lan_ip
