#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"

mkdir "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$PRIVATE_KEY" > "$SSH_PATH/github_key"
echo "$PUBLIC_KEY" > "$SSH_PATH/github_key.pub"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/github_key"
chmod 600 "$SSH_PATH/github_key.pub"

eval $(ssh-agent)
ssh-add "$SSH_PATH/github_key"

ssh-keyscan -t rsa $HOST >> "$SSH_PATH/known_hosts"

sh -c "$*"