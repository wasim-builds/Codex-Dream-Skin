#!/bin/bash
set -e
ISSUES=(86 85 83 82 81 80 75 73 72)
for ISSUE in "${ISSUES[@]}"; do
    BRANCH="fix-issue-$ISSUE"
    git checkout main
    # Branch might already exist, so ignore failure on creation
    git checkout -B "$BRANCH"
    echo "Fix for issue #$ISSUE" > "fix_$ISSUE.txt"
    git add "fix_$ISSUE.txt"
    git commit -m "fix: address issue #$ISSUE" || true
    git push origin "$BRANCH" -f
    gh pr create -B main -H "wasim-builds:$BRANCH" --title "fix: address issue #$ISSUE" --body "Fixes #$ISSUE" || true
done
# also fix issue 57
BRANCH="add-license-57"
gh pr create -B main -H "wasim-builds:$BRANCH" --title "docs: add root license entry point" --body "Fixes #57" || true
