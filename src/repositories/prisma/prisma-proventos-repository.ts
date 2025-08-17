import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaProventosRepository {
  async create(data: Prisma.ProventosCreateInput) {
    const provento = await prisma.proventos.create({
      data,
    })

    return provento
  }
}