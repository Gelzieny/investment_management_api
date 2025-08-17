-- CreateTable
CREATE TABLE "public"."usuarios" (
    "codigo" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "data_criacao" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "senha" VARCHAR(20) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."cat_investimento" (
    "codigo" SERIAL NOT NULL,
    "nome_categoria" VARCHAR(50) NOT NULL,

    CONSTRAINT "cat_investimento_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."ativos" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_categoria" INTEGER NOT NULL,
    "codigo_ativo" VARCHAR(20) NOT NULL,
    "nome_ativo" VARCHAR(100) NOT NULL,

    CONSTRAINT "ativos_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."historico_patrimonio" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_ativo" INTEGER NOT NULL,
    "data" DATE NOT NULL,
    "alteracao" VARCHAR(50),
    "quantidade" INTEGER NOT NULL,
    "novo_saldo" INTEGER NOT NULL,
    "preco_medio" DECIMAL(10,4) NOT NULL,

    CONSTRAINT "historico_patrimonio_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."negociacoes" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_ativo" INTEGER NOT NULL,
    "data" DATE NOT NULL,
    "corretora" VARCHAR(50),
    "tipo" CHAR(1) NOT NULL,
    "qtd" INTEGER NOT NULL,
    "preco" DECIMAL(10,2) NOT NULL,
    "total" DECIMAL(10,2),
    "preco_com_taxas" DECIMAL(10,4),
    "total_com_taxas" DECIMAL(10,2),

    CONSTRAINT "negociacoes_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."proventos" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_ativo" INTEGER NOT NULL,
    "data_pagamento" DATE NOT NULL,
    "data_com" DATE NOT NULL,
    "tipo" VARCHAR(50) NOT NULL,
    "valor_por_cota" DECIMAL(10,4) NOT NULL,
    "total_recebido" DECIMAL(10,2),
    "percentual_on_cost" DECIMAL(5,2),

    CONSTRAINT "proventos_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."Indicadores_Ativos" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_ativo" INTEGER NOT NULL,
    "data" DATE NOT NULL,
    "valor_mercado" BIGINT,
    "patrimonio" BIGINT,
    "p_vp" DECIMAL(5,2),
    "retorno_12m_percentual" DECIMAL(5,2),
    "retorno_12m_real" DECIMAL(5,2),
    "variacao_12m" DECIMAL(5,2),
    "preco_min_52sem" DECIMAL(10,2),
    "preco_max_52sem" DECIMAL(10,2),

    CONSTRAINT "Indicadores_Ativos_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."roles" (
    "codigo" SERIAL NOT NULL,
    "nome_role" VARCHAR(50) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."permissoes" (
    "codigo" SERIAL NOT NULL,
    "nome_permissao" VARCHAR(100) NOT NULL,

    CONSTRAINT "permissoes_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."usuario_roles" (
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_role" INTEGER NOT NULL,

    CONSTRAINT "usuario_roles_pkey" PRIMARY KEY ("codigo_usuario","codigo_role")
);

-- CreateTable
CREATE TABLE "public"."role_permissoes" (
    "codigo_role" INTEGER NOT NULL,
    "codigo_permissao" INTEGER NOT NULL,

    CONSTRAINT "role_permissoes_pkey" PRIMARY KEY ("codigo_role","codigo_permissao")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "public"."usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "cat_investimento_nome_categoria_key" ON "public"."cat_investimento"("nome_categoria");

-- CreateIndex
CREATE UNIQUE INDEX "ativos_codigo_codigo_ativo_key" ON "public"."ativos"("codigo", "codigo_ativo");

-- CreateIndex
CREATE UNIQUE INDEX "roles_nome_role_key" ON "public"."roles"("nome_role");

-- CreateIndex
CREATE UNIQUE INDEX "permissoes_nome_permissao_key" ON "public"."permissoes"("nome_permissao");

-- AddForeignKey
ALTER TABLE "public"."ativos" ADD CONSTRAINT "ativos_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ativos" ADD CONSTRAINT "ativos_codigo_categoria_fkey" FOREIGN KEY ("codigo_categoria") REFERENCES "public"."cat_investimento"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."historico_patrimonio" ADD CONSTRAINT "historico_patrimonio_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."historico_patrimonio" ADD CONSTRAINT "historico_patrimonio_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."negociacoes" ADD CONSTRAINT "negociacoes_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."negociacoes" ADD CONSTRAINT "negociacoes_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."proventos" ADD CONSTRAINT "proventos_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."proventos" ADD CONSTRAINT "proventos_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Indicadores_Ativos" ADD CONSTRAINT "Indicadores_Ativos_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Indicadores_Ativos" ADD CONSTRAINT "Indicadores_Ativos_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usuario_roles" ADD CONSTRAINT "usuario_roles_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usuario_roles" ADD CONSTRAINT "usuario_roles_codigo_role_fkey" FOREIGN KEY ("codigo_role") REFERENCES "public"."roles"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."role_permissoes" ADD CONSTRAINT "role_permissoes_codigo_role_fkey" FOREIGN KEY ("codigo_role") REFERENCES "public"."roles"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."role_permissoes" ADD CONSTRAINT "role_permissoes_codigo_permissao_fkey" FOREIGN KEY ("codigo_permissao") REFERENCES "public"."permissoes"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;
