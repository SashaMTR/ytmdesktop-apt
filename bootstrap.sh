#!/usr/bin/env bash
# Run this ONCE locally to generate the GPG key and bootstrap the repo.
# Then export the private key and add it as a GitHub Actions secret.
set -euo pipefail

KEY_NAME="YTMDesktop Apt Repository"
KEY_EMAIL="ytmdesktop-apt@noreply.github.com"

echo "==> Generating GPG key (no passphrase for CI use)..."
gpg --batch --gen-key <<EOF
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: ${KEY_NAME}
Name-Email: ${KEY_EMAIL}
Expire-Date: 0
%no-protection
EOF

echo ""
echo "==> Key generated. Export for GitHub Actions secret:"
echo ""
echo "  gpg --armor --export-secret-keys '${KEY_NAME}' | base64"
echo ""
echo "Add the output as secret GPG_PRIVATE_KEY in your GitHub repo."
echo "Leave GPG_KEY_PASSPHRASE empty (or set to empty string) since key has no passphrase."
echo ""
echo "==> Bootstrapping repo..."
bash get_new_package.sh
KEY_PASSPHRASE="" make all

echo ""
echo "==> Done. Commit everything and push. Enable GitHub Pages on the root of main branch."
