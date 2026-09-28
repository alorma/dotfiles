#!/usr/bin/env bash
# Auto-restarts LogiMgrDaemon (Logi Options) after system wake and display wake,
# so the MX Master extra buttons keep working. Requires sleepwatcher (Brewfile).
set -e

LOGI_DIR="$(cd "$(dirname "$0")"; pwd -P)"
LABEL=local.displaywake-watcher
PLIST=~/Library/LaunchAgents/$LABEL.plist

chmod +x "$LOGI_DIR/displaywake-watcher.sh" "$LOGI_DIR/wakeup.sh"

brew list sleepwatcher &>/dev/null || brew install sleepwatcher

ln -sfn "$LOGI_DIR/wakeup.sh" ~/.wakeup
echo "Symlinked $LOGI_DIR/wakeup.sh -> ~/.wakeup"
brew services restart sleepwatcher

mkdir -p ~/Library/LaunchAgents
cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$LABEL</string>
	<key>ProgramArguments</key>
	<array>
		<string>$LOGI_DIR/displaywake-watcher.sh</string>
	</array>
	<key>KeepAlive</key>
	<true/>
	<key>RunAtLoad</key>
	<true/>
	<key>StandardOutPath</key>
	<string>/tmp/displaywake-watcher.stdout.log</string>
	<key>StandardErrorPath</key>
	<string>/tmp/displaywake-watcher.stderr.log</string>
</dict>
</plist>
EOF

launchctl bootout gui/$(id -u) "$PLIST" 2>/dev/null || true
launchctl bootstrap gui/$(id -u) "$PLIST"
echo "Loaded LaunchAgent $LABEL"
