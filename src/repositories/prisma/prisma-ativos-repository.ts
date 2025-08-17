import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaAtivosRepository {
  async create(data: Prisma.AtivosCreateInput) {
    const ativo = await prisma.ativos.create({
      data,
    })

    return ativo
  }
}