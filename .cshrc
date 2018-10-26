setenv	systype		"`uname`"
setenv	userident	"`id -u`"

alias h		history 25
alias j		jobs -l
alias la	ls -aF
alias lf	ls -FA
alias ll	ls -lAF

# TODO: change to glibc detection
if ($systype == "Linux") then
	alias ls	ls --color=auto
else
	alias ls	ls -G
endif

alias grep	grep --color=auto
alias egrep	egrep --color=auto
alias fgrep	fgrep --color=auto

alias rxvt	urxvtc
alias xterm	urxvtc

alias rm	rm -i
alias mv	mv -i

alias pacman	pacman --color=always

alias htc_battery	cat /sys/class/power_supply/battery/capacity

alias tmux	tmux -u

set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin)
setenv	BLOCKSIZE	K

umask 22

setenv	EDITOR	vim
setenv	PAGER	less

# colors!
if ($systype == "*BSD") then
	set     red="%{\033[0;31m%}"
	set   green="%{\033[0;32m%}"
	set  yellow="%{\033[0;33m%}"
	set    blue="%{\033[0;34m%}"
	set magenta="%{\033[0;35m%}"
	set    cyan="%{\033[0;36m%}"
	set   white="%{\033[0;37m%}"
	set     end="%{\033[0m%}"
else
	set     red="%{\033[0;31m%}"
	set   green="%{\033[0;32m%}"
	set  yellow="%{\033[0;33m%}"
	set    blue="%{\033[0;34m%}"
	set magenta="%{\033[0;35m%}"
	set    cyan="%{\033[0;36m%}"
	set   white="%{\033[0;37m%}"
	set     end="%{\033[0m%}"
endif

# ls colors on linux machines
setenv LS_COLORS  'pi=40;33:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.mng=01;35:*.tif=01;35:*.tiff=01;35:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.rar=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.deb=01;31:*.cpio=01;31:*.7z=01;31:*.svg=01;35:*.xcf=01;35'

if ($?prompt) then

	# prompts
	if ($userident == "0") then
		set prompt = "${red}%m${cyan} %~ ${white}%# ${end}"
		set prompt2 = "${red}>>${end}"
	else
		set prompt = "${green}%N ${cyan}%~ ${white}%# ${end}"
		set prompt2 = "${green}>>${end} "
	endif
	
	# ssh compatibility mode
	if ($?SSH_TTY) then
		setenv 	TERM 	screen
		if ($userident != "0") then
			set prompt = "${green}%N${white}@${cyan}%m ${white}%~ %# ${end}"
		else
			set prompt = "${cyan}%m ${white}%~ %# ${end}"
		endif
	endif

	set promptchars = "%#"
	set filec
	set history = 10240
	set savehist = (1000 merge)
	set autolist = ambiguous
	
	set autoexpand
	set autorehash
	set mail = (/var/mail/$USER)
	if ( $?tcsh ) then
		bindkey "^W" backward-delete-word
		bindkey -k up history-search-backward
		bindkey -k down history-search-forward
	endif

endif

unset	userident
unset	systype
