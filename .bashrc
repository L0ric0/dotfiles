#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Load resources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

function path_remove {
  # Delete path by parts so we can never accidentally remove sub paths
  PATH=${PATH//":$1:"/":"} # delete any instances in the middle
  PATH=${PATH/#"$1:"/} # delete any instance at the beginning
  PATH=${PATH/%":$1"/} # delete any instance in the at the end
}

alias ls='ls --color=auto '
alias diff='diff --color=auto '

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY

HISTCONTROL=ignoreboth:erasedups
export HISTCONTROL

#Refresh gpg-agent tty in case user switches into an X session
#gpg-connect-agent updatestartuptty /bye > /dev/null

#Set ssh-agent sock and ssh-agent pid
eval $(cat ~/.ssh/agent-bartimaeus) > /dev/null

path_remove /usr/bin/env

shopt -s autocd cdspell dotglob extglob

#aliases for acp and amv
alias cp='acp -g'
alias mv='amv -g'


if ! { [ "$TERM" = "screen-256color" ] && [ -n "$TMUX" ] ; } then
    if tmux ls; then
        bin/listadmin.py;
        tmux attach;
    else
        bin/listadmin.py;
        tmux new \; \
            split-window -v \; \
            split-window -v \; \
            split-window -v \; \
            split-window -v \; \
            select-layout main-vertical \; \
            new-window \; \
            send-keys 'ssh h2790514' C-m \; \
            previous-window \; \
            select-pane -t 0 \;;
    fi
fi
