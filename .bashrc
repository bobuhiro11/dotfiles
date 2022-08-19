[ -e /usr/bin/colordiff ] && alias diff='colordiff'

alias free='free -w'
alias ip='ip --color'
alias ll='ls -lah'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias sudo='sudo '
alias sriov_summary='grep -r "" \
  /sys/class/net/*/device/sriov_numvfs \
  /sys/class/net/*/device/sriov_totalvfs \
  /sys/class/net/*/phys_port_name \
  /sys/class/net/*/compat/devlink/lag_port_select_mode \
  /sys/class/net/*/device/net/*/compat/devlink/steering_mode \
  2>/dev/null'
alias hugepage_summary='grep -r "" /sys/devices/system/node/node*/hugepages/hugepages-*/*_hugepages'
alias meminfo_by_node="paste /sys/devices/system/node/node*/meminfo | sed -e 's/Node [0-9]\|kB//g'  | column -t | sed -e 's/ [a-zA-Z()_]*: //g' | column -t"

export TERM="xterm-256color"
export HISTFILE=~/.bash_history
export HISTSIZE=100000
export SAVEHIST=100000
export DIRSTACKSIZE=100
export GOPATH=$HOME/go
export PYENV_ROOT="$HOME/.pyenv"
export PKG_CONFIG_PATH="/usr/lib64/pkgconfig/:$PKG_CONFIG_PATH"

export PATH="/usr/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/snap/bin:$PATH"
export PATH="/usr/share/bcc/tools:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin/:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%Y-%m-%d %T "
export PROMPT_COMMAND="history -a; history -c; history -r"
export FZF_DEFAULT_COMMAND="find -L . -type d -name '.git' -prune -o -type d -name '.cache' -prune -o -type d -name 'vendor' -prune -o -type f"
export FZF_DEFAULT_OPTS="--bind=ctrl-k:kill-line --height 1% --min-height=8"
export GO111MODULE=on
export GOPROXY=https://proxy.golang.org,direct
export GOSUMDB=off
export PYTHONWARNINGS=ignore

export IGNOREEOF=100
export KEYTIMEOUT=1 # 10ms for key sequences

# https://docs.openstack.org/kolla-ansible/victoria/admin/tls.html
# os_cacert is optional for trusted certificates
export OS_CACERT=/etc/pki/tls/certs/ca-bundle.crt

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

if [ -f $HOME/.goenv/bin/goenv ]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$PATH:$GOROOT/bin"
  export PATH="$PATH:$GOPATH/bin"
fi

function udev_log {
  if [[ $# -ne 1 ]]
  then
    echo "Usage: $FUNCNAME <interface name>"
  fi
  sudo udevadm test $(sudo udevadm info /sys/class/net/$1/ -q path)
}

[ -f $HOME/.pyenv/bin/pyenv ] && eval "$(pyenv init -)"
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local
