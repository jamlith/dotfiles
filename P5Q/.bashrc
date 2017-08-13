#
# ~/.bashrc
#

# DEFINE GLOBALS
export VISUAL=vim
export EDITOR=vim

# Android Terminal can't display italics, so check
# if this is an SSH session, and disable italics
# if need be.
[[ -n $SSH_CLIENT ]] && italcode="" || italcode=";03"
alias resh="source ~/.bashrc"
alias vish="vim ~/.bashrc +split\ ~/src/tools.sh"
alias ls="ls --color=auto"


# Only add the italic escapes if using a xterminal emulator
#    (The android terminal garbles the italic escapes)
[[ -n $SSH_CLIENT ]] && iesc="" || iesc=";03"
# Color settings
red="\e[00;31m"; blu="\e[00;34m"; grn="\e[00;32m"; ylw="\e[00;33m"; gld="\e[00;33;02m"; gry="\e[00;37;02${iesc}m"; wht="\e[00;37m"; pur="\e[00;35m"
rbold="${red/m/\;01m}"; bbold="${blu/m/\;01m}"; wbold="${wht/m/\;01m}"; r="\e[00m"; R="$r\n"
ruline="${red/m}/;04m}"; buline="${blu/m/;04m}"; wuline="${wht/m/;04m}"; guline="${gry/m/;04m}"

# Prompt mods
PROMPT_DIRTRIM=3
PS1="\[\e[00;31m\][\[\e[00;37;02${italcode}m\]\u@\h \w\[\e[00;31m\]]\[$([[ $? -eq 0 ]] && ps1exit='' || ps1exit='[${red}\][\[${wht}\]$?\[${red}\]]\"\]${ps1exit}\$\[\e[00m\] '
# WAN and LAN IP resolving
[[ $(ifconfig) =~ inet\ ([0-9]{1,3}(.[0-9]{1,3}){3}) ]] && LAN_IP="${BASH_REMATCH[1]}"
[[ $(curl -s http://whatismyip.akamai.com) =~ ^([0-9]{1,3}(\.[0-9]{1,3}){3})$ ]] && WAN_IP="${BASH_REMATCH[1]}"

pappend()
{
# PATH append
set -a plist
plist+=(/home/james/bin /home/james/etc)
for dir in $plist ; do
    if [[ $PATH =~ .*[:]?$dir[:]?.* ]] ; then
        continue
    else
        # Check if dir exists...
        [[ -d $dir ]] && PATH+=":$dir" || printf "${red}!!! ${blu}$dir$r wasn't added to PATH because it doesn't exist.\n"
    fi
done
}

# Custom functions



vars()
{
    [[ -n $1 ]] && argtemp="$1"
    while [[ $argtemp =~ ^[\s]*[\-]([[:alpha:]]+) ]] ; do
        local argtemp="${argtemp##${BASH_REMATCH[0]}}"
        if [[ -z $argtemp ]] || [[ $argtemp =~ ^[^[:alnum:]]*$ ]] ; then
            shift
            [[ -n $1 ]] && [[ $1 =~ ^[\s]*[\-]([[:alpha:]]+) ]] && argtemp="$1"
        fi
        local opts="${BASH_REMATCH[1]}"
        printf "cmdline flags were detected...\n  ${red}opts: ${wital}$opts$R"
        while [[ ${#opts} -ge 1 ]] ; do
            local curropt=${opts:0:1}
            [[ $curropt != $opts ]] && opts="${opts##$curropt}" || opts=""
            printf "   ${blu}Current option: ${gld}$curropt$r\n"
            case $curropt in
                x|X)
                    # debug flag
                    # come back later
                    printf "\n${red}!!!$r You set the debug flag at the cmdline, but\n\e[01mthis feature is not yet implemented!$r  Please remove the '-x'\nflag from the cmdline and try again.  Thanks.\n"
                    exit 1
                    ;;
                e|E)
                    # skip escaping variable values
                    local skip_escape=1
# Custom functions
                    printf "${red}skip_escape$r was enabled by cmd line flag...\e[00m\n"
                    ;;
                h|H)
                    clear
                    cat <<EOF
usage vars [-hxe] <list of base varnames>
    
  Quick notes:
    >All user-defined strings sent to the function are treated as wildcards... not
     only will it print out the value of the variable with it's exact name, but
     also every variable that begins with the same pattern...  eg: if i sent
     "BASH", it would be treated as if I had sent "BASH*".it would return BASH,
     and then it would get BASH_CMDS, as well as BASH_VERSION, BASH_REMATCH, BASH_LINENO,
     BASH_SOURCE, and every other variable whose name matches "BASH*".
    >calling vars() without arguments will print all variables that begin with any
     letter of the english alphabet... the only variables that might get missed are
     any that begin with odd chars, eg '_' or something similar.
    >Command-line options must be the first argument after calling vars.  if you put them
     behind anything else they will be treated as a variable name and passed to the
     script without any changes occuring.

    if you define the list it will be used to find all set variables that begin
    with the list items... e.g. i can pass as many as i want, it can be all in
    one string seperated by spaces, or it can be in seperate arguments using
    quotes... ill show an example of each as if i wanted to pass 'BASH', 'SSH', and
    'history'...
        a space seperated string:   > vars "BASH SSH history"
        as seperate arguments:      > vars "BASH" "SSH" "history"
    now, the function will print out the value of every variable that begins with
    any of my strings... almost as if we sent BASH*, SSH*, and history*.  It is
    case sensitive.  If you don't define a custom set of variables, then the default
    is to cycle the entire alphabet, uppercase then lowercase.  If you pass a single
    uppercase letter as part of the list it will automatically append all variables
    that begin with the lowercase too.

    send any options first, e.g.     > vars -e ("list" "populated" "with" "items" "that" "are" "all" "strings")
    any other order wont work, like  > vars "base" "varname" "item3" -e     << This
    would add the -e to the list of filters and end up with no results and no change
    in program preferences.

    options:
        -e = don't strip the variable values of all substance before displaying
        -x = debugging on... not yet implemented
        -h = display the usage screen and exit (ya!)
EOF
                    exit 1
                    ;;
                esac
        done
    done


    local pattern=""
    [[ -n $* ]] && [[ $* =~ ^[\s]*([^!][[:alnum:]]+[^*][ ])*[^!][[:alnum:]]+[^*][\s]*$ ]] && pattern="$*"
    local default_pattern=$(echo {A..Z}); # Uses the alphabet by default.
    local output="\e[00;31;01mvars():$R"
    [[ -z $pattern ]] && pattern="$default_pattern"


    for ptn in $pattern ; do
        local vlist=""
        estr="echo \${!${ptn}*}"

        vlist+="$(eval $estr)"
        [[ $ptn =~ ^[A-Z]$ ]] && {
            local lwr=$(echo $ptn | tr [[:upper:]] [[:lower:]])
            lestr="echo \${!${lwr}*}"
            vlist+="$(eval $lestr)"
        }

        if [[ -z $vlist ]] ; then
            # No returns, assume no vars matched the pattern...
            continue
        else
            # Return the value of each variable that was found
            output+="          \e[00;31;02;04m__$ptn__:$R"
            for vname in $vlist ; do
                local vn_len="${#vname}"
                local space_remaining=$((72-$vn_len))
                estr="printf \"\${${vname}}\""
                estr_rtn=$(eval "$estr")
                if [[ $skip_escape -eq 1 ]] ; then
                    val="$estr_rtn"
                else
                    estr_esc=$(echo "$estr_rtn" | sed -e "s/[^[:print:]]//g" -e "s/\[[0][0]\([;][0-9][0-9]\)*[m]//g")
                    val="${estr_esc//[^A-Za-z0-9\[\]\(\)=-_\;\:\!\+\?\., ]/ }"
                fi
                [[ -n $val ]] || val="${pur}NULL$r"
                output+=$(printf "${blu}%15.15s: ${wital}%-62q" "$vname" "$val")
                output+="\n"
            done
⅝6i        fi
            
    done

    printf "$output"
    return 0
}

ps1_exitcode()
{
   ] local ps1_str=
    [[ -n $1 ]] && xcode="$1" && shift || xcode="$?"
    if [[ $xcode -ne 0 ]] ; then
        ps1_str="\[${red}\][\[${wht}\]\?\[${red}\]]"
        printf "${ps1_str}"
    else
        printf ""
    fi
}

pip()
{
    local output="${ruline}IP Addresses:$R"

    # Find the proper IP to use, eg. lan for local, wan for remote
    local ip=
    if [[ -z $SSH_CLIENT ]] || [[ $SSH_CLIENT =~ 192\.168\.1\.[0-9{1,3} ]] ; then
        ip="$LAN_IP"
    else
        ip="$WAN_IP"
    fi

    local transmission="http://${ip}:9091"
_
    local apache="http://${ip}:80"
    
    output+="  ${blu}WAN IP: ${wital}${WAN_IP}$R"
    output+="  ${blu}LAN IP: ${wital}${LAN_IP}$R"
    output+="\n${gry}$apache${R}${gry}$transmission$R"
fast yahyy
    printf "\n$output"
}


seatbelt Scarlett Y is at txt+⅝:q!
st
fi1
    
