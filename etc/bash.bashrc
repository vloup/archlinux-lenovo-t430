# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# auto change directory
shopt -s autocd

# Change the window title of X terminals 
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " \[\033[01;33m\]%s")\[\033[00m\]\$ '
	else
		PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " \[\033[01;33m\]%s")\[\033[00m\]\$ '
	fi

	alias ls="ls --color=auto"
	alias dir="dir --color=auto"
	alias grep="grep --color=auto"
	alias dmesg="dmesg --color"
else
	if [[ ${EUID} == 0 ]] ; then
		PS1='\u@\h:\w$(__git_ps1 " %s")\$ '
	else
		PS1='\u@\h:\w$(__git_ps1 " %s")\$ '
	fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

# Try to enable the auto-completion (type: "pacman -S bash-completion" to install it).
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Try to enable the "Command not found" hook ("pacman -S pkgfile" to install it).
# See also: https://wiki.archlinux.org/index.php/Bash#The_.22command_not_found.22_hook
[ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash

# Try to enable git-prompt
[ -r /usr/share/git/completion/git-prompt.sh ] && . /usr/share/git/completion/git-prompt.sh

# path
#export PATH="/usr/lib/ccache/bin:$PATH"

# aliases
alias rm="rm --preserve-root"
alias nvidia-settings="optirun -b none nvidia-settings -c :8"
alias :q="exit"
alias cd..="cd .."
alias ll="ls -l"
alias la="ls -a"

# completion
complete -cf optirun
complete -cf primusrun
complete -cf sudo

# editor
export EDITOR=/usr/bin/vim

# history size
export HISTSIZE=2000
