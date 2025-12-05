# 🐉 Dragon Souls RPG v1.0 - TFS 1.4 Protocol 11.00

**Dragon Souls RPG v1.0** é um servidor de Tibia baseado no universo de **O Senhor dos Anéis**, desenvolvido sobre a engine **TFS 1.4** com **protocolo 11.00**. O projeto combina a nostalgia do Tibia clássico 7.92 com a performance e estabilidade das engines modernas.

## 📋 Índice

- [Características](#-características)
- [Funcionalidades Implementadas](#️-funcionalidades-implementadas)
- [Sistema de Cooldown Avançado](#-sistema-de-cooldown-avançado)
- [Requisitos do Sistema](#-requisitos-do-sistema)
- [Instalação](#-instalação)
- [Configuração](#️-configuração)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Desenvolvimento](#-desenvolvimento)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

## 🔗 Links Oficiais
- SPR 11.x: https://github.com/Mateuzkl/SPR-11x-Dragon-Souls
- RME: https://github.com/Mateuzkl/RME-dragon-souls

## 🌟 Características

### Engine e Protocolo
- **TFS 1.4** - Engine moderna e estável
- **Protocolo 11.00** - Compatibilidade com clientes modernos
- **OTClient** - Suporte completo para cliente customizado
- **Performance otimizada** - Sem travamentos ou instabilidades

### Temática
- **Universo de O Senhor dos Anéis** - Ambientação fiel ao mundo de Tolkien
- **Raças jogáveis**: Elfos, Anões e Humanos
- **Locais icônicos**: Rivendell, Minas Tirith, Mordor, Rohan
- **Criaturas épicas**: Orcs, Nazgûls, Balrogs, Trolls

## ⚔️ Funcionalidades Implementadas

### ✅ Sistemas de Combate
- **Hastega System** - Aumento de velocidade de ataque
- **Sistema de Stun** - Paralisia temporária em combate
- **Reset System** - Sistema de reset de personagem
- **Sistema de Cooldown Avançado** - Mensagens automáticas de cooldown
- **Sistema AOL Customizado** - AOL com estados energizado/desenergizado
- **Combate balanceado** - Baseado no Tibia 7.92

### ✅ Sistemas de Gameplay
- **Vocações customizadas** por raça
- **Sistema de guilds** completo
- **PvP balanceado** entre raças
- **Quests épicas** inspiradas nos livros
- **Sistema de casas** e propriedades

### ✅ Recursos Técnicos
- **Database MySQL** - Armazenamento confiável
- **Sistema de backup** automático
- **Logs detalhados** para debugging
- **API REST** para integração web
- **Sistema de eventos** automatizados

## 🔮 Sistema de Cooldown Avançado

O Dragon Souls implementa um sistema completo de cooldown para magias com mensagens automáticas personalizadas.

### 📋 Configuração XML

Para configurar uma magia com cooldown de 7 segundos e mensagens ativadas:

```xml
<instant name="Glaciate" 
         words="adori frigo" 
         spellid="201" 
         exhaustion="7" 
         cooldownmsg="1" 
         script="adori frigo.lua">
    <vocation id="1"/><vocation id="5"/>
</instant>
```

### 🎯 Atributos Principais

| Atributo | Descrição | Valores |
|----------|-----------|---------|
| `exhaustion` | Tempo de cooldown | `< 50` = segundos<br>`≥ 50` = milissegundos |
| `cooldownmsg` | Ativa mensagem de CD | `0` = Desativado<br>`1` = Ativado |
| `spellid` | ID único da magia | Número único |

### 💬 Mensagens Automáticas

- **Quando o cooldown termina:** `CD: Nome da Magia`
- **Quando tenta usar em cooldown:** `voce nao esta pronto cooldown (Xs)`

### ⚙️ Lógica de Conversão

```cpp
// Valores menores que 50: tratados como segundos
if (exhaustion < 50) {
    exhaustion = exhaustion * 1000; // Converte para milissegundos
}
```

**Exemplos:**
- `exhaustion="7"` = 7 segundos
- `exhaustion="100"` = 100 milissegundos (0.1 segundo)
- `exhaustion="7000"` = 7000 milissegundos (7 segundos)

## 🛡️ Sistema AOL Customizado

O Dragon Souls possui um sistema avançado de AOL (Amulet of Loss) com estados energizado e desenergizado, oferecendo proteção inteligente contra perda de itens.

### 🔋 Estados do AOL

#### AOL Energizado (IDs: 38906, 38901, 38900)
- **Proteção total** - Protege todos os itens na morte
- **Exceções**: Red skull e Black skull seguem regras especiais
- **Visual diferenciado** - Aparência energizada no jogo

#### AOL Desenergizado
- **Sem proteção** - Funciona como se não tivesse AOL
- **Perda normal** - Itens podem ser perdidos na morte
- **Estado padrão** - AOL comum sem energia

### ⚙️ Configuração via items.xml

Para configurar um item com proteção AOL customizada:

```xml
<item id="38906" name="energized amulet of loss">
    <attribute key="weight" value="520"/>
    <attribute key="slotType" value="necklace"/>
    <attribute key="pressLoss" value="1"/>
    <attribute key="showduration" value="1"/>
</item>
```

### 🎯 Atributos de Configuração

| Atributo | Descrição | Valores |
|----------|-----------|---------|
| `pressLoss` | Ativa proteção AOL | `0` = Desativado<br>`1` = Ativado |
| `showduration` | Mostra duração | `0` = Não mostra<br>`1` = Mostra |
| `slotType` | Tipo de slot | `necklace` = Pescoço |

### 🏴‍☠️ Regras Especiais por Skull

#### Red Skull 🔴
- **Sempre perde tudo** - AOL não protege
- **Punição máxima** - Independente do estado do AOL

#### Black Skull ⚫
- **Comportamento padrão** - Segue regras normais
- **Drop completo** - Mais dano extra

#### Sem Skull ⚪
- **AOL energizado** - Proteção total
- **AOL desenergizado** - Sem proteção

### 💡 Exemplo de Uso

```cpp
// Verificação no código C++
if (player->hasEnergedAOL() && !player->hasRedSkull()) {
    // Protege todos os itens
    return false; // Não dropa itens
}
```

---

## 💻 Requisitos do Sistema

### Servidor
- **OS**: Windows 10/11 ou Linux Ubuntu 18.04+
- **RAM**: Mínimo 2GB, recomendado 4GB+
- **CPU**: Dual-core 2.0GHz+
- **Storage**: 5GB de espaço livre
- **MySQL**: 5.7+ ou MariaDB 10.2+

### Cliente
- **Tibia Client 10.98** para RME (Map Editor)
- **OTClient** para jogadores (protocolo 11.00)
- **RME (Remere's Map Editor)** para edição de mapas

## 🧩 OTClient e SPR 11.x

- **Cliente recomendado**: `otclientv8-ota` (Mirror oficial). Compila facilmente no Windows com `vcpkg` e Visual Studio 2022.
- **Ative recursos no cliente** no arquivo: `/modules/game_features/features.lua`:
```lua
g_game.enableFeature(GameSpritesAlphaChannel)
g_game.enableFeature(GameMagicEffectU16)
g_game.enableFeature(GameDistanceEffectU16)
```
- **SPR/DAT pack**: use [SPR-11x-Dragon-Souls](https://github.com/Mateuzkl/SPR-11x-Dragon-Souls) para sprites e efeitos com canal alpha e IDs U16.
- **RME pack**: use [RME-dragon-souls](https://github.com/Mateuzkl/RME-dragon-souls) para editar mapas no Remere (10.98).
- **Ferramentas úteis**: [otg-br/tools](https://github.com/otg-br/tools) (somente `Item Editor` e `OBJ Builder`) para manutenção de itens e assets.

### Observações
- `GameSpritesAlphaChannel` garante transparência correta em sprites.
- `GameMagicEffectU16` permite efeitos mágicos com IDs 16-bit usados nos packs 11.x.
- `GameDistanceEffectU16` permite efeitos de distância com IDs 16-bit.

## 🎨 Limites Expandidos de Efeitos

O Dragon Souls implementa suporte expandido para efeitos visuais, aumentando drasticamente o limite de IDs disponíveis.

### 📊 Limites de IDs

| Tipo de Efeito | Limite Antigo (uint8_t) | Limite Novo (uint16_t) | Aumento |
|----------------|-------------------------|------------------------|---------|
| **Magic Effects** | 256 (0-255) | **65.536** (0-65535) | 256x mais |
| **Distance Effects** | 256 (0-255) | **65.536** (0-65535) | 256x mais |

### 🚀 Benefícios

- **Mais efeitos visuais**: Suporte para até 65.536 efeitos mágicos únicos
- **Mais projéteis**: Suporte para até 65.536 efeitos de distância (flechas, magias, etc)
- **Compatibilidade**: Totalmente compatível com SPR 11.x que usa IDs U16
- **Sem limitações**: Liberdade total para criar novos efeitos customizados

### ⚙️ Implementação Técnica

A mudança foi feita alterando o tipo de dados de `uint8_t` (8 bits) para `uint16_t` (16 bits):

```cpp
// Antes (limite de 256)
uint8_t magicEffect = CONST_ME_NONE;
uint8_t distanceEffect = CONST_ANI_NONE;

// Depois (limite de 65.536)
uint16_t magicEffect = CONST_ME_NONE;
uint16_t distanceEffect = CONST_ANI_NONE;
```

### 🎯 Arquivos Modificados

- `engine/src/combat.h` - Estrutura de parâmetros de combate
- `engine/src/combat.cpp` - Lógica de efeitos de combate
- `engine/src/game.h` - Declarações de métodos de efeitos
- `engine/src/game.cpp` - Implementação de efeitos visuais
- `engine/src/enums.h` - Documentação de tipos de efeitos
- `engine/src/backup.cpp` - Sistema de backup de efeitos

### 💡 Como Usar

Agora você pode usar IDs de efeitos muito maiores em seus scripts:

```lua
-- Efeito mágico com ID alto
combat:setParameter(COMBAT_PARAM_EFFECT, 5000)

-- Efeito de distância com ID alto
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, 10000)
```

**Importante**: Certifique-se de que seu cliente OTClient tenha as features `GameMagicEffectU16` e `GameDistanceEffectU16` ativadas!

## 🚀 Instalação

### 1. Clone o Repositório
```bash
git clone https://github.com/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00.git
cd Dragon-Souls-TFS-1.4-Protocol-11.00
```

### 2. Configuração do Banco de Dados
```sql
-- Criar database
CREATE DATABASE dragonsouls;
USE dragonsouls;

-- Importar schema
source database/schema.sql;
```

### 3. Configuração do Servidor
```bash
# Copiar arquivo de configuração
cp config.lua.dist config.lua

# Editar configurações do banco
# Alterar: mysqlHost, mysqlUser, mysqlPass, mysqlDatabase
```

### 4. Preparar vcpkg (Windows)
```powershell
# Escolha onde instalar (ex.: C:\vcpkg)
git clone https://github.com/microsoft/vcpkg.git C:\vcpkg
cd C:\vcpkg
.\bootstrap-vcpkg.bat
.\vcpkg.exe integrate install
```

- O vcpkg instala exatamente na pasta que você clonou. Se você usar `C:\vcpkg`, tudo ficará nesse drive. Você pode usar `D:\vcpkg` ou `E:\vcpkg` da mesma forma.
- As bibliotecas compiladas ficam em `C:\vcpkg\installed\x64-windows` (ou no drive/pasta equivalente que você escolheu).
- O cache de artefatos é salvo em `%LOCALAPPDATA%\vcpkg\archives`.

### 5. Atualizar baseline do projeto (opcional)
```powershell
cd "C:\Users\SEU PC\Desktop\Dragon-Souls-TFS-1.4-Protocol-11.00"
C:\vcpkg\vcpkg.exe x-update-baseline
```

### 6. Compilação com Visual Studio
- Tenha o vcpkg instalado. Se já existir uma versão antiga, apague a pasta do vcpkg e instale novamente como acima.
- Abra `engine\vc17\theforgottenserver.vcxproj` (ou `engine\vc17\theforgottenserver.sln`) no Visual Studio.
- Clique em `Compilar Solução` (Ctrl+Shift+B).
- O próprio Visual Studio baixa todas as libs e dependências automaticamente via vcpkg até terminar.

### 7. Inicialização
```bash
# Linux
./start.sh

# Windows
theforgottenserver.exe
```

## ⚙️ Configuração

### config.lua Principal
```lua
-- Configurações do servidor
serverName = "Dragon Souls"
worldType = "open-pvp"
maxPlayers = 100

-- Database
mysqlHost = "localhost"
mysqlUser = "root"
mysqlPass = "password"
mysqlDatabase = "dragonsouls"

-- Rates
rateExp = 1
rateSkill = 1
rateLoot = 1
rateMagic = 1
```

### Portas e Conexões
- **Game Port**: 7172
- **Login Port**: 7171
- **Admin Port**: 7171
- **Status Port**: 7171

## 📁 Estrutura do Projeto

```
Dragon-Souls-TFS-1.4-Protocol-11.00/
├── 📁 data/                    # Scripts e dados do jogo
│   ├── 📁 actions/            # Scripts de ações
│   ├── 📁 spells/             # Magias e feitiços
│   ├── 📁 monster/            # Criaturas do jogo
│   ├── 📁 npc/                # NPCs e diálogos
│   └── 📁 world/              # Arquivos do mapa
├── 📁 engine/                  # Código fonte C++
│   ├── 📁 src/                # Arquivos fonte
│   └── 📁 build/              # Arquivos de compilação
├── 📁 database/               # Schema do banco de dados
├── 📁 util/                   # Utilitários e ferramentas
├── config.lua.dist            # Configuração padrão
└── README.md                  # Este arquivo
```

## 🛠️ Desenvolvimento

### Tecnologias Utilizadas
- **C++17** - Linguagem principal do servidor
- **Lua 5.2** - Scripts de gameplay
- **MySQL/MariaDB** - Banco de dados
- **CMake** - Sistema de build
- **Git** - Controle de versão

### 🔄 CI/CD (Continuous Integration)

O projeto utiliza **AppVeyor** para builds automáticos:

- ✅ Builds automáticos a cada commit
- ✅ Compilação para Windows x64 (Release)
- ✅ Geração automática de executáveis e DLLs
- ✅ Artifacts disponíveis para download

**Para configurar o AppVeyor**, consulte o guia completo em [APPVEYOR_SETUP.md](APPVEYOR_SETUP.md)

**Status do Build:** Clique no badge acima para ver o status mais recente do build.

### Funcionalidades em Desenvolvimento
- [ ] Sistema de montarias
- [ ] Novos mapas de Rohan
- [ ] Sistema de clãs por raça
- [ ] Eventos automáticos
- [ ] Sistema de recompensas diárias

### Como Contribuir
1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

##### 🐛 Problemas Conhecidos

- **Conversão de Mapas**: Mapas 7.92 precisam ser convertidos para 10.98
- **Compatibilidade**: Alguns items podem precisar de ajustes
- **Performance**: Otimizações contínuas sendo implementadas

## 📞 Suporte

### Contato
- **Discord**: [Dragon Souls Community](https://discord.gg/dragonsouls)
- **GitHub Issues**: Para reportar bugs
- **Email**: suporte@dragonsouls.com

### Documentação
- **Wiki**: [Dragon Souls Wiki](https://wiki.dragonsouls.com)
- **API Docs**: [API Documentation](https://api.dragonsouls.com/docs)
- **Scripting Guide**: [Lua Scripting Guide](https://docs.dragonsouls.com/scripting)

## 📊 Status do Projeto

[![Build status](https://ci.appveyor.com/api/projects/status/github/Mateuzkl/Dragon-Souls-TFS-1.4-Protocol-11.00?svg=true)](https://ci.appveyor.com/project/Mateuzkl/dragon-souls-tfs-1-4-protocol-11-00)
![Version](https://img.shields.io/badge/version-1.4.0-blue)
![Protocol](https://img.shields.io/badge/protocol-11.00-orange)
![License](https://img.shields.io/badge/license-GPL--2.0-red)

### Estatísticas
- **Linhas de Código**: ~50,000
- **Commits**: 500+
- **Contributors**: 5
- **Issues Resolvidas**: 150+

## 🏆 Créditos

### Desenvolvimento Principal
- **[@Mateuzkl](https://github.com/Mateuzkl)** - Desenvolvedor Principal

### Agradecimentos Especiais
- **TFS Team** - Engine base
- **OTLand Community** - Suporte e recursos
- **Evolution by Xiadozu** - Inspiração para sistemas 7.92
- **Tolkien Estate** - Universo de O Senhor dos Anéis

### Bibliotecas e Ferramentas
- **Boost C++** - Bibliotecas auxiliares
- **MySQL Connector** - Conexão com banco
- **Lua** - Engine de scripting
- **CMake** - Sistema de build

## 📄 Licença

Este projeto está licenciado sob a **GNU General Public License v2.0**.

Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<div align="center">

**🐉 Dragon Souls - Onde a Magia de Middle-earth Encontra o Tibia 🐉**

*"Nem todos os que vagam estão perdidos"* - J.R.R. Tolkien

</div>
