#       +Global vars:   WHOME, WAN_IP, LAN_IP, BINSRC
#       +Commands:      dumpvars([pattern list]), 
#

# Globals and env's
export EDITOR="${VISUAL:=vim}"
export VISUAL

export WHOME="/mnt/c/Users/jamli"
export DEVHOME="/home/james/dev"
export WAN_IP="$([[ $(curl --silent whatismyip.akamai.com) =~ ^([0-9]{1,3}([.][0-9]{1,3}){3})$ ]] && echo ${BASH_REMATCH[1]} || echo 'wan_err')";

#export UBIN="${HOME}/bin";      # a folder to add to PATH, contains executables and scripts that will be accessible anywhere

# colors
red="\e[00;31m"; grn="\e[00;32m"; ylw="\e[00;33m"; yel="$ylw"; blu="\e[00;34m"; pur="\e[00;35m"; cyn="\e[00;36m"; wht="\e[00;37m"; r="\e[00m"; R="$r\n"
gry="\e[00;37;02;03m"; gld="\e[00;33;03m"; blk="\e[00;30m"; err="\e[00;01;31m"

# aliases
alias wcd="cd $WHOME/"

# bash options
#HISTCONTROL=ignoreboth
#shopt -s histappend
#HISTSIZE=1000
#HISTFILESIZE=2000
#shopt -s checkwinsize
#shopt -s globstar
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# custom prompt
PROMPT_DIRTRIM=3
PS1='\[\e[00;31m\][\[\e[00m\]\u@\h\[\e[00;34m\] \w\[\e[00;31m\]]\$\[\e[00m\] '

dumpvars()
{
  local list="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
	  local AAAAAA=""
		  for A in $list ; do
			    AAAAAA+="${gld} $A:\n"
					    local a=$(echo $A | tr [:upper:] [:lower:])
							    local evla="echo \"\${!$A*} \${!$a*}\"";
									    local list2=$(eval "$evla")
											    for v in $list2 ; do
													      local evlb="echo \${$v}"
																      local valb=$(eval "$evlb")
																			      AAAAAA+="    \e[00;94m$v\e[00;30m:${gry} '$valb'$R"
																						    done
																								    output+="\n"
																										  done
																											  printf "$AAAAAA\n"
																												}
