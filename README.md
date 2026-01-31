<div align="center">

# 🐉 Dragon Souls RPG

### The Middle-earth MMORPG Experience

[![Build Status](https://ci.appveyor.com/api/projects/status/github/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00?svg=true)](https://ci.appveyor.com/project/Mateuzkl/dragon-souls-tfs-1-4-protocol-11-00)
[![Version](https://img.shields.io/badge/version-1.4.0-blue?style=flat-square)](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/releases)
[![Protocol](https://img.shields.io/badge/protocol-11.00-orange?style=flat-square)](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00)
[![License](https://img.shields.io/badge/license-GPL--2.0-red?style=flat-square)](LICENSE)

*Um servidor de Tibia baseado no universo de **O Senhor dos Anéis**, desenvolvido sobre a engine **TFS 1.4**.*

[Recursos](#-recursos) • [Instalação](#-instalação-e-compilação) • [Sistemas](#-documentação-de-sistemas) • [Contribuição](#-como-contribuir) • [Suporte](#-suporte)

</div>

---

## 📖 Sobre o Projeto

**Dragon Souls RPG** é uma fusão ambiciosa entre a nostalgia clássica do Tibia 7.92 e a estabilidade das engines modernas. Este projeto visa recriar a atmosfera épica da Terra Média, permitindo que os jogadores explorem locais icônicos e enfrentem criaturas lendárias, tudo suportado por uma infraestrutura técnica robusta.

### 🌟 Destaques
- **Performance de Ponta:** Baseado no TFS 1.4, garantindo estabilidade e otimização.
- **Protocolo Moderno:** Compatibilidade nativa com protocolo 11.00 e suporte total ao **OTClient**.
- **Imersão Total:** Ambientação fiel, incluindo raças (Elfos, Anões, Humanos) e geografia de Tolkien.

---

## 🔗 Links Oficiais

| Recurso | Descrição | Link |
| :--- | :--- | :--- |
| **Client** | Cliente OTCv8 customizado | [Acessar Repositório](https://github.com/Mateuzkl/Dragon-Souls-Client) |
| **Sprites** | Repositório de Sprites 11.x | [Acessar Repositório](https://github.com/Mateuzkl/SPR-11x-Dragon-Souls) |
| **Map Editor** | RME customizado para o projeto | [Acessar Repositório](https://github.com/Mateuzkl/RME-dragon-souls) |
| **Ferramentas** | Utilitários para assets (Item Editor, OBJ Builder) | [Acessar Tools](https://github.com/otg-br/tools) |

---

## �️ Recursos Técnicos

### Engine & Compatibilidade
*   **Core:** The Forgotten Server 1.4 (C++17)
*   **Protocolo:** 11.00
*   **Database:** MySQL (Alta performance e integridade de dados)
*   **Integração:** API REST nativa para web services
*   **Logs:** Sistema detalhado para debugging e auditoria

### Gameplay & Sistemas
*   **Combate:** Sistema balanceado 7.92 com mecânicas modernas (Stun, Hastega).
*   **Cooldown Avançado:** Feedback visual e mensagens automáticas precisas.
*   **Proteção de Itens:** Sistema AOL Inteligente com estados energizados.
*   **Geral:** Party System reformulado, Guilds completas, Sistema de Casas e Ciclo Dia/Noite.

---

## 🚀 Instalação e Compilação

Para garantir a melhor performance e compatibilidade, siga rigorosamente os passos abaixo para preparar o ambiente de desenvolvimento.

### 1. Preparação do Ambiente (vcpkg)

> [!WARNING]
> **Atenção:** Versões recentes do vcpkg podem causar incompatibilidade. Utilize a versão homologada abaixo.

1.  **Download do vcpkg homologado (aprox. 5GB):**
    [Baixar vcpkg.rar](https://www.mediafire.com/file/ipd4qzohe9jwji3/vcpkg.rar/file)

2.  **Instalação:**
    Extraia o conteúdo diretamente em `C:\vcpkg`.

3.  **Bootstrap e Integração:**
    Abra o PowerShell como Administrador e execute:
    ```powershell
    cd C:\vcpkg
    .\bootstrap-vcpkg.bat
    .\vcpkg.exe integrate install
    ```

### 2. Atualização da Baseline (Opcional)
Caso necessário, atualize a baseline do projeto para sincronizar as dependências:
```powershell
cd "C:\Caminho\Para\Dragon-Souls-TFS-1.4-Protocol-11.00"
C:\vcpkg\vcpkg.exe x-update-baseline
```

### 3. Compilação (Visual Studio 2022)
1.  Abra o arquivo de solução `engine\vc17\theforgottenserver.sln`.
2.  Selecione a configuração **Release** e plataforma **x64**.
3.  Compile a solução (`Ctrl` + `Shift` + `B`). O Visual Studio baixará as dependências automaticamente.

---

## 📘 Documentação de Sistemas

### � Sistema de Cooldown Avançado

Implementação robusta para gerenciamento de exaustão de magias com feedback preciso ao jogador.

**Exemplo de Configuração (`spells.xml`):**
```xml
<instant name="Glaciate" words="adori frigo" spellid="201" exhaustion="7" cooldownmsg="1" script="adori frigo.lua">
    <vocation id="1"/><vocation id="5"/>
</instant>
```

| Atributo | Descrição | Regra de Valor |
| :--- | :--- | :--- |
| `exhaustion` | Tempo de recarga | `< 50`: Segundos (ex: 7 = 7s)<br>`≥ 50`: Milissegundos (ex: 7000 = 7s) |
| `cooldownmsg` | Mensagem de feedback | `1`: Ativa |

---

### 🛡️ Sistema AOL Customizado (Energized Amulet of Loss)

Sistema inteligente de proteção de inventário baseado no estado do amuleto e penalidades do jogador.

#### Estados do Amuleto
*   🟢 **Energizado:** Proteção TOTAL (exceto Red/Black Skull). Efeito visual ativo.
*   ⚪ **Desenergizado:** Sem proteção. Funciona como colar decorativo.

#### Regras de Penalidade (Skulls)
| Estado do Jogador | Proteção do AOL | Comportamento na Morte |
| :--- | :---: | :--- |
| **Normal** | ✅ Ativa | Protege todos os itens se energizado. |
| **Red Skull** 🔴 | ❌ Inativa | Perda total de itens, ignorando o amuleto. |
| **Black Skull** ⚫ | ❌ Inativa | Perda total + Dano extra recebido. |

---

### ⚙️ Configuração do Cliente (OTCV8)

Para garantir o funcionamento correto de todos os recursos visuais no protocolo 11.00, adicione o seguinte trecho ao seu `modules/game_features/features.lua`:

```lua
if g_game.getProtocolVersion() >= 1100 then
    g_game.enableFeature(GameSpritesAlphaChannel)
    g_game.enableFeature(GameMagicEffectU16)
    g_game.enableFeature(GameDistanceEffectU16)
    g_game.enableFeature(GameCountU16)
    g_game.enableFeature(GameChangeMapAwareRange) -- Importante para viewport estendido
end
```

---

## 🗺️ Roadmap e Status

### Em Desenvolvimento
- [ ] **Montarias:** Sistema completo de montarias.
- [ ] **Expansão de Mapa:** Novas áreas de Rohan.
- [ ] **Sistema de Clãs:** Hierarquia e benefícios por raça.
- [ ] **Eventos:** Rotação automática de eventos diários/semanais.

### 🐛 Problemas Conhecidos
*   **Conversão de Mapas:** Mapas antigos (7.92) necessitam de conversão para estrutura 10.98+.
*   **Compatibilidade de Itens:** Alguns IDs de versões antigas podem exigir remapeamento.
*   **Otimização:** Refatoração contínua de scripts legacy para LuaJIT.

---

## 🤝 Como Contribuir

Contribuições são bem-vindas! Se você deseja ajudar a moldar o futuro do Dragon Souls:

1.  Faça um **Fork** do projeto.
2.  Crie uma Branch para sua feature (`git checkout -b feature/MinhaFeature`).
3.  Commit suas mudanças (`git commit -m 'Adiciona: MinhaFeature'`).
4.  Push para a Branch (`git push origin feature/MinhaFeature`).
5.  Abra um **Pull Request**.

---

## � Suporte e Comunidade

*   **Discord:** `g.joker`
*   **Issues:** Utilize a aba [Issues](https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00/issues) para reportar bugs.

---

## 📜 Licença e Créditos

Este projeto é licenciado sob a **GNU General Public License v2.0**.

**Desenvolvimento:**
*   **[@Mateuzkl](https://github.com/Mateuzkl)** - Lead Developer

**Agradecimentos:**
*   TFS Team, OTLand Community, Xiadozu (Evolution), e Tolkien Estate.

<div align="center">
<br>

*"Nem todos os que vagam estão perdidos."*
<br>
— **J.R.R. Tolkien**

</div>
