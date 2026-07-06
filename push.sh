#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

echo "Running consistency checks before push..."
bash check.sh
if [ $? -ne 0 ]; then
    echo "Push aborted. Fix the errors above first."
    exit 1
fi

# Stage all tracked changes
git add -u
git add *.html *.css *.sh *.md favicon.svg 2>/dev/null

# Require a commit message
if [ -z "$1" ]; then
    echo ""
    read -rp "Commit message: " MSG
else
    MSG="$1"
fi

if [ -z "$MSG" ]; then
    echo "Push aborted. Commit message cannot be empty."
    exit 1
fi

git commit -m "$MSG"
git push
