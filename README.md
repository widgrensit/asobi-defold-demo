# Asobi Arena Demo (Defold)

Top-down arena shooter demo for the [Asobi](https://github.com/widgrensit/asobi) game backend, built with [Defold](https://defold.com/) and the [asobi-defold](https://github.com/widgrensit/asobi-defold) SDK.

## Quick Start

### Prerequisites

- [Defold Editor](https://defold.com/download/) or [bob.jar](https://defold.com/manuals/bob/) CLI
- An Asobi backend running (local or remote)

### Install SDK

Symlink the asobi-defold SDK into the project:

```bash
ln -s /path/to/asobi-defold/asobi asobi
```

### Build & Run

```bash
java -jar bob.jar --platform x86_64-linux resolve build
chmod +x build/x86_64-linux/dmengine
./build/x86_64-linux/dmengine
```

Or open the project in the Defold Editor and press F5.

## Server Selection

On launch you choose which server to connect to:

- **LOCAL** — `localhost:8085` (for [asobi_arena_lua](https://github.com/widgrensit/asobi_arena_lua) via Docker Compose or a local Erlang node)
- **PLAY ONLINE** — `play.asobi.dev` (production server)

## Game Flow

1. **Server Select** — Choose local or online server
2. **Login** — Register or log in with username and password
3. **Lobby** — Connect via WebSocket, queue for matchmaking
4. **Countdown** — 3-2-1 before arena starts
5. **Arena** — 90-second rounds, shoot enemies, collect kills
6. **Boon Pick** — Top 3 players choose an upgrade
7. **Voting** — All players vote on next round's modifier
8. **Results** — Standings, leaderboard, auto-queue for next match

## Controls

| Input | Action |
|-------|--------|
| W / A / S / D | Move up / left / down / right |
| Mouse | Aim |
| Left Click | Shoot |
| Tab | Switch input field (login) |
| Enter | Confirm (login) |

## Architecture

Single collection with a controller script managing game state transitions. GUI screens (server select, login, lobby, countdown, arena, boon pick, voting, results) are toggled via enable/disable. The arena renders ship sprites and cannonball projectiles using textures from the ships atlas.

**Server-authoritative**: the client sends inputs at 60fps, the server responds with game state at 10Hz. All collision, damage, and kill logic runs server-side.

### Key Files

| File | Purpose |
|------|---------|
| `main/controller.script` | State machine, input routing, WebSocket callbacks |
| `main/game_config.lua` | Shared config, colors, cross-GUI data |
| `arena/arena.gui_script` | Arena rendering (ships, projectiles, HUD) |
| `boon/boon.gui_script` | Boon card selection UI |
| `vote/vote.gui_script` | Modifier voting with live tallies |
| `server/server.gui_script` | Server selection (local/online) |
| `asobi/` | SDK (symlinked) — HTTP client, WebSocket, API modules |

### Assets

| File | Description |
|------|-------------|
| `assets/player.png` | Player ship sprite (52x53) |
| `assets/enemy.png` | Enemy ship sprite (52x53) |
| `assets/cannonball.png` | Projectile sprite (8x8) |
| `assets/ship_player.png` | Player sprite sheet (3x4 grid) |
| `assets/ship_enemy.png` | Enemy sprite sheet (3x4 grid) |
| `assets/ships.atlas` | Defold atlas combining all sprites |
