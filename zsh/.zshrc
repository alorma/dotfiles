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

# Source local config file specific to machine if it exists
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi

export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/dev/bin"
export PATH="$PATH:$HOME/Library/Android/sdk/tools/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#DISABLE android emulator audio
export QEMU_AUDIO_DRV=none

source ~/.git-prompt.sh

plugins=(zsh-syntax-highlighting git git-prompt)

export PATH=/opt/homebrew/bin:$PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function android_screenshot() {
 adb exec-out screencap -p > screenshot.png
 mv -f screenshot.png ~/Desktop/screenshot.png
}

function androidTalkBackToggle(){
  output=$(adb shell settings get secure enabled_accessibility_services)
  if [[ "$output" == "null" ]]; then
    adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService
  else
    adb shell settings put secure enabled_accessibility_services null
  fi
}

export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:/usr/bin/ruby"

