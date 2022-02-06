plugins=(
  git
  golang
)

export ZSH=$XDG_CONFIG_HOME/oh-my-zsh
ZSH_THEME="minimal"

source $ZSH/oh-my-zsh.sh

for rc in $HOME/.zshrc.d/**/*.zsh; do
  source $rc
done
