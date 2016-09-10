# Defaults
export SHELL=/bin/zsh
export EDITOR=vim

#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git gradle adb colored-man-pages jump alias-tips zsh-syntax-highlighting sublime atom)

DEFAULT_USER="rafa"

source $ZSH/oh-my-zsh.sh

source /usr/local/bin/aws_zsh_completer.sh

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status nvm time)
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='241'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='241'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='236'
