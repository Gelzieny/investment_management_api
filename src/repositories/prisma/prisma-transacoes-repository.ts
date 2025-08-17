import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaTransacoesRepository {
  async create(data: Prisma.TransacoesCreateInput) {
    const transacao = await prisma.transacoes.create({
      data,
    })

    return transacao
  }
}
