autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f %F{cyan}${vcs_info_msg_0_}%f'$'\n''%# '

for rc in $HOME/.zshrc.d/**/*.zsh; do
  source $rc
done

alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
