# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
export EDITOR="${VISUAL:=vim}"
export VISUAL
export DEVHOME="/mnt/d/dev"
export WAN_IP="$([[ $(curl --silent whatismyip.akamai.com) =~ ^([0-9]{1,3}([.][0-9]{1,3}){3})$ ]] && echo ${BASH_REMATCH[1]} || echo 'wan_err')";

red="\e[00;31m"; grn="\e[00;32m"; ylw="\e[00;33m"; yel="$ylw"; blu="\e[00;34m"; pur="\e[00;35m"; cyn="\e[00;36m"; wht="\e[00;37m"; r="\e[00m"; R="$r\n"
gry="\e[00;37;02;03m"; bkto="${red}[$r"; bktc="${red}]$r"; gld="\e[00;33;03m"; gry_itl="\e[00;37;02m"

if [[ ! -d ~/bin ]] ; then
	printf "$red>$gry Creating the directory ${gld}~/bin$R"
	mkdir -p ~/bin || printf "${red}> \e[01mERROR!${gry} Couldn't create ${gld}~/bin$R"
fi
[[ $PATH =~ ^(([-_[:alnum:]/]+:)+)?${HOME}/bin((:[-_[:alnum:]/]+)+)?$ ]] || PATH+=":${HOME}/bin"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
    HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
    shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
    shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
    shopt -s globstar
# make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# COLOR PROMPT
	PS1='\[\e[00;31m\][\[\e[00m\]\u@\h\[\e[00;34m\] \w\[\e[00;31m\]]\$\[\e[00m\] '
	#PS1='${debian_chroot:+($debian_chroot}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
