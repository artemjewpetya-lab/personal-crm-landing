#!/usr/bin/env bash
# Runs in GitHub Actions after `pnpm build`: uploads dist/ to the server with
# rsync --delete, then checks that the home page answers 200 with this version.
#
# Env: DEPLOY_HOST, DEPLOY_USER, DEPLOY_KNOWN_HOSTS, SITE_URL (repository
#      variables), DEPLOY_SSH_KEY (secret), VERSION (commit SHA)
#
# On the server this key may only write into the landing folder that nginx
# serves (/var/www/personalcrm/landing, enforced by rrsync), so the remote path
# below is relative to that folder.
set -euo pipefail

: "${DEPLOY_HOST:?}" "${DEPLOY_USER:?}" "${DEPLOY_KNOWN_HOSTS:?}" "${DEPLOY_SSH_KEY:?}"
: "${SITE_URL:?}" "${VERSION:?}"

dist_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/dist"
if [[ ! -f "$dist_dir/index.html" ]]; then
  echo "dist/index.html not found: run pnpm build first." >&2
  exit 1
fi

# Shows which commit is live: $SITE_URL/version.txt
printf '%s\n' "$VERSION" > "$dist_dir/version.txt"

ssh_dir="$(mktemp -d)"
trap 'rm -rf "$ssh_dir"' EXIT
(umask 077 && printf '%s\n' "$DEPLOY_SSH_KEY" > "$ssh_dir/key")
printf '%s\n' "$DEPLOY_KNOWN_HOSTS" > "$ssh_dir/known_hosts"
ssh_cmd="ssh -i $ssh_dir/key -o IdentitiesOnly=yes -o BatchMode=yes"
ssh_cmd+=" -o StrictHostKeyChecking=yes -o UserKnownHostsFile=$ssh_dir/known_hosts"

# --delay-updates and --delete-delay swap the files in at the very end,
# so visitors do not get a half-uploaded page.
echo "==> Uploading dist/ to the server"
rsync --recursive --links --perms --times --chmod=D755,F644 \
  --delete --delete-delay --delay-updates --itemize-changes \
  -e "$ssh_cmd" "$dist_dir/" "$DEPLOY_USER@$DEPLOY_HOST:./"

echo "==> Smoke test $SITE_URL/"
code="" live=""
for _ in $(seq 1 10); do
  code="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 10 "$SITE_URL/" || true)"
  live="$(curl -fsS --max-time 10 "$SITE_URL/version.txt" 2>/dev/null || true)"
  if [[ "$code" == "200" && "$live" == "$VERSION" ]]; then
    echo "==> Smoke test passed: home page answered 200, live version $live"
    exit 0
  fi
  sleep 3
done

echo "SMOKE TEST FAILED: home page answered ${code:-nothing}," \
  "live version is ${live:-unknown}, expected $VERSION." >&2
exit 1
