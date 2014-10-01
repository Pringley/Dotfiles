export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH="$HOME/Downloads/apache-ant-1.9.3/bin:$PATH"
export PATH="$HOME/Downloads/android-sdk-macosx/tools:$PATH"
export PATH="$HOME/Downloads/android-sdk-macosx/platform-tools:$PATH"
export PATH=/Applications/SWI-Prolog.app/Contents/MacOS:$PATH
export PATH=/Applications/Racket\ v6.0/bin:$PATH
export PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

alias tsfunds='ledger csv --subtotal --current ^Funds --csv-format "%(account)\t%(amount)\n"'
alias prettyfunds='tsfunds | column -t'
alias updatefunds='echo "# Updated $(date)" > ~/ref/funds.txt && prettyfunds >> ~/ref/funds.txt'
alias funds='prettyfunds && updatefunds'

export LEDGER_FILE=~/ref/ledger.txt
export LEDGER_START_OF_WEEK=1

export EDITOR=/usr/bin/vim
export ANT_HOME="$HOME/Downloads/apache-ant-1.9.3"

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins 'kj' vi-cmd-mode

PROMPT="%# "

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zshistory

setopt SHARE_HISTORY      # share history between multiple zsh
setopt EXTENDED_HISTORY   # also remember how long cmds run
setopt HIST_IGNORE_SPACE  # don't store lines starting with ' '

setopt CORRECT            # spell-checking of commands!
