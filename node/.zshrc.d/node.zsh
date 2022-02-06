export NODE_OPTIONS="--max_old_space_size=4096"

# if using nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# if using nodenv
(( $+commands[nodenv] )) && eval "$(nodenv init -)"