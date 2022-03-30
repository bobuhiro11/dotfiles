function install_for_mac {
  brew tap homebrew/cask-fonts
  brew install ripgrep
  brew install exa
  brew install bat
  brew install tmux
  brew install vim
  brew install go
  brew install bash
  brew install --cask alacritty
  brew install --cask font-hack-nerd-font
}

[ -e /usr/local/bin/nvim.appimage ] &&  alias nvim='nvim.appimage -u ~/.vimrc'
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
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=$HOME/bin/:$PATH
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/share/bcc/tools
export PATH=$PATH:/opt/homebrew/bin/

export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%Y-%m-%d %T "
export PROMPT_COMMAND="history -a; history -c; history -r"
export FZF_DEFAULT_COMMAND="find -L . -type d -name '.git' -prune -o -type d -name '.cache' -prune -o -type d -name 'vendor' -prune -o -type f"
export FZF_DEFAULT_OPTS="--bind=ctrl-k:kill-line --height 1% --min-height=8"
export GO111MODULE=on
export PYTHONWARNINGS=ignore

export IGNOREEOF=100
export KEYTIMEOUT=1 # 10ms for key sequences

export LESS='-i -F -R -X' # LESS for git is -FRX, this behavior will not change.
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export MANPAGER='less'

export EDITOR=vim

export CYAN=$(tput setaf 6)
export YELLOW=$(tput setaf 3)
export GREEN=$(tput setaf 2)
export RESET=$(tput sgr0)
shopt -u histappend
shopt -s autocd

[ ! -L "$SSH_AUTH_SOCK" ] && ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
[ -t 0 ] &&  stty stop undef
[ -t 0 ] &&  stty start undef

[ -f $(which exa) ] && alias ll="$(which exa) -lag --time-style long-iso"
[ -f $(which bat) ] && alias cat="$(which bat) -p --paging=never"
[ -f $HOME/.pyenv/bin/pyenv ] && eval "$(pyenv init -)"
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
