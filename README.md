# Asobi Arena Demo (Defold)

Top-down arena shooter demo for the [Asobi](https://github.com/widgrensit/asobi) game backend, built with [Defold](https://defold.com/) and the [asobi-defold](https://github.com/widgrensit/asobi-defold) SDK.

## Game Flow

1. **Login** — Auto-generated username, click LOGIN or REGISTER (GUI)
2. **Lobby** — Connect via WebSocket, find match through matchmaker (GUI)
3. **Arena** — WASD movement, mouse aim + click to shoot, 90-second rounds (game script)
4. **Results** — Match standings, leaderboard submission, play again or quit (GUI)

## Setup

### Prerequisites

- [Defold Editor](https://defold.com/download/) or [bob](https://defold.com/manuals/bob/) CLI
- [asobi](https://github.com/widgrensit/asobi) backend running on `localhost:8084`
- [asobi_arena](https://github.com/widgrensit/asobi_arena) game mode registered

### Install SDK

Symlink or copy the asobi-defold SDK into the project:

```bash
ln -s /path/to/asobi-defold/asobi asobi
```

### Run

Open the project in the Defold Editor and press F5, or build with bob:

```bash
java -jar bob.jar --platform x86_64-linux build
```

## Architecture

Single collection with a controller script managing game state. GUI screens (login, lobby, results) are toggled via enable/disable. The arena renders via the controller's update loop using server state received at 10Hz via WebSocket. Server-authoritative gameplay.

## Controls

| Key | Action |
|-----|--------|
| W/A/S/D | Move |
| Mouse | Aim |
| Left Click | Shoot |

## Note

Defold doesn't have built-in text input fields in GUI. The login screen auto-generates a random username. For production use, integrate a native text input extension.
