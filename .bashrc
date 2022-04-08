[ -e /usr/bin/colordiff ] && alias diff='colordiff'

alias free='free -w'
alias ip='ip --color'
alias ll='ls -lah'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export TERM="xterm-256color"
export HISTFILE=~/.bash_history
export HISTSIZE=100000
export SAVEHIST=100000
export DIRSTACKSIZE=100
export GOPATH=$HOME/go
export PYENV_ROOT="$HOME/.pyenv"

export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/share/bcc/tools:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin/:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/nvim-linux64/bin:$PATH"

export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%Y-%m-%d %T "
export PROMPT_COMMAND="history -a; history -c; history -r"
export FZF_DEFAULT_COMMAND="find -L . -type d -name '.git' -prune -o -type d -name '.cache' -prune -o -type d -name 'vendor' -prune -o -type f"
export FZF_DEFAULT_OPTS="--bind=ctrl-k:kill-line --height 1% --min-height=8"
export GO111MODULE=on
export PYTHONWARNINGS=ignore

export IGNOREEOF=100
export KEYTIMEOUT=1 # 10ms for key sequences

export EDITOR=vim

export CYAN=$(tput setaf 6)
export YELLOW=$(tput setaf 3)
export GREEN=$(tput setaf 2)
export RESET=$(tput sgr0)
shopt -u histappend
shopt -s autocd

export HOSTNAME_SHORT=$(hostname)
export HOSTNAME_SUFFIX=$(cat /etc/resolv.conf | awk '/domain/ {print $2}')
if [[ "$HOSTNAME_SUFFIX" != "" ]]; then
  export HOSTNAME_SHORT=$(echo $HOSTNAME_SHORT | sed -e "s/\.$HOSTNAME_SUFFIX//g")
fi

export PS1='\[$CYAN\]$HOSTNAME_SHORT\[$RESET\]:\[$YELLOW\]\w\[$RESET\]\$ '

[ ! -L "$SSH_AUTH_SOCK" ] && ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
[ -t 0 ] &&  stty stop undef
[ -t 0 ] &&  stty start undef

$(which exa >/dev/null 2>&1) && alias ll="$(which exa) -lag --time-style long-iso --icons"
$(which bat >/dev/null 2>&1) && alias cat="$(which bat) -p --paging=never" && alias less="$(which bat) -p" && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
$(which batcat >/dev/null 2>&1) && alias cat="$(which batcat) -p --paging=never" && alias less="$(which batcat) -p" && export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
$(which nvim >/dev/null 2>&1) && alias vim="$(which nvim)"

[ -f $HOME/.pyenv/bin/pyenv ] && eval "$(pyenv init -)"
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
