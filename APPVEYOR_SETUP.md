# 🚀 Como Ativar o AppVeyor CI/CD

Este guia explica como configurar o AppVeyor para fazer build automático do projeto no GitHub.

## 📋 Pré-requisitos

1. Conta no [AppVeyor](https://www.appveyor.com/)
2. Repositório no GitHub com o arquivo `.appveyor.yml` já commitado

## 🔧 Passo a Passo

### 1. Criar Conta no AppVeyor

1. Acesse [https://www.appveyor.com/](https://www.appveyor.com/)
2. Clique em **"Sign Up"** ou **"Sign In"**
3. Faça login com sua conta do **GitHub**

### 2. Conectar o Repositório

1. Após fazer login, clique em **"New Project"**
2. Selecione **"GitHub"** como fonte
3. Autorize o AppVeyor a acessar seus repositórios do GitHub
4. Selecione o repositório **Dragon-Souls-TFS-1.4-Protocol-11.00**
5. Clique em **"Add"**

### 3. Configurar o Projeto

1. O AppVeyor detectará automaticamente o arquivo `.appveyor.yml`
2. Vá em **Settings** → **General**
3. Certifique-se de que:
   - **Build worker image**: `Visual Studio 2022`
   - **Platform**: `x64`
   - **Configuration**: `Release`

### 4. Configurar Variáveis de Ambiente (se necessário)

Se você precisar de variáveis de ambiente específicas:
1. Vá em **Settings** → **Environment**
2. Adicione as variáveis necessárias

### 5. Ativar o Build

1. Vá em **Settings** → **General**
2. Certifique-se de que **"Build on commits"** está ativado
3. Salve as configurações

### 6. Testar o Build

1. Faça um commit no repositório (ou force um build manual)
2. Vá para a aba **"Builds"** no AppVeyor
3. Clique em **"New Build"** para testar manualmente
4. Aguarde o build completar

## 🎯 Como o GitHub Reconhece

### Badge de Status

Para adicionar um badge de status do build no README.md:

```markdown
[![Build status](https://ci.appveyor.com/api/projects/status/SEU_PROJECT_ID?svg=true)](https://ci.appveyor.com/project/SEU_USUARIO/dragon-souls-tfs-1-4-protocol-11-00)
```

**Para encontrar o link correto:**
1. Vá para o projeto no AppVeyor
2. Clique em **Settings** → **Badges**
3. Copie o código Markdown fornecido
4. Cole no seu README.md

### Webhooks Automáticos

O AppVeyor se conecta automaticamente ao GitHub via webhooks:
- Quando você faz push no GitHub, o AppVeyor recebe uma notificação
- O build é iniciado automaticamente
- Os resultados aparecem como **Status Checks** no GitHub

### Status Checks no GitHub

1. Vá em **Settings** → **Branches** no seu repositório GitHub
2. Configure branch protection rules (opcional)
3. Marque **"Require status checks to pass before merging"**
4. Selecione o AppVeyor como status check obrigatório

## 📦 Artifacts (Arquivos Gerados)

Após cada build bem-sucedido, os seguintes arquivos estarão disponíveis:

- `theforgottenserver-x64.exe` - Executável principal
- `*.dll` - Bibliotecas necessárias
- `Otg.zip` - Pacote completo com executável e DLLs

**Para baixar os artifacts:**
1. Vá para o build no AppVeyor
2. Clique na aba **"Artifacts"**
3. Baixe os arquivos desejados

## 🔍 Monitoramento

O AppVeyor monitora apenas mudanças nos seguintes arquivos/diretórios:
- `/engine/src/`
- `/engine/vc17/`
- `.appveyor.yml`
- `/engine/cmake/`

Builds serão executados apenas quando houver mudanças nesses arquivos.

## ⚙️ Configuração Atual

O arquivo `.appveyor.yml` está configurado para:

- **Imagem**: Visual Studio 2022
- **Plataforma**: x64
- **Configuração**: Release
- **Cache**: vcpkg instalado
- **Artifacts**: Executável, DLLs e ZIP

## 🐛 Troubleshooting

### Build Falhando

1. Verifique os logs do build no AppVeyor
2. Certifique-se de que todas as dependências estão instaladas
3. Verifique se o vcpkg está configurado corretamente

### GitHub Não Mostra Status

1. Verifique se os webhooks estão configurados corretamente
2. Vá em **Settings** → **Webhooks** no GitHub
3. Certifique-se de que o webhook do AppVeyor está ativo

### Cache Não Funciona

1. O cache do vcpkg está configurado em `c:\tools\vcpkg\installed\`
2. Certifique-se de que o caminho está correto
3. Limpe o cache se necessário: **Settings** → **Environment** → **Clear cache**

## 📚 Recursos Adicionais

- [Documentação do AppVeyor](https://www.appveyor.com/docs/)
- [Configuração do vcpkg](https://github.com/microsoft/vcpkg)
- [GitHub Actions (alternativa)](https://docs.github.com/en/actions)

## ✅ Checklist de Ativação

- [ ] Conta criada no AppVeyor
- [ ] Repositório conectado
- [ ] Arquivo `.appveyor.yml` commitado
- [ ] Build testado manualmente
- [ ] Badge adicionado no README (opcional)
- [ ] Webhooks configurados automaticamente
- [ ] Artifacts sendo gerados corretamente

---

**Pronto!** Seu projeto agora tem CI/CD configurado e o GitHub reconhecerá automaticamente os builds do AppVeyor! 🎉

