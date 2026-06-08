#!/usr/bin/env bash
#
# Publish notes from the Obsidian vault to the site.
#
# Mirrors VAULT_PUBLISH_DIR (and its subfolder structure) into the repo's
# content/ folder, then commits and pushes. GitHub Actions rebuilds Quartz
# and deploys to GitHub Pages.
#
# The site landing page (content/index.md) is repo-managed and is preserved
# (excluded from the mirror's --delete).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTENT_DIR="$REPO_DIR/content"

# Local, untracked config holds the path to your vault's publish folder.
# Create .publish.env (gitignored) with:  VAULT_PUBLISH_DIR=/path/to/vault/Publish
if [ -f "$REPO_DIR/.publish.env" ]; then
  # shellcheck disable=SC1091
  source "$REPO_DIR/.publish.env"
fi

if [ -z "${VAULT_PUBLISH_DIR:-}" ]; then
  echo "error: VAULT_PUBLISH_DIR is not set." >&2
  echo "Set it in $REPO_DIR/.publish.env or pass it inline:" >&2
  echo "  VAULT_PUBLISH_DIR=/path/to/vault/Publish ./publish.sh" >&2
  exit 1
fi

if [ ! -d "$VAULT_PUBLISH_DIR" ]; then
  echo "error: publish folder not found: $VAULT_PUBLISH_DIR" >&2
  exit 1
fi

echo "Mirroring $VAULT_PUBLISH_DIR -> $CONTENT_DIR"
rsync -a --delete \
  --exclude='index.md' \
  --exclude='.obsidian/' \
  --exclude='.DS_Store' \
  "$VAULT_PUBLISH_DIR"/ "$CONTENT_DIR"/

cd "$REPO_DIR"
git add content
if git diff --cached --quiet; then
  echo "No content changes to publish."
  exit 0
fi

git commit -m "Publish: sync notes from vault ($(date +%Y-%m-%d\ %H:%M))"
git push origin main
echo "Published. GitHub Actions will rebuild the site shortly."
