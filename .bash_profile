#
# ~/.bash_profile
#

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERMINAL=termite

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	  exec startx
fi
