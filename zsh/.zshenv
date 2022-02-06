# https://wiki.archlinux.org/title/XDG_Base_Directory#User_directories
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export DEVEL=$HOME/devel
export EDITOR="$(command -v vim)"
export VISUAL="$(command -v code)"

export PATH=$PATH:$HOME/bin