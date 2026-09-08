#!/bin/sh
set -e

echo "Waiting for Vault..."

until curl -fsS "${VAULT_ADDR}/v1/sys/health" >/dev/null 2>&1; do
    sleep 2
done

echo "Vault is available."

VAULT_DATA="$(curl -fsS \
    -H "X-Vault-Token: ${VAULT_TOKEN}" \
    "${VAULT_ADDR}/v1/secret/data/todo-db")"

export POSTGRES_USER="$(echo "$VAULT_DATA" | jq -r '.data.data.username')"
export POSTGRES_PASSWORD="$(echo "$VAULT_DATA" | jq -r '.data.data.password')"
export POSTGRES_DB="$(echo "$VAULT_DATA" | jq -r '.data.data.dbname')"

echo "Database credentials retrieved from Vault."

exec /usr/local/bin/docker-entrypoint.sh postgres
