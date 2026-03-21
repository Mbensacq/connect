# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

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
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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


# Setup 1: Default colors
export LS_COLORS="${LS_COLORS}ow=1;97;45:"

# Directory navigation aliases
alias back='cd "$LAST_DIR"'
alias cg='cd `git rev-parse --show-toplevel`'
alias home='cd ~'
up() {
    local count=$1
    local path=""
    for ((i=0; i<count; i++)); do
        path="../$path"
    done
    cd "$path"
}

# Clear screen and list files
alias C="clear && ls -la"
alias CC="clear && tree -a -L 1"
alias CCP="clear && tree -a -L 1 -p"
alias c="clear && ls --color=always"
alias cc="clear && tree -L 1"
alias ccp="clear && tree -L 1 -p"
alias cl="clear"

# Docker aliases
alias di='docker images'
alias dps='docker ps'
alias drm='docker rm $(docker ps -a -q)'
alias drmi='docker rmi $(docker images -q)'

# File and directory management
# alias cp='cp -i'
alias df='df -h'
alias dir="tree -d"
alias du='du -h'
alias files="ncdu --si --color dark -x"
alias formall="clang-format -i *.c *.h; echo done."
alias free='free -m'
alias mkdir='mkdir -pv'
alias mv='mv -i'
alias nuke='rm -rf'
alias rmd='rm -r'
alias aas='cd /mnt/d/progs/aas/'
alias dc='cd -'

# Copy files or dirs into /mnt/d/progs/tmp
totmp() {
    cp -r -- "$@" /mnt/d/progs/tmp
}

# Git aliases
alias g='git'
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate --all"
alias glog="git log --graph --format='%C(yellow)%h%Creset  %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gp="git push"
alias gpl="git pull"
alias gs="git status"

# Kubernetes aliases
alias k='kubectl'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'

# ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lh --color=always'
alias lp='ls -lh --color=always | less'
alias ls='ls -F --color=always'
alias lt='ls --human-readable --size -1 -S --classify'

# Make and CMake aliases
alias cm="cmake .."
alias m="make"
alias ma="mc && cm && m && mt && echo done."
alias mc="make clean"
alias me="make ExperimentalMemCheck"
alias mt="make test"

# Maven aliases 
alias mvnall="mvn clean install exec:java"
alias mvnt="mvn test"
alias mvnc="mvn clean"
alias mvnd="mvn dependency:tree"
alias mvnp="mvn package"

# Miscellaneous
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias h='history'
alias install="sudo apt install"
alias j='jobs -l'
alias myip='curl ifconfig.me'
alias p="pwd"
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias q="exit"
alias sb="source ~/.bashrc"
alias cb="code ~/.bashrc"
alias t="tree"
alias tdl="tree -d -L "
alias work="cd ~/work; cc"
alias please="sudo"

# Networking aliases
alias flushdns='sudo resolvectl flush-caches'
alias meminfo='free -m -l -t'
alias ports='netstat -tulanp'

# Python aliases
alias pip='pip3'
alias py='python3'
alias pyserv='python3 -m http.server'

# System monitoring aliases
alias cpuinfo='lscpu'
alias diskinfo='df -hT'
alias meminfo='free -l -t'

alias cremissh='ssh mbensacq@sshproxy.emi.u-bordeaux.fr'

# Function to change directory, clear terminal, and list files
cd() {
    builtin cd "$@" && ls
    export LAST_DIR="$OLDPWD"
}

cdnc() {
    builtin cd "$@" && ls
    export LAST_DIR="$OLDPWD"
}


# Java
# export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# opam configuration
test -r /home/isen/.opam/opam-init/init.sh && . /home/isen/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# PATH Configuration: 
export PATH="$HOME/.local/bin:$PATH"
# export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))
# export PATH=$JAVA_HOME/bin:$PATH
alias sort="~/scripts/sorter"
alias backup="~/scripts/backup"
alias renamef="~/scripts/renamer"
alias cleanupd="~/scripts/cleanup"
alias findbig="~/scripts/findbig"
alias extract="~/scripts/extract"
alias dups="~/scripts/dups"

cf() {
    if [ -z "$1" ]; then
        echo "Usage: cf file.c"
        return 1
    fi
    clang-format -i -style=file "$1" && echo "Formatted: $1"
}

wlink() {
    local target="$1"
    local abs
    local distro

    target="${target#${target%%[![:space:]]*}}"
    target="${target%${target##*[![:space:]]}}"
    abs="$(realpath -m -- "$target")"
    distro="${WSL_DISTRO_NAME:-Ubuntu}"

    printf 'file://///wsl.localhost/%s%s\n' "$distro" "$abs"
}

# Java 21 configuration
export JAVA_HOME=/home/isen/.jdk/jdk-21.0.8
export PATH=$JAVA_HOME/bin:$PATH


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
