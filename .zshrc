# export ZSH=$XDG_CONFIG_HOME/oh-my-zsh
# ZSH_THEME="gentoo"
#source $ZSH/oh-my-zsh.sh

for rc in $HOME/.zshrc.d/**/*.zsh; do
  source $rc
done

alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
