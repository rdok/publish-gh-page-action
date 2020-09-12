#!/bin/sh
set -e

logMessage() {
  colorCode=$1
  message=$2
  echo -e "\e[${colorCode}m${message}\e[0m"
}

logInfo() {
  logMessage 34 "$1"
}

logSuccess() {
  logMessage 32 "$1"
}

log() {
  logMessage 37 "$1"
}

logWarning() {
  logMessage 33 "$1"
}


DIRECTORY=$1

logInfo "> Set up GitHub action user"
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
logSuccess "  Done"

logInfo "> Prepare docs directory"
mv -f "$DIRECTORY" /tmp
logSuccess "  Done"

logInfo "> Fetch gh-pages"
git fetch origin gh-pages
git checkout --force --track origin/gh-pages
logSuccess "  Done"

logInfo "> Adding docs"
cp -fR /tmp/"$DIRECTORY"/* docs/
logSuccess "  Done"

logInfo "> Git commit & push"
git add docs
git commit --message "Publish build $GITHUB_SHA"
git push origin gh-pages
logSuccess "  Done"
