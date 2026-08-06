for rc in $HOME/.zshrc.d/**/*.zsh; do
  source $rc
done

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"

alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
