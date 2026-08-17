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
![RME](https://img.shields.io/badge/RME-DS%20CUSTOM-dc2626?style=for-the-badge)

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

# ⚠️ ATTENTION — REQUIRED RME FOR THIS PROJECT

> [!CAUTION]
> # USE ONLY THE DRAGON SOULS RME LINKED BELOW
>
> **Do not use another Remere's Map Editor build with this server base.**
>
> Dragon Souls uses a customized RME with support for the project's **Stack/Count values up to 10000**, related to the implemented `uint16` changes.
>
> Using another RME can produce incompatible map/item data and may cause the server to fail when interpreting or loading the map correctly.
>
> **For Dragon Souls TFS 1.4, use only this specific RME:**
>
> **[DOWNLOAD / OPEN DRAGON SOULS RME](https://github.com/Mateuzkl/OTAcademy_RME)**

### Simple setup rule

1. Read this README before compiling.
2. Install/configure the required `vcpkg`.
3. Recompile the **server**.
4. Recompile the **client**.
5. Download the **Dragon Souls RME** from the link above.
6. Open and use that RME normally.
7. **Do not replace it with another RME.**

The RME is already prepared for this project. No additional RME compilation is required for normal use.

A more detailed beginner-friendly tutorial can be added later, but these requirements must be followed first.

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
| Map Editor | Custom Dragon Souls / OTAcademy RME |
| Stack / Count | Project-specific support up to 10000 through `uint16` changes |
| World | Middle-earth-inspired RPG setting |
| Gameplay | Classic-oriented combat with custom modern systems |
| Tooling | Custom sprites, item tools and RME workflow |

---

## Official Links

| Resource | Description | Link |
|---|---|---|
| **Server** | Dragon Souls TFS 1.4 / Protocol 11.00 | [Repository](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00) |
| **Client** | Custom OTCv8 client | [Dragon Souls Client](https://github.com/Mateuzkl/Dragon-Souls-Client) |
| **Sprites** | Dragon Souls 11.x sprite repository | [SPR-11x-Dragon-Souls](https://github.com/Mateuzkl/SPR-11x-Dragon-Souls) |
| **Map Editor** | **Required custom RME for this project** | **[OTAcademy_RME](https://github.com/Mateuzkl/OTAcademy_RME)** |
| **Tools** | Asset utilities, Item Editor and Object Builder | [OTG Tools](https://github.com/otg-br/tools) |

> [!IMPORTANT]
> The **Map Editor** link above is not optional for this project workflow.
> Use that RME for Dragon Souls maps.

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
        +-- Dragon Souls / OTAcademy RME
        |      └── Stack / Count up to 10000
        |          through project uint16 changes
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
- Confirm required RME.
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
> # DO NOT USE ANOTHER RME
>
> Use only:
>
> **[Dragon Souls / OTAcademy RME](https://github.com/Mateuzkl/OTAcademy_RME)**
>
> Reason: this version contains project-specific compatibility for **Stack/Count up to 10000** and the corresponding `uint16` changes.
>
> Another RME may save map/item data differently and can cause loading or interpretation problems in Dragon Souls TFS 1.4.

### RME setup

No compilation is required for normal use if you use the prepared build supplied through the project link.

Workflow:

```text
Download required RME
        ↓
Extract / open
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
- RME must use the Dragon Souls-compatible implementation.
- Item/sprite data must remain aligned.
- Maps should be tested after editing.

### Maximum documented Stack / Count

```text
10000
```

This is the primary reason the project requires its custom RME.

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
- Test map changes with the required Dragon Souls RME.

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
- Map/RME information when applicable.
- Screenshot/video when useful.

---

## Support & Community

- **Developer:** [@Mateuzkl](https://github.com/Mateuzkl)
- **Discord:** `g.joker`
- **Issues:** [GitHub Issues](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/issues)

For installation questions, read this README first—especially the **vcpkg**, **client**, and **required RME** sections.

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

**TFS 1.4 · Protocol 11.00 · Custom Client · Required DS RME**

*"Nem todos os que vagam estão perdidos."*  
— **J.R.R. Tolkien**

</div>
