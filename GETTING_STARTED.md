# Getting Started (Windows, Linux, macOS)

Setup for the Asobi Arena demo on any desktop OS. This covers the asobi-specific
parts: running the backend, adding the SDK, and connecting. It assumes you already
know Defold. If not, start with the official
[Defold getting-started manual](https://defold.com/manuals/getting-started/) and
[download the editor](https://defold.com/download/) first.

The editor path (open the project, run) is identical on Windows, Linux, and macOS.
The `bob.jar` CLI path is for CI and headless builds; see the
[appendix](#appendix-cli-build-with-bobjar).

## 1. Prerequisites

- The [Defold editor](https://defold.com/download/) (bundles its own JRE, so no
  Java install needed for the editor path).
- [Docker](https://docs.docker.com/get-docker/): Docker Desktop on Windows
  (WSL2 backend) and macOS, Docker Engine or Desktop on Linux.
- Git.

## 2. Start the backend

The demo plays the full arena game (boons, modifiers, voting, bots), so it needs
the `asobi_arena_lua` backend, not the minimal `sdk_demo_backend`.

On Windows, start Docker Desktop first and wait until it reports "running". Then
in any terminal (PowerShell, Git Bash, WSL, or a Linux/macOS shell):

```
git clone https://github.com/widgrensit/asobi_arena_lua
cd asobi_arena_lua
docker compose up -d
```

The server listens on `http://localhost:8085`. `localhost` works the same on all
three OSes because Docker publishes the port to the host.

Check it is up:

```
docker compose ps
```

## 3. Add the SDK to the demo

The `asobi/` directory is the SDK source. It is git-ignored, so it is not part of
this repo and you must add it before building. Clone the SDK next to the demo:

```
git clone https://github.com/widgrensit/asobi-defold
```

Then put its `asobi/` folder inside this demo. **Copying is the simplest way and
needs no admin rights on any OS:**

- Windows (PowerShell): `Copy-Item -Recurse ..\asobi-defold\asobi .\asobi`
- Linux / macOS: `cp -r ../asobi-defold/asobi ./asobi`

If you plan to edit the SDK in place, use a link instead of a copy:

- Windows (Developer Mode or admin), cmd: `mklink /J asobi C:\path\to\asobi-defold\asobi`
- Windows (PowerShell): `New-Item -ItemType Junction -Path asobi -Target C:\path\to\asobi-defold\asobi`
- Linux / macOS: `ln -s /path/to/asobi-defold/asobi asobi`

## 4. Run it

Open this demo's `game.project` in the editor, run **Project -> Fetch Libraries**
(pulls the WebSocket extension), then build and run as usual. Same on every OS; no
platform strings or file permissions to set by hand. On the server-select screen
choose **LOCAL** to hit `localhost:8085`.

## 5. Play

1. **Server Select** - choose LOCAL (your Docker backend) or PLAY ONLINE.
2. **Login** - register or log in with a username and password.
3. **Lobby** - queue for matchmaking.
4. **Arena** - 90-second rounds. W/A/S/D to move, mouse to aim, left click to shoot.
5. **Boon Pick -> Voting -> Results**, then auto-queue for the next match.

To see multiplayer, run a second instance (open the demo in a second editor, or
build once and launch the binary twice) and log in as a different user.

## Stopping the backend

```
cd asobi_arena_lua
docker compose down
```

## Troubleshooting

- **Can't connect / connection refused**: the backend is not up. Run
  `docker compose ps` in `asobi_arena_lua`. On Windows and macOS, confirm Docker
  Desktop itself is running.
- **"WebSocket callback invalid" or realtime silently dead**: register WebSocket
  callbacks from a `.script` in `main.collection` that lives for the whole app,
  never from a `gui_script` or a collection that gets unloaded.
- **Fetch Libraries did nothing**: check `game.project` lists both the SDK and the
  `extension-websocket` dependency, then retry with a network connection.
- **Windows symlink failed**: `mklink` needs an elevated shell or Developer Mode.
  Use the copy step in section 3 instead.

## Appendix: CLI build with bob.jar

For CI or headless builds. Requires a JDK matching your `bob.jar` version (recent
`bob` needs a recent JDK; the editor path avoids this entirely).

Download the `bob.jar` that matches your editor version from the
[Defold releases](https://github.com/defold/defold/releases), then build for your
platform:

| OS | Platform string | Run the build |
|----|-----------------|---------------|
| Windows | `x86_64-win32` | `build\x86_64-win32\dmengine.exe` |
| Linux | `x86_64-linux` | `chmod +x build/x86_64-linux/dmengine && ./build/x86_64-linux/dmengine` |
| macOS (Intel) | `x86_64-macos` | `chmod +x build/x86_64-macos/dmengine && ./build/x86_64-macos/dmengine` |
| macOS (Apple Silicon) | `arm64-macos` | `chmod +x build/arm64-macos/dmengine && ./build/arm64-macos/dmengine` |

Build (substitute your platform string):

```
java -jar bob.jar --platform x86_64-win32 resolve build
```

`chmod` is only needed on Linux and macOS; Windows runs the `.exe` directly.
