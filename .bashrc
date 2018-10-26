# universal bashrc

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10240
HISTFILESIZE=2048

shopt -s checkwinsize
shopt -s globstar

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [ `uname`=="*BSD" ] ; then
	[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"
fi

# colors!
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
    	else
		color_prompt=
    	fi
fi

if [ "$color_prompt" = yes ]; then
	if [[ $EUID -ne 0 ]] ; then
		PS1='\[\e[00;32m\]\u \[\e[01;34m\]\w \[\e[00;00m\]\$ '
	else
		PS1='\[\e[00;31m\]\w \[\e[00;00m\]\$ '
	fi
else
	if [[ $EUID -ne 0 ]] ; then
		PS1='\u \w \$'
	else
		PS1='\w \$ '
	fi
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ `uname`=="Linux" ] ; then
	if [ -x /usr/bin/dircolors ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
		alias ls='ls --color=auto'
		alias dir='dir --color=auto'
    		alias vdir='vdir --color=auto'

    		alias grep='grep --color=auto'
    		alias fgrep='fgrep --color=auto'
    		alias egrep='egrep --color=auto'
		alias diff='diff --color=auto'
	fi
elif [ `uname`=="*BSD" ] ; then
	alias ls='ls -G'
	alias grep='grep --color=auto'
	alias egrep='egrep --color=auto'
	alias fgrep='fgrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# colorised man
export LESS_TERMCAP_mb=$'\e[1;34m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_us=$'\e[1;36m'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# escape from errors while moving/delete
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# colourful pacman
alias pacman='pacman --color=always'

# battery stats alias for my palmpc
alias htc_battery='cat /sys/class/power_supply/battery/capacity'

# lovely term
alias rxvt='urxvtc'
alias xterm='urxvtc'

# tmux in utf-8 by default
alias tmux='tmux -u'

# ssh compatibility mode
if [ "$SSH_TTY" ]; then
	TERM=screen
	if [[ $EUID -ne 0 ]] ; then
		PS1='\[\e[00;32m\]\u\[\e[00;00m\]@\[\e[00;36m\]\h \[\e[00;00m\]\w \$ '
	else
		PS1='\[\e[00;36m\]\h \[\e[00;00m\]\w \$ '
	fi
fi

# shell title in wm
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h:\w\a\]$PS1"
    ;;
*)
    ;;
esac

# error codes in prompt
PS1="\$(err=\$? ; if [[ \$err != 0 ]]; then echo \"\[\e[0;31m\]\$err\\[\e[00;00m\]|\"; fi)$PS1"

# PS2
if [[ $EUID -ne 0 ]] ; then
	PS2="\[\e[00;32m\]>>\[\e[00;00m\] "
else
	PS2="\[\e[00;31m\]>>\[\e[00;00m\] "
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  	if [ -f /usr/share/bash-completion/bash_completion ]; then
    		. /usr/share/bash-completion/bash_completion
  	elif [ -f /etc/bash_completion ]; then
    		. /etc/bash_completion
  	elif [ -f /usr/local/share/bash-completion/bash_completion.sh ]; then
  		source "/usr/local/share/bash-completion/bash_completion.sh"
	fi
fi
