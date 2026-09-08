#!/bin/sh
set -e

echo "Waiting for Vault..."

until python -c "import urllib.request; urllib.request.urlopen('http://10.0.2.15:8200/v1/sys/health')" >/dev/null 2>&1; do
    sleep 2
done

echo "Vault is available."

python - <<'PY'
import json
import os
import urllib.request

vault_addr = "http://10.0.2.15:8200"
token = os.environ["VAULT_TOKEN"]

request = urllib.request.Request(
    vault_addr + "/v1/secret/data/todo-db",
    headers={"X-Vault-Token": token},
)

with urllib.request.urlopen(request) as response:
    data = json.load(response)["data"]["data"]

database_url = (
    f"postgresql://{data['username']}:{data['password']}"
    f"@{data['host']}:{data['port']}/{data['dbname']}"
)

os.environ["DATABASE_URL"] = database_url

os.execvp(
    "uvicorn",
    ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
)
PY
