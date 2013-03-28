#!/bin/bash
# Some simple aliases/functions to help me out in my day-to-day

sup() {
	# Simple usage help
	if [[ $# -eq 0 ]]; then
		echo 'Usage: sup <clientname>'
		return 1
	fi

	# Check to make sure it exists, error if not
	local base=$HOME/SitePen/Support/svn/support/clients;
	if [[ ! -d  "$base/$1" ]]; then
		echo "No directory for $1"
		return 2
	fi

	# If we're here, it exists, so go there
	cd $base/$1;
}
_sup() {
	local cur base
	base=$HOME/SitePen/Support/svn/support/clients
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"

	local files=$(for f in `ls -1 $base`; do echo `basename $f`; done)
	COMPREPLY=( $(compgen -W "${files}" -- ${cur}) )
	return 0
}
complete -F _sup sup
