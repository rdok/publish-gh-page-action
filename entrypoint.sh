#!/bin/sh
set -e
. "./log.sh"

DIRECTORY=$1
GITHUB_TOKEN=$2

logInfo "> Set up GitHub action user"
git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
logSuccess "  Done"

logInfo "> Fetch branches "
git status
#git fetch --unshallow origin "$BRANCH" gh-pages 2>&1
logWarning "  Un-shallow fetch temporarily disabled"
logSuccess "  Done"

logInfo "> Merge gh-pages branch"
GH_PAGES_REMOTE=$(git ls-remote --heads origin gh-pages)
if [ ! -z "$GH_PAGES_REMOTE" ];then
  logInfo "  gh-pages exists"
  logInfo "  merge it with ours"
  git merge --strategy=ours origin/gh-pages
fi
logSuccess "  Done"

logInfo "> Override docs with ${DIRECTORY}"
rm -f -R docs
mv -f "$DIRECTORY" docs
logSuccess "  Done"

logInfo "> Git commit & push"
git add --all
git commit --message "Publish build $GITHUB_SHA"
git push "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" HEAD:refs/heads/gh-pages
logSuccess "  Done"

