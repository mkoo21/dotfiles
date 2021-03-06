# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histreedit
shopt -s histverify
PROMPT_COMMAND="history -a;history -r; $PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#Disable XON/XOFF flow control
stty -ixon

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
    xterm-color|*-256color) color_prompt=yes;;
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

# Uncomment this if git-aware-prompt is not installed/not being used
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

export PATH=$PATH:/usr/local/go/bin
export ANDROID_HOME=~/Android/Sdk ## Install android studio
export PATH=$PATH:$HOME/.npm-packages/bin ## Node local (avoid npm)
export PATH=$ANDROID_HOME/tools:$PATH ## Android studio
export XDG_CONFIG_HOME=/home/martin/.config
export GIT_EDITOR=nvim
export EDITOR=nvim
export SCALA_HOME=/usr/local/share/scala
export PATH=$PATH:$SCALA_HOME/bin
export GOPATH=$HOME/go

#Set node global path to home dir (in case it was installed with sudo)
export PATH="$PATH:$HOME/npm/bin"
export NODE_PATH="$NODE_PATH:$HOME/npm/lib/node_modules"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

### THIS BLOCK IS FOR THE GOOGLE CLOUD CLI AND REQUIRES SOME MANUAL INSTALLATION ###

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/martin/google-cloud-sdk/path.bash.inc' ]; then source '/home/martin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/martin/google-cloud-sdk/completion.bas.hinc' ]; then source '/home/martin/google-cloud-sdk/completion.bash.inc'; fi

#git autocomplete
if [ -f ~/etc/.git-completion.bash ]; then
    . ~/etc/.git-completion.bash
else 
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/etc/.git-completion.bash
    . ~/etc/.git-completion.bash
fi

export PATH=/usr/local/openmpi/bin:/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export LD_LIBRARY_PATH=/usr/local/cudnn/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
export PATH=/usr/local/lib:$PATH
#export PYSPARK_DRIVER_PYTHON=/usr/bin/python3

#Stop <C-s> from freezing screen
stty -ixon

#Nondescript ssh-agent
eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_rsa 2> /dev/null
trap 'test -n "$SSH_AGENT_PID" && eval `/usr/bin/ssh-agent -k`' 0

#thefuck
export PATH=$PATH:/home/martin/.local/bin
eval $(thefuck --alias)
eval $(thefuck --alias shit)
eval $(thefuck --alias FUCK)

# Requires git aware prompt to be installed
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

neofetch
