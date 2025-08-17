/*
  Warnings:

  - You are about to drop the `Indicadores_Ativos` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."Indicadores_Ativos" DROP CONSTRAINT "Indicadores_Ativos_codigo_ativo_fkey";

-- DropForeignKey
ALTER TABLE "public"."Indicadores_Ativos" DROP CONSTRAINT "Indicadores_Ativos_codigo_usuario_fkey";

-- DropTable
DROP TABLE "public"."Indicadores_Ativos";

-- CreateTable
CREATE TABLE "public"."indicadores_ativos" (
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

    CONSTRAINT "indicadores_ativos_pkey" PRIMARY KEY ("codigo")
);

-- AddForeignKey
ALTER TABLE "public"."indicadores_ativos" ADD CONSTRAINT "indicadores_ativos_codigo_usuario_fkey" FOREIGN KEY ("codigo_usuario") REFERENCES "public"."usuarios"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."indicadores_ativos" ADD CONSTRAINT "indicadores_ativos_codigo_ativo_fkey" FOREIGN KEY ("codigo_ativo") REFERENCES "public"."ativos"("codigo") ON DELETE CASCADE ON UPDATE CASCADE;
