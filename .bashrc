# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# delete lines duplicated
HISTCONTROL=erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# go to directory directly
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# my parameters
alias feh='feh --auto-rotate'

export LOCALE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less

export PATH=$PATH:/usr/local/bin:/usr/bin:/bin
export PATH=$PATH:/usr/local/games:/usr/games/
export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin

export PATH=$HOME/.utils/bin/:$PATH
export PATH=$HOME/.dub/packages/.bin/dls-latest/:$PATH
# to use ccache
export PATH=/usr/lib/ccache/:$PATH
# qcad
export PATH=$HOME/.qcad:$PATH

source $HOME/.cargo/env

export HISTSIZE=10000
export HISTFILESIZE=50000

# sudo pip install powerline-shell
# sudo apt-get install fonts-powerline
function _update_ps1() {
    #PS1=$(powerline-shell $?)
    history -a; # flush history after each command
}
PROMPT_COMMAND="_update_ps1"

# readline settings
# ignore case for auto completion
bind "set completion-ignore-case on"
# ignore diff between - and _
bind "set completion-map-case on"
# show directly completion results after first TAB
bind "set show-all-if-unmodified on"
# limit what is show for completion (hide prefix bigger than 2 char)
bind "set completion-prefix-display-length 2"
# do not complete hidden files
bind "set match-hidden-files off"

###############################################################################
todo()
{
    # using git-crypt
    pushd ~/.todo
    git pull --rebase || (echo "FAILED PULL - press enter" && read)
    vi todo
    git commit -a -m 'up'
    git push || (echo "FAILED PUSH - press enter" && read)
    popd
}

# docker
_docker_exec_full()
{
    # pulse audio must be installed in target container
    docker run -it --privileged --rm=true\
    -e TERM=xterm-256color -e LC_ALL=en_US.UTF-8 -e LOCALE=en_US.UTF-8\
    -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix\
    -w $(pwd) -v $HOME:$HOME -v $(pwd):$(pwd)\
    -v /data:/data\
    -e USER=$USER \
    -e HOME=$HOME \
    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR\
    -v /etc/localtime:/etc/localtime\
    -v /dev/input/:/dev/input/\
    -v /var/lib/docker:/var/lib/docker\
    -v /var/run/docker.sock:/var/run/docker.sock\
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /etc/shadow:/etc/shadow:ro \
    --shm-size 4G\
    -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native\
    -v ${XDG_RUNTIME_DIR}:${XDG_RUNTIME_DIR}\
    $(id -G | tr ' ' '\n' | sed -e 's/^/--group-add /g' | tr '\n' ' ') \
    $@
}

docker_exec()
{
    name="$1"
    shift
    _docker_exec_full -u $UID local:$name "$@"
}

docker_build()
{
    name=$1
    shift
    ctx=~/.docker_build
    docker build\
        -t local:"$name"\
        -f $ctx/"$name".Dockerfile\
        "$@"\
        $ctx
}

# to make vm work
# block nouveau driver

# cat /etc/modprobe.d/nouveau.conf
#blacklist nouveau
#options nouveau modeset=0

# sudo virsh edit win10
#<features>
#   <hyperv>
#   ....
#       <vendor_id state='on' value='whatever'/>
#   ....
#   </hyperv>
#   <kvm>
#   <hidden state='on'/>
#   </kvm>
#</features>

# use barrier for sharing mouse/keyboard (assigned to vm)
# barrier server on windows, client on linux
# ping is not functional from host to guest due to windows firewall

# vm configure network as nat (autostart to rise interface at boot)

# need to passthrough all pci devices related to nvidia card
# else error about "group X is not viable" will occur with QEMU

# no need to hack around vfio module or id or anything
# add "intel_iommu=on iommu=pt" to grub cmdline

# sound: https://wiki.archlinux.org/index.php/libvirt
#
# The PulseAudio daemon normally runs under your regular user account, and will
# only accept connections from the same user. This can be a problem if QEMU is
# being run as root through libvirt. To run QEMU as a regular user, edit
# /etc/libvirt/qemu.conf and set the user option to your username.
# user = "dave"
#
# sudo systemctl restart libvirtd.service
#
# sudo virsh edit win10
# <domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
# and add
# <qemu:commandline>
#  <qemu:env name='QEMU_AUDIO_DRV' value='pa'/>
#  <qemu:env name='QEMU_PA_SERVER' value='/run/user/1000/pulse/native'/>
# </qemu:commandline>
# 1000 is your user id

win()
{
    sudo virsh start win10
}

#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#~/.fzf/install --all
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

source $HOME/.bashrc_work

# curl -fsSL https://starship.rs/install.sh | bash
eval "$(starship init bash)"