import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"


export class PrismaCatFinancasRepository {
  async create(data: Prisma.CatFinancasCreateInput) {
    const category = await prisma.catFinancas.create({
      data,
    })

    return category
  }

}
