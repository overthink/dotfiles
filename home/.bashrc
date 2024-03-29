# vim: ft=sh

# Exit immediately bash is in non-interactive mode
[[ "$-" == *i* ]] || return 0

# Interactive mode stuff follows

set -o vi

# save history after every command: http://northernmost.org/blog/flush-bash_history-after-each-command/
export PROMPT_COMMAND='history -a; history -r'

if [[ $TERM == @(screen|tmux|xterm) ]]; then
  TERM="$TERM-256color"
fi

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --hidden'
[[ -f ~/.fzf.bash ]] && . ~/.fzf.bash

[[ -r ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -r ~/.bashrc.local ]] && . ~/.bashrc.local
