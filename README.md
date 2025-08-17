<p align="center">
  <a href="#">
    🔗 <img src=".github/imgs/logo.svg"  alt="Investimento Pessoal" width="300px"/>
  </a>
</p>

## 💻 Sobre o projeto
<p align="justify"></p>

## ⚙️ Descrição

<p align="justify">Investimento Pessoal é uma API para gestão de investimentos pessoais, com as seguintes funcionalidades:</p>


## Documentação da API

<p align="justify">A documentação da API está disponível no arquivo <strong>regras_requisitos</p>


📂 [regras_requisitos.md](.github/docs/regras_requisitos.md)

## ⚙️ Funcionalidades Planejadas

- 📝 **Cadastro de investimentos**
- 📅 **Cálculo de rentabilidade**
- ✅ **Dashboard com visão geral**:
- 📊 **Exportação de relatórios (PDF/CSV)**: Exportar relatórios de investimentos em formato PDF ou CSV.


## 🛠 Tecnologias

<p align="justify">Este projeto utiliza um conjunto de tecnologias modernas para garantir uma aplicação eficiente e escalável, incluindo:</p>


- 🟢 **[Node.js](https://nodejs.org/)**: Plataforma JavaScript utilizada para construir o servidor.
- 🟦 **[TypeScript](https://www.typescriptlang.org/)**: Superconjunto do JavaScript que adiciona tipagem estática opcional.
- ⚡ **[Fastify](https://www.fastify.io/)**: Framework web para Node.js, focado em alta performance e baixo overhead.
- 🐳 **[Docker Compose](https://docs.docker.com/compose/)**: Ferramenta para configurar e executar múltiplos containers Docker.
- 🛡️ **[Zod](https://zod.dev/)**: Biblioteca para validação de esquemas de dados e validações runtime.
- 🗄️ **[Drizzle ORM](https://orm.drizzle.team/)**: ORM leve e focado em performance.
- 🐘 **[Postgres](https://www.postgresql.org/)**: Banco de dados relacional utilizado para armazenamento de dados.
- 🆔 **[@paralleldrive/cuid2](https://github.com/paralleldrive/cuid2)**: Biblioteca para geração de IDs únicos de forma segura.
- 📆 **[Day.js](https://day.js.org/)**: Biblioteca para manipulação e formatação de datas.
- 🔐 **[Fastify-type-provider-zod](https://github.com/fastify/fastify-type-provider-zod)**: Provedor de tipos para integração entre Fastify e Zod, garantindo validação de tipos no Fastify.
- 🌱 **[Biome](https://biomejs.dev/)**: Ferramenta de linting e formatação para garantir código limpo.


## ⚠️ Requisitos de versão do Node.js

Para executar este projeto corretamente, especialmente ao rodar testes com **Vitest** e utilizar cobertura ou interface de testes, é necessário ter uma versão compatível do Node.js.

O Vite 7.x, utilizado como dependência do Vitest, exige:

- Node.js ^20.19.0 || >=22.12.0

````bash
Caso esteja com uma versão incompatível, você verá erros como:
  The engine "node" is incompatible with this module. Expected version "^20.19.0 || >=22.12.0". Got "20.12.0"
````

### 💡 Solução

1. Atualize o Node.js para a versão mínima exigida.
  No Windows, recomenda-se usar [nvm-windows](https://github.com/coreybutler/nvm-windows) para gerenciar versões.


```bash
  nvm install 20.19.0
  nvm use 20.19.0

  # Verifique a versão instalada
  node -v

  #Após atualizar, instale novamente o Vitest e sua UI:
  yarn add -D vitest@latest @vitest/ui@latest
```

## 🚀 Como executar o projeto

### Pré-requisitos

<p align="justify">Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:</p>

<a href="https://skillicons.dev">
  <img src="https://skillicons.dev/icons?i=git,nodejs,docker,vscode" />
</a>




# 🧑🏻‍💻 Autor

Feito com ❤️ por Gelzieny R. Martins 👋🏽 [Entre em contato!](https://gelzieny-dev.vercel.app/)

## 📝 Licença

Este projeto esta sobe a licença [MIT](./LICENSE).