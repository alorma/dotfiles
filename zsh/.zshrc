# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# zsh config location
export ZSH_CONFIG=$HOME/.zsh

# Custom functions path
fpath=($ZSH_CONFIG/functions $fpath)

# Source all zsh files
source $ZSH_CONFIG/config.zsh
source $ZSH_CONFIG/aliases.zsh
source $ZSH_CONFIG/paths.zsh

# Source local config file specific to machine if it exists
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:/Users/bernat.borras//dev/flutter/bin"
export PATH="$PATH:/Users/bernat.borras//dev/bin"
export PATH="$PATH:/Users/bernat.borras/Library/Android/sdk/tools/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/bernat.borras/.sdkman"
[[ -s "/Users/bernat.borras/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/bernat.borras/.sdkman/bin/sdkman-init.sh"

#DISABLE android emulator audio
export QEMU_AUDIO_DRV=none

source ~/.git-prompt.sh

plugins=(zsh-syntax-highlighting git git-prompt)

export PATH=/opt/homebrew/bin:$PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bernat.borras/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bernat.borras/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bernat.borras/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bernat.borras/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

android_screenshot() {
 adb exec-out screencap -p > screenshot.png
 mv -f screenshot.png ~/Desktop/screenshot.png
}

