# React Todo Demo — Secure Vault-Managed Deployment

**React + FastAPI full-stack Todo application** deployed with Docker Compose and secured using HashiCorp Vault for database secret management.


## What is this project?

A classic three-tier learning app:

| Service | Tech | Host port |
|---------|------|-----------|
| Frontend | React (Vite) + nginx | **3000** |
| Backend | **Python FastAPI** + Uvicorn | **8000** |
| Database | PostgreSQL 16 | **15432** |

The UI creates, lists, toggles, and deletes todos stored in Postgres.


## What you will learn

- FastAPI routes, Pydantic schemas, dependency injection  
- SQLAlchemy models + Postgres  
- Auto **OpenAPI** docs at `/docs`  
- React frontend talking to a JSON API  
- Multi-container networking with Compose  
- HashiCorp Vault for database secret management
- Dynamic retrieval of database credentials at container startup

## Prerequisites

- Docker or Podman Compose **or** Python 3.11+ and Node 18+
- Basic Python and HTTP knowledge


## Quick start

### 1. Start HashiCorp Vault

Start the Vault server from the separate Vault configuration:

```bash
cd ~/vault-server
docker compose up -d
### 2. Provide the Vault token

Set the Vault token in the shell environment:

```bash
export VAULT_TOKEN="your-vault-token"

```markdown
##3. Start the application
cd ~/react-fastapi-todo
docker compose up --build

##5. Stop:

docker compose down

#### 6. Make sure Project Layout has the closing code fence

After:

```text
└── README.md
...
## Project layout

```text
react-fastapi-todo/
├── frontend/          # React (Vite) + nginx
│   └── Dockerfile
├── backend/           # FastAPI + SQLAlchemy
│   ├── Dockerfile
│   ├── start.sh       # Retrieves DB credentials from Vault
│   └── app/
├── db/
│   ├── Dockerfile
│   └── start.sh       # Retrieves DB credentials from Vault
├── docker-compose.yml
├── docs/
│   ├── how-it-works.md
│   └── architecture.md
└── README.md


## REST API overview

| Method | Path | Description |
|--------|------|-------------|
| GET | `/api/health` | Health + DB |
| GET | `/api/todos` | List todos |
| POST | `/api/todos` | Create `{ "title": "..." }` |
| PATCH | `/api/todos/{id}` | Update todo |
| DELETE | `/api/todos/{id}` | Delete todo |

```bash
curl http://localhost:8000/api/health
curl -X POST http://localhost:8000/api/todos \
  -H "Content-Type: application/json" \
  -d '{"title":"Learn FastAPI"}'
```

## Secrets Management

Database credentials are managed by HashiCorp Vault.

The application does not store database credentials in:

- `docker-compose.yml`
- `.env` files
- application source code

Vault stores the database credentials at:

```text
secret/todo-db
...
The database and backend startup scripts retrieve the required credentials from Vault when the containers start.
## Lab exercises

1. Add a `description` field to Todo (model + schema + UI).  
2. Add pagination to `GET /api/todos`.  
3. Write a pytest for create/list endpoints.  
4. Compare this stack with [grpc-golang-todo](https://github.com/saurabhahuja71/grpc-golang-todo).  

## Project documentation

- [`docs/how-it-works.md`](docs/how-it-works.md) — application request flow
- [`docs/architecture.md`](docs/architecture.md) — application architecture


## License

Educational sample. Review dependency licenses before commercial use.
