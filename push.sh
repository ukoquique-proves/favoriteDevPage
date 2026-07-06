#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

# Load credentials from .env
if [ ! -f ".env" ]; then
    echo "Error: .env file not found. Copy .env.example to .env and fill in your values."
    exit 1
fi
set -a
source .env
set +a

if [ -z "$GITHUB_REPO" ] || [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_REPO and GITHUB_TOKEN must be set in .env"
    exit 1
fi

# Build authenticated remote URL
REPO_PATH="${GITHUB_REPO#https://github.com/}"
REMOTE_URL="https://${GITHUB_TOKEN}@github.com/${REPO_PATH}.git"

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
git push "$REMOTE_URL" main
