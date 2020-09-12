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

logInfo "> Fetch branches"
git fetch --all
git branch
git remote show
git remote show origin
#GH_PAGES_REMOTE=$(git ls-remote --heads origin gh-pages)
#if [ ! -z "$GH_PAGES_REMOTE" ];then
#  logInfo "  gh-pages exists"
#  logInfo "  merge it with ours"
#  if $(git rev-parse --is-shallow-repository); then
#    echo "Shallow repo found."
#    git fetch --unshallow origin gh-pages
#  else
#    echo "Full repo found."
#    git fetch origin gh-pages
#  fi
#
#  git merge --strategy=ours origin/gh-pages
#fi
logSuccess "  Done"

logInfo "> Override docs with ${DIRECTORY}"
rm -f -R docs
mv -f "$DIRECTORY" docs
logSuccess "  Done"

logInfo "> Git commit & push"
git add --all
git commit --message "Publish build $GITHUB_SHA"
#git push origin gh-pages
#git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" HEAD:refs/heads/gh-pages
logSuccess "  Done"
