#!/usr/bin/env bash
set -euo pipefail

TARGET_FILE="update.md"
TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
MESSAGES=("🌱" "♻️" "✅" "🚀" "🛠️" "📦" "🧪" "🌍" "⚡" "✨")
INDEX=$((RANDOM % ${#MESSAGES[@]}))
COMMIT_MESSAGE="bot: ${MESSAGES[$INDEX]} (at ${TIMESTAMP})"

cat > "$TARGET_FILE" <<EOF
# Green Commit Update

Last update (UTC): ${TIMESTAMP}
EOF

git config --local user.name "J-yriz"
git config --local user.email "alfaziz2006@gmail.com"

git add "$TARGET_FILE"

if git diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

git commit -m "$COMMIT_MESSAGE"

echo "Created commit: $COMMIT_MESSAGE"
