# OpenCode Docker with Cloudflare Tunnel & Node v24

This setup allows you to run **OpenCode Web** in a secure Docker container (Node v24) and expose it via **Cloudflare Tunnel**.

## Prerequisites
- Docker & Docker Compose
- Cloudflare Zero Trust account (to get the `TUNNEL_TOKEN`)

## Quick Start

1. **Clone the repository:**
   ```bash
   mkdir opencode-docker && cd opencode-docker
   ```

2. **Configure environment:**
   Copy the example config and add your Cloudflare Tunnel Token:
   ```bash
   cp .env.example .env
   ```
   Edit `.env` and set `TUNNEL_TOKEN`.

3. **Start the services:**
   ```bash
   docker compose up -d
   ```

## Configuration

- **Web Port:** OpenCode runs on port `4096`.
- **Hostname:** The service name in Docker is `opencode-web`.
- **Cloudflare Config:** Your tunnel should point to `http://opencode-web:4096`.
- **Persistence:** Config and sessions are saved in `./data/opencode`.

## Security
By default, the server is password protected. You can change the password in `.env`:
```env
OPENCODE_SERVER_PASSWORD=your_new_secret
```

## Useful Commands
- **View Logs:** `docker compose logs -f`
- **Restart OpenCode:** `docker compose restart opencode-web`
- **Update OpenCode:** `docker compose build --no-cache && docker compose up -d`
