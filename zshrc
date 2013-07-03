export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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
