# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH

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

function androidAnimationsFast() {
  adb shell settings put global window_animation_scale 0.5
  adb shell settings put global transition_animation_scale 0.5
  adb shell settings put global animator_duration_scale 0.5
  echo "Done!"
}

function androidAnimationsSlow() {
  adb shell settings put global window_animation_scale 5.0
  adb shell settings put global transition_animation_scale 5.0
  adb shell settings put global animator_duration_scale 5.0
  echo "Done!"
}

function androidTalkBackToggle(){
  output=$(adb shell settings get secure enabled_accessibility_services)
  if [[ "$output" == "null" ]]; then
    adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService
  else
    adb shell settings put secure enabled_accessibility_services null
  fi
}

function androidScreenshot() {
  # https://twitter.com/phileynick/status/1688922792887209985
  local delay=0
  [[ "$1" =~ ^[0-9]+$ ]] && delay=$1

  if [[ "$delay" -gt 0 ]]; then
    local i=$delay
    while [[ $i -gt 0 ]]; do
      echo "Screenshot in $i..."
      sleep 1
      (( i-- ))
    done
  fi

  adb devices | tail -n +2 | while read line
  do
      deviceId=$(echo $line | awk '{print $1}')
      if [ -z "${deviceId}" ]; then
          continue
      fi
      if [[ $line == *"emulator"* ]]
      then
          deviceName=$deviceId
      else
          deviceName=$(echo $line | awk -F "device:" '{print $2}' | awk '{print $1}')
      fi
      echo "Capturing screenshot from device $deviceName"
      timestamp=$(date +"%Y-%m-%d at %H.%M.%S")
      filename="$deviceName - $timestamp.png"
      adb -s $deviceId exec-out screencap -p > "$HOME/Downloads/$filename"
  done
}

function androidTouchPointerOn() {
  adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:1
  echo done
}

function androidTouchPointerOff() {
  adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:0
  echo done
}

function androidPaste() {
  adb shell input text "$(pbpaste)"
}
alias androidFontSize1="adb shell settings put system font_scale 1.0"
alias androidFontSize085="adb shell settings put system font_scale 0.85"
alias androidFontSize115="adb shell settings put system font_scale 1.15"
alias androidFontSize130="adb shell settings put system font_scale 1.30"
function androidFixEmulatorDate() {
  adb shell su root date "$(date +%m%d%H%M%Y.%S)"
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

# Git worktree helpers
function gwt() {
  local branch="$1"

  if [[ -z "$branch" ]]; then
    echo "Usage: gwt <branch-name>"
    return 1
  fi

  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -ne 0 ]; then
    echo "Error: not inside a git repository"
    return 1
  fi

  local repo_name
  repo_name=$(basename "$repo_root")

  # Sanitize branch name for filesystem (replace / with -)
  local safe_branch="${branch//\//-}"

  local worktree_path="$(dirname "$repo_root")/${repo_name}-${safe_branch}"

  # If the target directory already exists, handle gracefully
  if [[ -d "$worktree_path" ]]; then
    if git worktree list | grep -q "^$worktree_path "; then
      echo "Worktree already exists at '$worktree_path', switching to it"
      cd "$worktree_path"
      return 0
    else
      echo "Error: '$worktree_path' already exists but is not a git worktree"
      return 1
    fi
  fi

  # Check if branch exists locally
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    echo "Using existing local branch '$branch'"
    git worktree add "$worktree_path" "$branch"
  else
    # Fetch to ensure remote refs are up to date before checking remote
    echo "Fetching from origin..."
    git fetch origin
    # Check if branch exists on remote
    if git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
      echo "Tracking remote branch 'origin/$branch'"
      git worktree add --track -b "$branch" "$worktree_path" "origin/$branch"
    # Branch doesn't exist anywhere — create it
    else
      echo "Creating new branch '$branch'"
      git worktree add -b "$branch" "$worktree_path"
    fi
  fi

  if [ $? -eq 0 ]; then
    cd "$worktree_path"
  else
    echo "Error: failed to create worktree"
    return 1
  fi
}

function gwtrm() {
  local force=0
  if [[ "$1" == "-f" ]]; then
    force=1
  fi

  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -ne 0 ]; then
    echo "Error: not inside a git repository"
    return 1
  fi

  # Get main worktree path (always the first entry in worktree list)
  local main_worktree
  main_worktree=$(git worktree list | head -1 | awk '{print $1}')

  # Refuse if called from the main repo
  if [ "$repo_root" = "$main_worktree" ]; then
    echo "Error: you are in the main repository, not a worktree"
    return 1
  fi

  local current_path="$repo_root"
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD)

  if [ $force -eq 0 ]; then
    # Check for commits not pushed to any remote branch
    local unpushed
    unpushed=$(git log HEAD --not --remotes --oneline 2>/dev/null)
    if [[ -n "$unpushed" ]]; then
      echo "Error: there are unpushed commits on '$branch':"
      echo "$unpushed"
      echo "Push them first, or use 'gwtrm -f' to force delete."
      return 1
    fi
  fi

  # Must cd away before removing the directory we're standing in
  cd "$main_worktree"

  # Without -f: git refuses if uncommitted changes exist (protects data)
  # With -f: passes --force to bypass that check too
  if [ $force -eq 1 ]; then
    git worktree remove --force "$current_path"
  else
    git worktree remove "$current_path"
  fi

  if [ $? -ne 0 ]; then
    echo "Error: failed to remove worktree"
    cd "$current_path"
    return 1
  fi

  # Delete the local branch (force delete — safety net is the unpushed-commits check above)
  git branch -D "$branch"
}
