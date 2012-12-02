#!/bin/bash

# List directory contents
alias sl=ls
alias ls='ls -G'        # Compact view, show colors
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -lhrt'
alias l='ls -a'
alias l1='ls -1'

alias _="sudo"

if [ $(uname) = "Linux" ]
then
    alias ls="ls --color=always"
fi

alias cls='clear'

alias edit="$EDITOR"

alias ..='cd ..'        # Go up one directory
alias ...='cd ../..'    # Go up two directories
alias -- -="cd -"       # Go back

# Shell History
alias h='history'

# Directory
alias   md='mkdir -p'
alias   rd=rmdir

alias rmpyc="find . -iname '*.pyc' -exec rm -v {} \;"
alias http='python -m SimpleHTTPServer'

alias tmux="TERM=xterm-256color tmux"
alias reload='source ~/.bash_profile'
