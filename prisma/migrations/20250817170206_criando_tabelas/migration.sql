-- CreateTable
CREATE TABLE "public"."usuarios" (
    "codigo" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "email" VARCHAR(100) NOT NULL,
    "data_criacao" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "senha" VARCHAR(100) NOT NULL,

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
    "id_usuario" INTEGER NOT NULL,
    "id_categoria" INTEGER NOT NULL,
    "codigo_ativo" VARCHAR(20) NOT NULL,
    "nome" VARCHAR(100) NOT NULL,

    CONSTRAINT "ativos_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."hist_patrimonio" (
    "id_historico" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_ativo" INTEGER NOT NULL,
    "data" DATE NOT NULL,
    "alteracao" VARCHAR(50),
    "quantidade" INTEGER NOT NULL,
    "novo_saldo" INTEGER NOT NULL,
    "preco_medio" DECIMAL(10,4) NOT NULL,

    CONSTRAINT "hist_patrimonio_pkey" PRIMARY KEY ("id_historico")
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
CREATE TABLE "public"."ind_ativos" (
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

    CONSTRAINT "ind_ativos_pkey" PRIMARY KEY ("codigo")
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
CREATE TABLE "public"."user_roles" (
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_role" INTEGER NOT NULL,

    CONSTRAINT "user_roles_pkey" PRIMARY KEY ("codigo_usuario","codigo_role")
);

-- CreateTable
CREATE TABLE "public"."role_permissoes" (
    "codigo_role" INTEGER NOT NULL,
    "codigo_permissao" INTEGER NOT NULL,

    CONSTRAINT "role_permissoes_pkey" PRIMARY KEY ("codigo_role","codigo_permissao")
);

-- CreateTable
CREATE TABLE "public"."transacoes_viagem" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "data" DATE NOT NULL,
    "valor_original" DECIMAL(10,2) NOT NULL,
    "moeda_original" VARCHAR(10) NOT NULL,
    "valor_convertido" DECIMAL(10,2) NOT NULL,
    "moeda_convertida" VARCHAR(10) NOT NULL,
    "taxa_conversao" DECIMAL(10,4) NOT NULL,
    "tipo_transacao" VARCHAR(50) NOT NULL,
    "descricao" VARCHAR(255),

    CONSTRAINT "transacoes_viagem_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."juros_wise" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "data" DATE NOT NULL,
    "moeda" VARCHAR(10) NOT NULL,
    "valor_juros" DECIMAL(10,2) NOT NULL,
    "saldo_base" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "juros_wise_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."contas" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "nome_conta" VARCHAR(100) NOT NULL,
    "instituicao" VARCHAR(100),
    "tipo" VARCHAR(50) NOT NULL,
    "saldo_inicial" DECIMAL(10,2) NOT NULL,
    "cor" VARCHAR(20),

    CONSTRAINT "contas_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."cat_financas" (
    "codigo" SERIAL NOT NULL,
    "nome_categoria" VARCHAR(100) NOT NULL,
    "tipo_categoria" VARCHAR(20) NOT NULL,

    CONSTRAINT "cat_financas_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."transacoes" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "codigo_conta" INTEGER NOT NULL,
    "codigo_categoria_financas" INTEGER,
    "descricao" VARCHAR(255),
    "valor" DECIMAL(10,2) NOT NULL,
    "data" DATE NOT NULL,
    "tipo_transacao" VARCHAR(20) NOT NULL,
    "marcado_pago" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "transacoes_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "public"."cartoes_credito" (
    "codigo" SERIAL NOT NULL,
    "codigo_usuario" INTEGER NOT NULL,
    "nome_cartao" VARCHAR(100) NOT NULL,
    "banco" VARCHAR(100),
    "tipo_cartao" VARCHAR(50),
    "bandeira" VARCHAR(50),
    "ultimos_quatro_digitos" VARCHAR(4) NOT NULL,
    "limite" DECIMAL(10,2),
    "cor" VARCHAR(20),
    "ativo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "cartoes_credito_pkey" PRIMARY KEY ("codigo")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_email_key" ON "public"."usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "cat_investimento_nome_categoria_key" ON "public"."cat_investimento"("nome_categoria");

-- CreateIndex
CREATE UNIQUE INDEX "ativos_id_usuario_codigo_ativo_key" ON "public"."ativos"("id_usuario", "codigo_ativo");

-- CreateIndex
CREATE UNIQUE INDEX "roles_nome_role_key" ON "public"."roles"("nome_role");

-- CreateIndex
CREATE UNIQUE INDEX "permissoes_nome_permissao_key" ON "public"."permissoes"("nome_permissao");

-- AddForeignKey
ALTER TABLE "public"."ativos" ADD CONSTRAINT "ativos_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ativos" ADD CONSTRAINT "ativos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "public"."cat_investimento"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."hist_patrimonio" ADD CONSTRAINT "hist_patrimonio_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."hist_patrimonio" ADD CONSTRAINT "hist_patrimonio_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."negociacoes" ADD CONSTRAINT "negociacoes_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."negociacoes" ADD CONSTRAINT "negociacoes_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."proventos" ADD CONSTRAINT "proventos_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."proventos" ADD CONSTRAINT "proventos_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ind_ativos" ADD CONSTRAINT "ind_ativos_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ind_ativos" ADD CONSTRAINT "ind_ativos_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_roles" ADD CONSTRAINT "user_roles_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_roles" ADD CONSTRAINT "user_roles_codigo_role_fkey" FOREIGN KEY ("codigo_role") REFERENCES "public"."roles"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."role_permissoes" ADD CONSTRAINT "role_permissoes_codigo_role_fkey" FOREIGN KEY ("codigo_role") REFERENCES "public"."roles"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."role_permissoes" ADD CONSTRAINT "role_permissoes_codigo_permissao_fkey" FOREIGN KEY ("codigo_permissao") REFERENCES "public"."permissoes"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."transacoes_viagem" ADD CONSTRAINT "transacoes_viagem_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."juros_wise" ADD CONSTRAINT "juros_wise_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."contas" ADD CONSTRAINT "contas_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."transacoes" ADD CONSTRAINT "transacoes_codigo_conta_fkey" FOREIGN KEY ("codigo_conta") REFERENCES "public"."contas"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."transacoes" ADD CONSTRAINT "transacoes_codigo_categoria_financas_fkey" FOREIGN KEY ("codigo_categoria_financas") REFERENCES "public"."cat_financas"("codigo") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."transacoes" ADD CONSTRAINT "transacoes_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cartoes_credito" ADD CONSTRAINT "cartoes_credito_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;
