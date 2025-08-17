import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaIndAtivosRepository {
  async create(data: Prisma.IndAtivosCreateInput) {
    const indAtivo = await prisma.indAtivos.create({
      data,
    })

    return indAtivo
  }
}