import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaContasRepository {
  async create(data: Prisma.ContasCreateInput) {
    const conta = await prisma.contas.create({
      data,
    })

    return conta
  }
}