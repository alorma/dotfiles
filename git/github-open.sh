#!/usr/bin/env bash

# Credit to @padilo, many thanks!!
# Usage: github-open.sh [--pr]
#   (no args) open branch compare page
#   --pr      open PR creation page (compare + expand form)

url=$(git remote get-url origin)

if [[ "$(echo $url | cut -d@ -f1)" != "git" ]]; then
  echo "Unrecognized remote, can't open PR"
  exit 1
fi

url_no_user=$(echo $url | cut -d@ -f2)
host=$(echo $url_no_user | cut -d: -f1)
project=$(echo $url_no_user | cut -d: -f2 | cut -d. -f1)
branch=$(git rev-parse --abbrev-ref HEAD)

suffix=""
if [[ "$1" == "--pr" ]]; then
  suffix="?expand=1"
fi

open "https://$host/$project/compare/$branch$suffix"
