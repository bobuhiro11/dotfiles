[ -e /usr/bin/colordiff ] && alias diff='colordiff'

alias free='free -w'
alias ip='ip --color'
alias ls='ls --color'
alias ll='ls -lah --color'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias sudo='sudo -E '
alias sriov_summary='grep -r "" \
  /sys/class/net/*/device/sriov_numvfs \
  /sys/class/net/*/device/sriov_totalvfs \
  /sys/class/net/*/phys_port_name \
  /sys/class/net/*/compat/devlink/lag_port_select_mode \
  /sys/class/net/*/device/net/*/compat/devlink/steering_mode \
  2>/dev/null'
alias hugepage_summary='grep -r "" /sys/devices/system/node/node*/hugepages/hugepages-*/*_hugepages'
alias meminfo_by_node="paste /sys/devices/system/node/node*/meminfo | sed -e 's/Node [0-9]\|kB//g'  | column -t | sed -e 's/ [a-zA-Z()_]*: //g' | column -t"
alias ovs_get_other_config='ovs-vsctl get Open_vSwitch . other_config'
alias lscpu_ext='lscpu --extended=NODE,CORE,CPU'
alias grep='grep --color=auto'
alias grep_non_comments="grep -v '^\s*$\|^\s*\#'"
# https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
alias ssh='TERM=xterm-256color ssh'
alias date='date "+%Y/%m/%d %H:%M:%S %Z" '
[[ "$(uname -s)" == "Linux" ]] && alias uptime_date='date -d "`cut -f1 -d. /proc/uptime` seconds ago" '

export HISTFILE=$HOME/.bash_history_of_mine
export HISTSIZE=100000
export HISTFILESIZE=100000
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
export PATH="/usr/local/shellcheck-stable:$PATH"
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
export DPDK_GETMAINTAINER_PATH=$HOME/linux/scripts/get_maintainer.pl

export IGNOREEOF=100
export KEYTIMEOUT=1 # 10ms for key sequences
export LANG=en_US.utf-8
export LC_ALL=en_US.utf-8

# https://docs.openstack.org/kolla-ansible/victoria/admin/tls.html
# os_cacert is optional for trusted certificates
export OS_CACERT=/etc/pki/tls/certs/ca-bundle.crt

if [ -x "$(command -v vim)" ]; then
  export EDITOR=vim
fi

export CYAN=$(tput setaf 6)
export BLUE=$(tput setaf 4)
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

export PS1='\[$GREEN\]$HOSTNAME_SHORT\[$RESET\]:\[$YELLOW\]\w\[$RESET\]\$ '

[ ! -L "$SSH_AUTH_SOCK" ] && ln -sf $SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
[ -t 0 ] &&  stty stop undef
[ -t 0 ] &&  stty start undef

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

function build_centos7_qcow2 {
  if [ ! -e centos7.qcow2 ]; then
    curl -o centos7.qcow2.xz \
      https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-20150628_01.qcow2.xz
    xz -d centos7.qcow2.xz
  fi

  sudo virt-customize -a ./centos7.qcow2 --root-password password:root --uninstall cloud-init
  sudo virt-customize -a ./centos7.qcow2 --install epel-release
  sudo virt-customize -a ./centos7.qcow2 --run-command "sed -i /etc/yum.repos.d/epel.repo -e 's/^#//g'; sed -i /etc/yum.repos.d/epel.repo -e 's/meta.*/#&/'"
  sudo virt-customize -a ./centos7.qcow2 --run-command "yum install -y iperf --enablerepo=epel"

  # Login using root:root.
  sudo qemu-system-x86_64 --enable-kvm -m 1024 -hda ./centos7.qcow2 -cpu kvm64 -nographic
}

[ -f $HOME/.pyenv/bin/pyenv ] && eval "$(pyenv init -)"
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
[ -f /opt/homebrew/etc/profile.d/bash_completion.sh ] && source /opt/homebrew/etc/profile.d/bash_completion.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

if [[ $(type -t _get_comp_words_by_ref) == 'function' ]]; then
  [ -x "$(command -v kubectl)" ] && source <(kubectl completion bash)
  [ -x "$(command -v kubebuilder)" ] && source <(kubebuilder completion bash)
fi

function checkhealth {
  echo -e "\e[1mbold\e[0m"
  echo -e "\e[3mitalic\e[0m"
  echo -e "\e[3m\e[1mbold italic\e[0m"
  echo -e "\e[4munderline\e[0m"
  echo -e "\e[9mstrikethrough\e[0m"
  curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash
}
