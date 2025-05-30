# Directory Info
alias ll="ls -lFh"
alias la="ls -lAFh"  # List all files (inlcuding hidden)
alias lh="ls -ld .*" # List hidden files only
alias lr="ls -tRFh"  # List recursively


## Hidden files in Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## Gradle
alias gw='./gradlew'
alias gwstop='./gradlew --stop'

# npm
alias npmr='npm run'

## Application shortcuts
alias stree='git rev-parse --show-toplevel | xargs open -a SourceTree' # Prefer installing the command tools instead
alias androidstudio="open -a /Applications/Android\ Studio.app"

## My most used command
alias meh='echo "¯\_(シ)_/¯" | pbcopy && echo "¯\_(シ)_/¯ copied"'
#linux: alias meh='echo "¯\_(シ)_/¯" | xclip -selection c && echo "¯\_(シ)_/¯ copied"'

## Dotfiles self-awareness (aka skynet)
alias dotfiles='subl ~/dotfiles && cd ~/dotfiles'

# Fzf + bat https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --preview 'bat --color \"always\" {}'"

function androidAnimationsOn() {
  adb shell settings put global window_animation_scale 1.0
  adb shell settings put global transition_animation_scale 1.0
  adb shell settings put global animator_duration_scale 1.0
  echo "Done!"
}

function androidAnimationsOff() {
  adb shell settings put global window_animation_scale 0.0
  adb shell settings put global transition_animation_scale 0.0
  adb shell settings put global animator_duration_scale 0.0
  echo "Done!"
}

function androidAnimationsSlow() {
  adb shell settings put global window_animation_scale 5.0
  adb shell settings put global transition_animation_scale 5.0
  adb shell settings put global animator_duration_scale 5.0
  echo "Done!"
}

function androidTouchPointerOn() {
  adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:1
  echo done
}

function androidTouchPointerOff() {
  adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:0
  echo done
}

function androidAppInfo() {
  readonly package=${1:?"The package must be specified."}
  adb shell am start -a android.settings.APPLICATION_DETAILS_SETTINGS package:$package
  echo "Opening..."
}

function openDeepLink() {
  readonly url=${1:?"The url must be specified."}
  adb shell am start -a android.intent.action.VIEW -d $url
  echo "Opening..."
}


function androidNavigationGestures() {
  adb shell cmd overlay enable com.android.internal.systemui.navbar.gestural
  echo "Navigation by gestures..."
}

function androidNavigationButtons() {
  adb shell cmd overlay enable com.android.internal.systemui.navbar.threebutton
  echo "Navigation by buttons..."
}
