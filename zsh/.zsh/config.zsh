# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git git-prompt adb colored-man-pages jump zsh-syntax-highlighting sublime)

DEFAULT_USER=$(whoami)

source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)


# Gradle completion https://github.com/gradle/gradle-completion
fpath=($HOME/.zsh/gradle-completion $fpath)

# Fzf https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
## add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# Git in English, please
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Nvm — lazy-loaded. nvm.sh costs ~1s to source, so we defer it until nvm/node/npm/npx is actually invoked.
if [[ -s /opt/homebrew/opt/nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  _nvm_load() {
    unset -f nvm node npm npx
    source /opt/homebrew/opt/nvm/nvm.sh
    [[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ]] && source /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm
  }
  nvm()  { _nvm_load; nvm  "$@" }
  node() { _nvm_load; node "$@" }
  npm()  { _nvm_load; npm  "$@" }
  npx()  { _nvm_load; npx  "$@" }
fi