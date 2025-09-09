# 🐉 Dragon Souls - TFS 1.4 Protocol 11.00

**Dragon Souls** é um servidor de Tibia baseado no universo de **O Senhor dos Anéis**, desenvolvido sobre a engine **TFS 1.4** com **protocolo 11.00**. O projeto combina a nostalgia do Tibia clássico 7.92 com a performance e estabilidade das engines modernas.

## 📋 Índice

- [Características](#-características)
- [Funcionalidades Implementadas](#️-funcionalidades-implementadas)
- [Requisitos do Sistema](#-requisitos-do-sistema)
- [Instalação](#-instalação)
- [Configuração](#️-configuração)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Desenvolvimento](#-desenvolvimento)
- [Contribuição](#-contribuição)
- [Licença](#-licença)

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

## 💻 Requisitos do Sistema

### Servidor
- **OS**: Windows 10/11 ou Linux Ubuntu 18.04+
- **RAM**: Mínimo 2GB, recomendado 4GB+
- **CPU**: Dual-core 2.0GHz+
- **Storage**: 5GB de espaço livre
- **MySQL**: 5.7+ ou MariaDB 10.2+

### Cliente
- **Tibia Client 12.86** para RME (Map Editor)
- **OTClient** para jogadores (protocolo 11.00)
- **RME (Remere's Map Editor)** para edição de mapas

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

### 4. Compilação (Windows)
```bash
# Extrair executáveis
unrar x "EXE and DLL's.rar"

# Ou compilar do código fonte
cd engine
mkdir build && cd build
cmake ..
make
```

### 5. Inicialização
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

## 🐛 Problemas Conhecidos

- **Conversão de Mapas**: Mapas 7.92 precisam ser convertidos para 12.86
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

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
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
