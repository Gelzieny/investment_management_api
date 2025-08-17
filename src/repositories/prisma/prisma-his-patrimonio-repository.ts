import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaHisPatrimonioRepository {
  async create(data: Prisma.HisPatrimonioCreateInput) {
    const hisPatrimonio = await prisma.hisPatrimonio.create({
      data,
    })

    return hisPatrimonio
  }
}