# ~/.bashrc: executed by bash(1) for non_login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# We use preexec and precmd hook functions for Bash
# If you have anything that's using the Debug Trap or PROMPT_COMMAND 
# change it to use preexec or precmd
# See also https://github.com/rcaloras/bash-preexec

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# To have time in the history command
export HISTTIMEFORMAT='%F %T  ' 

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
# To unset: shopt -u globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi





# color names for readibility
#reset=$(tput sgr0)
#bold=$(tput bold)
#black=$(tput setaf 0)
#red=$(tput setaf 1)
#green=$(tput setaf 2)
#yellow=$(tput setaf 3)
#blue=$(tput setaf 4)
#magenta=$(tput setaf 5)
#cyan=$(tput setaf 6)
#white=$(tput setaf 7)
#user_color=$green
#[ "$UID" -eq 0 ] && { user_color=$red; }
#PS1="\[$reset\][\[$cyan\]\A\[$reset\]]\[$user_color\]\u@\h(\l)\
#\[$white\]:\[$blue\]\W\[$reset\][\[$yellow\]\$?\[$reset\]]\[$white\]\
#\\$\[$reset\] "



if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \D{%F %T}\$ '
fi






unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias llh='ls -alFh'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# If this is an xterm set more declarative titles 
# "dir: last_cmd" and "actual_cmd" during execution
# If you want to exclude a cmd from being printed see line 156
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\$(print_title)\a\]$PS1"
    __el_LAST_EXECUTED_COMMAND=""
    print_title () 
    {
        __el_FIRSTPART=""
        __el_SECONDPART=""
        if [ "$PWD" == "$HOME" ]; then
            __el_FIRSTPART=$(gettext --domain="pantheon-files" "Home")
        else
            if [ "$PWD" == "/" ]; then
                __el_FIRSTPART="/"
            else
                __el_FIRSTPART="${PWD##*/}"
            fi
        fi
        if [[ "$__el_LAST_EXECUTED_COMMAND" == "" ]]; then
            echo "$__el_FIRSTPART"
            return
        fi
        #trim the command to the first segment and strip sudo
        if [[ "$__el_LAST_EXECUTED_COMMAND" == sudo* ]]; then
            __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND:5}"
            __el_SECONDPART="${__el_SECONDPART%% *}"
        else
            __el_SECONDPART="${__el_LAST_EXECUTED_COMMAND%% *}"
        fi 
        printf "%s: %s" "$__el_FIRSTPART" "$__el_SECONDPART"
    }
    put_title()
    {
        __el_LAST_EXECUTED_COMMAND="${BASH_COMMAND}"
        printf "\033]0;%s\007" "$1"
    }
    
    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    update_tab_command()
    {
        # catch blacklisted commands and nested escapes
        case "$BASH_COMMAND" in 
            *\033]0*|update_*|echo*|printf*|clear*|cd*)
            __el_LAST_EXECUTED_COMMAND=""
                ;;
            *)
            put_title "${BASH_COMMAND}"
            ;;
        esac
    }
    preexec_functions+=(update_tab_command)
    ;;
*)
    ;;
esac

#"\e[A": history-search-backward # put these commands in /etc/inputrc to search with arrows keys matching the text on the left of the cursor
#"\e[B": history-search-forward

### these commands were taken from a old manual to install texlive (from Enrico Gregorio) now I create a simpler alias
## Addition for TeX Live
#function texup () {
#if [[ -z "$@" ]]
#then
#sudo /opt/texbin/tlmgr -gui
#else
#sudo /opt/texbin/tlmgr "$@"
#fi
#}
#alias mktexlsr='sudo /opt/texbin/mktexlsr'
#alias updmap-sys='sudo /opt/texbin/updmap-sys'
#alias fmtutil-sys='sudo /opt/texbin/fmtutil-sys'

# Emacs
#alias emacs='XLIB_SKIP_ARGB_VISUALS=1 emacs'

stty -ixon # to bind the ctrl+s to the reverse ctrl+r search, otherwise ctrl+s is associate with a command that freeze the terminal 

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# To install this utility run sudo add-apt-repository ppa:ultradvorka/ppa; sudo apt-get update; sudo apt install hh; hh --show-configuration >> ~/.bashrc;
#export HH_CONFIG=hicolor         # get more colors
#shopt -s histappend              # append new history items to .bash_history
#export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
## if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
#if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi
## if this is interactive shell, then bind 'kill last command' to Ctrl-x k
#    if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hh -k \C-j"'; fi


################## Aliases ##################
alias peter='echo "ssh -Y giancarlo@130.194.160.24" && echo "" && ssh -Y giancarlo@130.194.160.24' # connect to Peter's computer
alias tomas='echo "ssh -Y giancarlo@130.194.167.186" && echo "" && ssh -Y giancarlo@130.194.167.186' # connect to Tomas's computer
alias marconi='echo "ssh gpozzo00@login.marconi.cineca.it" && echo "" && ssh gpozzo00@login.marconi.cineca.it'
alias cineca='echo "ssh gpozzo00@login.marconi.cineca.it" && echo "" && ssh gpozzo00@login.marconi.cineca.it'
alias stampa="system-config-printer" # See printers
alias update='echo "" && echo "   cp ~/.bashrc ~/Dropbox/script/.bashrc && cp ~/.vimrc ~/Dropbox/script/.vimrc && cp ~/.imwheelrc ~/Dropbox/script/.imwheelrc && sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt purge dpkg --list | grep ^rc | cut -d   -f 3" && echo "" && cp ~/.bashrc ~/Dropbox/script/.bashrc && cp ~/.vimrc ~/Dropbox/script/.vimrc && cp ~/.imwheelrc ~/Dropbox/script/.imwheelrc && sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt purge `dpkg --list | grep "^rc" | cut -d " " -f 3`'
#alias sc="sh ~/Dropbox/script/ReloadShortCut"
alias installa="sudo apt update && sudo apt full-upgrade && sudo apt install -y"
alias disinstalla="sudo apt purge --auto-remove"
#alias v="vi"
#alias vim="vi"
alias open="xdg-open"
alias findTool="apropos"
alias xopen="xdg-open"
alias beep='xterm -e sh -c '\''for i in $(seq 1); do echo -e "\a"; sleep .5; done; echo "TASK FINISHED"; sleep 600'\'''
alias alert='xterm -e sh -c '\''for i in $(seq 3); do echo -e "\a"; sleep .5; done; echo "TASK FINISHED"; sleep 600'\'''
#alias alert1='xterm -e sh -c '\''echo "10 minutes to shutdown\n \a"; sleep 1 ; echo " 5 minutes to shutdown\n \a"; sleep 1; echo " 3 minutes to shutdown\n \a"; sleep 1; echo " 2 minutes to shutdown\n \a"; sleep 1; echo " 1 minutes to shutdown\n\n \a"; sleep 1; echo "30 seconds to shutdown\n\n \a"; sleep 1; echo "     SHUTDOWN NOW"; source /home/unknow/Dropbox/script/shutdown ; sleep 600 '\'''
alias cgrep='grep --color=always'
alias g++='g++ -Wall -Weffc++ -Wextra -Wsign-conversion -pedantic-errors'
alias meteo='curl http://wttr.in/melbourne'

alias anacondaActivate=". ~/Dropbox/script/anaconda/anacondaActivate"
alias anacondaDeactivate=". ~/Dropbox/script/anaconda/anacondaDeactivate"

#alias texup="tlmgr --gui update --all"

# VERY STRANGE: IF m IS UPPERCASE I GOT ERROR WHEN i RUN  . .bashrc
# use vim with on your computer with fils on Marconi
vimSshmarconi() {
	 vim scp://gpozzo00@login.marconi.cineca.it//"$1"
}


#cpFromPeter="scp -r giancarlo@130.194.160.24:"
#                  "scp -r /home/unknow/Dropbox/Scan/SlaveScan2.wl giancarlo@130.194.160.24:/home/giancarlo/Scan

# Function to copy from Peter's computer while logged on my computer
cpFromPeter() {
	scp -r giancarlo@130.194.160.24:"$1" "$2"
}

# Function to copy to Peter's computer while logged on my computer
cpToPeter() {
	scp -r "$1" giancarlo@130.194.160.24:"$2"
}

# Function to copy from Tomas's computer while logged on my computer
cpFromTomas() {
	scp -r giancarlo@130.194.167.186:"$1" "$2"
}

# Function to copy to Tomas's computer while logged on my computer
cpToTomas() {
	scp -r "$1" giancarlo@130.194.167.186:"$2"
}

# Function to copy from marconi while logged on my computer
cpFromMarconi() {
	scp -r gpozzo00@login.marconi.cineca.it:"$1" "$2"
}

# Function to copy to marconi while logged on my computer
cpToMarconi() {
	scp -r "$1" gpozzo00@login.marconi.cineca.it:"$2"
}

# Function to copy to the clipboard
c() {
	"$1" | tr -d '\n' | xclip -selection clipboard
}
# the alias to paste alias v="xclip -o -selection clipboard" is already used for vim

# Function to open a file with the default application
o() {
	xdg-open "$1" &
}

# Handy Extract Program
function extract()     
{
   if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1     ;;
          *.tar.gz)    tar xvzf $1     ;;
          *.bz2)       bunzip2 $1      ;;
          *.rar)       unrar x $1      ;;
          *.gz)        gunzip $1       ;;
          *.tar)       tar xvf $1      ;;
          *.tbz2)      tar xvjf $1     ;;
          *.tgz)       tar xvzf $1     ;;
          *.zip)       unzip $1        ;;
          *.Z)         uncompress $1   ;;
          *.7z)        7z x $1         ;;
          *)           echo "'$1' cannot be extracted via >extract<" ;;
      esac
   else
       echo "'$1' is not a valid file!"
   fi
}

# Find a file with a pattern in name:
function f() { find . -type f -iname '*'"$*"'*' -ls ; }

function cdls { cd "$1"; pwd; ls;}
function cdll { cd "$1"; pwd; ll;}

# From https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}
function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
   done
}

function PdfGrepIm(){
    str="$1";
    echo "pdfgrep --files-with-matches \"$str\" **/*.pdf";
    pdfgrep --files-with-matches $str **/*.pdf;
    echo;
    echo "pdfgrep -rni \"$str\""
    pdfgrep -rni $str;
}


#sc #see the alias alias sc="sh ~
source "$HOME/.cargo/env"
