import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaNegociacoesRepository {
  async create(data: Prisma.NegociacoesCreateInput) {
    const negociacao = await prisma.negociacoes.create({
      data,
    })

    return negociacao
  }
}