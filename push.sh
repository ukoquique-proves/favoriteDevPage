#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: this directory is not a git repository."
    exit 1
fi

if ! git remote get-url origin > /dev/null 2>&1; then
    echo "Error: git remote 'origin' is not configured."
    echo "Configure your credentials with SSH, GitHub CLI or a git credential helper, then try again."
    exit 1
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ -z "$BRANCH" ] || [ "$BRANCH" = "HEAD" ]; then
    echo "Error: could not determine the current branch."
    exit 1
fi

# Build the site first
echo "Building the site..."
bash build.sh
if [ $? -ne 0 ]; then
    echo "Build failed. Aborting push."
    exit 1
fi

echo "Running consistency checks before push..."
bash check.sh
if [ $? -ne 0 ]; then
    echo "Push aborted. Fix the errors above first."
    exit 1
fi

# Stage all changes in the repository
git add -A

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

if git diff --cached --quiet; then
    echo "Push aborted. There are no staged changes to commit."
    exit 1
fi

git commit -m "$MSG"
git push origin "$BRANCH"
