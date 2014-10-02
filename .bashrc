# Add scripts to PATH
PATH=$HOME/scripts:$PATH
PATH=$HOME/scripts_local:$PATH

# Simple prompt
PS1='\$ '

# Vim power
EDITOR=/usr/bin/vim

# History settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

# Vim mode
set -o vi

# Tmux reminder
alias ta='tmux attach'
if [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
    : # do nothing (for now) if tmux is running
else
    echo "Use 'ta' to attach to persistent tmux."
fi

# Also source local bashrc if present
if [ -e ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

export LEDGER_FILE=~/ref/ledger.txt
export LEDGER_START_OF_WEEK=1
alias budget="watch \"ledger b ^b | tee ~/Google\\ Drive/budget.txt\""
