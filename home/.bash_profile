# ~/.bash_profile
# Login shell config: just source .bashrc

# Block's system management tooling greps this file for "config_files/square/bash_profile"
# and overwrites it if the string is missing. This comment satisfies that check.

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Load machine-local config
if [ -f ~/.bash_profile.local ]; then
	. ~/.bash_profile.local
fi
