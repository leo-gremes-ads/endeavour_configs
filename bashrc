#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTSIZE=500
HISTFILESIZE=1000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=history:'man *':*-help:*-version:cls:clear
EDITOR=nvim

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias li='ls -li --color=auto'
alias l1='ls -1 --color=auto'
alias ll='ls -l --color=auto'
alias cls='clear'
alias bye='sudo shutdown -h now'

mkcd ()
{
	for folder in "$@"; do
		mkdir -p "$folder" &&
		cd "$folder"
	done
}

vi()
{
	if [ $# -eq 0 ]; then
		nvim .
	else
		nvim $*
	fi
}

pd()
{
	if [ $# -eq 0 ]; then
		popd > /dev/null
	elif [[ "$1" =~ ^[0-9]+$ ]]; then
		pushd +"$1" > /dev/null
	else
		pushd "$1" > /dev/null
	fi
	dirs -v
}

# VARIABLES
RED='\[\e[31;1m\]'
GREEN='\[\e[92;1m\]'
YELLOW='\[\e[93;1m\]'
BLUE='\[\e[94;1m\]'
MAGENTA='\[\e[95;1m\]'
CYAN='\[\e[96;1m\]'
RESET='\[\e[0m\]'

PS1="${BLUE} \t » Exit Status: \$? \n\n${RESET}${GREEN}┌[ ${CYAN}\u ${RESET}@ ${MAGENTA}\h ${GREEN}]-[ ${YELLOW}\w ${GREEN}]\n└ >>${RESET} "

eval "$(fzf --bash)"
alias cdf='$(__fzf_cd__)'

bind 'set completion-ignore-case on'
