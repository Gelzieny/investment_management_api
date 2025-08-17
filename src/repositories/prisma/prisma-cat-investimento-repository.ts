import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"


export class PrismaCategoriesRepository {
  async create(data: Prisma.CatInvestimentoCreateInput) {
    const category = await prisma.catInvestimento.create({
      data,
    })

    return category
  }

}
