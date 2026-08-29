<p align="center">
  <a href="https://postimg.cc/fJ54gFjY">
    <img src="https://i.postimg.cc/QdZXVZFY/Chat-GPT-Image-17-de-ago-de-2026-09-38-48.png" alt="Dragon Souls RPG" width="100%" />
  </a>
</p>

<div align="center">

# Dragon Souls RPG

### The Middle-earth MMORPG Experience

[![Build Status](https://ci.appveyor.com/api/projects/status/github/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00?svg=true)](https://ci.appveyor.com/project/Mateuzkl/dragon-souls-tfs-1-4-protocol-11-00)
[![Version](https://img.shields.io/badge/version-1.4.0-blue?style=flat-square)](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/releases)
[![Protocol](https://img.shields.io/badge/protocol-11.00-orange?style=flat-square)](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00)
[![License](https://img.shields.io/badge/license-GPL--2.0-red?style=flat-square)](LICENSE)
![Repository size](https://img.shields.io/github/repo-size/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00?style=flat-square)
[![Issues](https://img.shields.io/github/issues/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00?style=flat-square)](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/issues)

<br />

![Engine](https://img.shields.io/badge/ENGINE-TFS%201.4-7c3aed?style=for-the-badge)
![Protocol](https://img.shields.io/badge/PROTOCOL-11.00-f97316?style=for-the-badge)
![C++](https://img.shields.io/badge/C++-17-00599C?style=for-the-badge&logo=cplusplus&logoColor=white)
![Database](https://img.shields.io/badge/DATABASE-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Client](https://img.shields.io/badge/CLIENT-OTCv8-2563eb?style=for-the-badge)
![NexaMap](https://img.shields.io/badge/MAP%20EDITOR-NexaMap-00B8C8?style=for-the-badge)

<br />
<br />

**Dragon Souls RPG** is a custom OpenTibia project built on **The Forgotten Server 1.4**, using **protocol 11.00** and a gameplay/world direction inspired by Middle-earth fantasy.

[Features](#highlights) ·
[Official Links](#official-links) ·
[Installation](#installation--compilation) ·
[Systems](#systems-documentation) ·
[Contributing](#contributing) ·
[Support](#support--community)

</div>

---

# 🐉 REQUIRED MAP EDITOR — NexaMap Editor

> [!CAUTION]
> ## DO NOT USE STANDARD RME / OTAcademy RME
>
> Dragon Souls uses a modified OTBM format where **item count and subtype fields are stored as `uint16` (16-bit)** instead of the standard `uint8` (8-bit).
>
> Standard RME **cannot correctly open or save** Dragon Souls maps — it reads/writes the wrong byte format, producing **corrupted map data**.
>
> **Use only NexaMap Editor:**
>
> ## **[⬇ DOWNLOAD NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)**
>
> NexaMap is the **only map editor** with native Dragon Souls TFS 1.4 compatibility.

### How to configure NexaMap for Dragon Souls

1. Open **NexaMap Editor**.
2. Go to **Edit → Preferences → Editor** tab.
3. ✅ **Check** the option: `Dragon Souls map compatibility (16-bit item count/subtype)`.
4. Open your Dragon Souls `.otbm` map.
5. Edit and save normally.

NexaMap will read and write the `uint16` format that Dragon Souls expects. Your server will load the map without issues.

> [!IMPORTANT]
> **Always enable** this option **before** opening a Dragon Souls map.
> If you open a Dragon Souls map without this option enabled, the item data will be read incorrectly and you may lose data.

> [!WARNING]
> **For standard OTBM maps** (vanilla TFS, Canary, Crystal, etc.), leave this option **unchecked**.
> Enabling it on normal maps will produce incompatible files.

### Quick reference

| Map type | `Dragon Souls map compatibility` option |
|---|---|
| **Dragon Souls TFS 1.4** | ✅ **Enabled** |
| Standard TFS / OTServ | ❌ Disabled |
| Canary | ❌ Disabled |
| Crystal | ❌ Disabled |

### Simple setup rule

1. Read this README before compiling.
2. Install/configure the required `vcpkg`.
3. Recompile the **server**.
4. Recompile the **client**.
5. Download **[NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)**.
6. Enable `Dragon Souls map compatibility (16-bit item count/subtype)` in Preferences → Editor.
7. Open and edit Dragon Souls maps normally.
8. **Do not use another RME.**

---

## About the Project

**Dragon Souls RPG** combines classic Tibia-inspired gameplay with a modern TFS 1.4 server base and protocol 11.00.

Project goals:

- Preserve a classic RPG feel.
- Provide a stable modern server core.
- Build a custom fantasy world inspired by Middle-earth.
- Support custom races, creatures, maps and systems.
- Keep server, client, sprites and map editor aligned.
- Provide a maintainable base for future development.

The project uses a custom toolchain and asset workflow. Server, client and map editor compatibility should always be treated as one complete environment.

---

## Highlights

| Area | Description |
|---|---|
| Core | The Forgotten Server 1.4 |
| Language | C++17 |
| Protocol | 11.00 |
| Client | Custom OTCv8 client |
| Database | MySQL |
| Map Editor | **[NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)** with Dragon Souls uint16 compatibility |
| Stack / Count | Project-specific support up to 10000 through `uint16` changes |
| World | Middle-earth-inspired RPG setting |
| Gameplay | Classic-oriented combat with custom modern systems |
| Tooling | Custom sprites, item tools and NexaMap workflow |

---

## Official Links

| Resource | Description | Link |
|---|---|---|
| **Server** | Dragon Souls TFS 1.4 / Protocol 11.00 | [Repository](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00) |
| **Client** | Custom OTCv8 client | [Dragon Souls Client](https://github.com/Mateuzkl/Dragon-Souls-Client) |
| **Sprites** | Dragon Souls 11.x sprite repository | [SPR-11x-Dragon-Souls](https://github.com/Mateuzkl/SPR-11x-Dragon-Souls) |
| **Map Editor** | **Required editor with Dragon Souls uint16 support** | **[NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)** |
| **Tools** | Asset utilities, Item Editor and Object Builder | [OTG Tools](https://github.com/otg-br/tools) |

> [!IMPORTANT]
> The **Map Editor** link above is **mandatory** for this project workflow.
> NexaMap Editor is the only editor that supports the Dragon Souls uint16 map format.

---

## Technical Features

### Engine & Compatibility

- **Core:** The Forgotten Server 1.4
- **Language:** C++17
- **Protocol:** 11.00
- **Database:** MySQL
- **Client integration:** OTClient / OTCv8
- **Web integration:** native REST API support
- **Logging:** detailed debugging and audit-oriented logs

### Gameplay & Systems

- Classic-oriented **7.92-style combat direction** with project-specific modern mechanics.
- Advanced spell cooldown handling.
- Custom AOL system with energized and non-energized states.
- Party system changes.
- Guild systems.
- House system.
- Day/night cycle.
- Custom race/world direction including Elves, Dwarves and Humans.

---

## Required Project Stack

For best compatibility, use the project components together:

```text
Dragon Souls TFS 1.4
        |
        +-- Protocol 11.00
        |
        +-- Dragon Souls Client
        |
        +-- Dragon Souls 11.x Sprites
        |
        +-- NexaMap Editor
        |      └── Dragon Souls map compatibility (uint16)
        |          Stack / Count up to 10000
        |
        +-- OTG asset tools
```

Replacing one component with an incompatible version may cause asset, packet, item or map-format problems.

---

# Installation & Compilation

## 1. Read README First

Before changing source code or compiling:

- Confirm server repository.
- Confirm matching Dragon Souls client.
- Confirm required map editor: **[NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)**.
- Confirm sprite/assets repositories.
- Configure `vcpkg` correctly.

---

## 2. Required vcpkg Environment

> [!WARNING]
> Recent `vcpkg` revisions may cause compatibility problems with this project.
> Use the project-approved package below when reproducing the documented Windows build environment.

### Download approved vcpkg package

**[Download vcpkg.rar](https://www.mediafire.com/file/ipd4qzohe9jwji3/vcpkg.rar/file)**

Approximate extracted/download environment size: **5 GB**.

Extract directly to:

```text
C:\vcpkg
```

Then open PowerShell as Administrator:

```powershell
cd C:\vcpkg
.\bootstrap-vcpkg.bat
.\vcpkg.exe integrate install
```

---

## 3. Update Baseline — Optional

If required for your local dependency state:

```powershell
cd "C:\Caminho\Para\Dragon-Souls-TFS-1.4-Protocol-11.00"
C:\vcpkg\vcpkg.exe x-update-baseline
```

Do this only when needed for your environment.

---

## 4. Compile Server — Visual Studio 2022

Open:

```text
engine\vc17\theforgottenserver.sln
```

Select:

```text
Configuration: Release
Platform: x64
```

Build:

```text
Ctrl + Shift + B
```

Visual Studio will resolve project dependencies according to the configured environment.

---

## 5. Compile Client

Use the official Dragon Souls client repository:

**[Dragon Souls Client](https://github.com/Mateuzkl/Dragon-Souls-Client)**

Configure the same required toolchain/dependencies and compile the client after the server environment is prepared.

Server and client must remain compatible with protocol **11.00** and the feature configuration used by this project.

---

# REQUIRED MAP EDITOR

> [!CAUTION]
> ## DO NOT USE STANDARD RME
>
> Use only:
>
> **[NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)**
>
> Reason: NexaMap Editor contains native support for **Dragon Souls map compatibility (16-bit item count/subtype)** — enabling Stack/Count up to 10000 through the project's `uint16` changes.
>
> Standard RME or other map editors will save map/item data in the wrong byte format and **will cause loading or data corruption problems** in Dragon Souls TFS 1.4.

### NexaMap Editor setup for Dragon Souls

No compilation is required — download the release build from the NexaMap repository.

Workflow:

```text
Download NexaMap Editor
        ↓
Open NexaMap Editor
        ↓
Preferences → Editor → ✅ Enable "Dragon Souls map compatibility"
        ↓
Load Dragon Souls map
        ↓
Edit using project-compatible data
        ↓
Save
        ↓
Test map on Dragon Souls TFS 1.4
```

---

# Systems Documentation

## Advanced Cooldown System

The project includes spell exhaustion/cooldown handling with player feedback.

Example:

```xml
<instant name="Glaciate" words="adori frigo" spellid="201" exhaustion="7" cooldownmsg="1" script="adori frigo.lua">
    <vocation id="1"/>
    <vocation id="5"/>
</instant>
```

| Attribute | Description | Value rule |
|---|---|---|
| `exhaustion` | Spell cooldown | `< 50`: seconds, e.g. `7 = 7s` |
| `exhaustion` | Spell cooldown | `>= 50`: milliseconds, e.g. `7000 = 7s` |
| `cooldownmsg` | Feedback message | `1`: enabled |

---

## Custom AOL — Energized Amulet of Loss

Custom item protection is based on amulet state and player penalties.

### Amulet States

| State | Protection |
|---|---|
| **Energized** | Full protection except applicable Red/Black Skull penalties |
| **Non-energized** | No item-loss protection |

### Skull Rules

| Player State | AOL Protection | Death Behavior |
|---|---:|---|
| **Normal** | Active | Protects items when energized |
| **Red Skull** | Disabled | Item-loss protection ignored |
| **Black Skull** | Disabled | Item-loss protection ignored + project penalty behavior |

---

## Client Configuration — OTCv8

For the documented protocol 11.00 visual/features configuration, add the required flags to:

```text
modules/game_features/features.lua
```

Example:

```lua
if g_game.getProtocolVersion() >= 1100 then
    g_game.enableFeature(GameSpritesAlphaChannel)
    g_game.enableFeature(GameMagicEffectU16)
    g_game.enableFeature(GameDistanceEffectU16)
    g_game.enableFeature(GameCountU16)
    g_game.enableFeature(GameChangeMapAwareRange)
    g_game.enableFeature(GameDisplayItemDuration)
end
```

> [!WARNING]
> Client and server protocol structures must match.
>
> Do not enable/disable protocol features blindly. A mismatch can produce packet parsing errors or protocol desynchronization.

---

## Map / Item Compatibility

Dragon Souls contains custom item/count behavior beyond a stock editor workflow.

The project-specific `uint16` changes affect how larger Stack/Count values are handled.

Therefore:

- Server must use matching source.
- Client must support matching feature behavior.
- **Map editor must be NexaMap Editor with Dragon Souls compatibility enabled.**
- Item/sprite data must remain aligned.
- Maps should be tested after editing.

### Maximum documented Stack / Count

```text
10000
```

This is the primary reason the project requires NexaMap Editor with the `Dragon Souls map compatibility (16-bit item count/subtype)` option enabled.

---

## Roadmap

### In Development

- [ ] Mount system
- [ ] Additional Rohan areas
- [ ] Race/clan hierarchy and benefits
- [ ] Automatic daily/weekly events

### Known Project Work

- Older 7.92 maps require conversion to the newer map structure used by the project.
- Some legacy item IDs may require remapping.
- Legacy scripts continue to be reviewed/refactored as development progresses.

---

## Contributing

Contributions are welcome.

Recommended workflow:

```bash
git checkout -b feature/my-feature
git add .
git commit -m "feat: add my feature"
git push origin feature/my-feature
```

Then open a Pull Request.

### Pull Request Guidelines

- Keep changes focused.
- Avoid unrelated modifications.
- Explain behavior changes.
- Include reproduction steps for bug fixes.
- Include logs when relevant.
- Test server/client compatibility.
- Test map changes with **NexaMap Editor** (Dragon Souls compatibility enabled).

---

## Issue Reporting

Use GitHub Issues:

**[Dragon Souls Issues](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/issues)**

Include:

- Clear description.
- Steps to reproduce.
- Expected behavior.
- Actual behavior.
- Server log.
- Client log when applicable.
- Map/NexaMap Editor information when applicable.
- Screenshot/video when useful.

---

## Support & Community

- **Developer:** [@Mateuzkl](https://github.com/Mateuzkl)
- **Discord:** `g.joker`
- **Issues:** [GitHub Issues](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/issues)

For installation questions, read this README first — especially the **vcpkg**, **client**, and **required map editor** sections.

---

## License & Credits

Licensed under the **GNU General Public License v2.0**.

### Development

- **[@Mateuzkl](https://github.com/Mateuzkl)** — Lead Developer

### Acknowledgements

- The Forgotten Server team
- OTLand community
- Xiadozu / Evolution-related project work
- Tolkien Estate

---

<div align="center">

## Dragon Souls RPG

**TFS 1.4 · Protocol 11.00 · Custom Client · [NexaMap Editor](https://github.com/Mateuzkl/NexaMap-Editor)**

*"Nem todos os que vagam estão perdidos."*
— **J.R.R. Tolkien**

</div>
