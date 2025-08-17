import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaTranViagemRepository {
  async create(data: Prisma.TranViagemCreateInput) {
    const tranViagem = await prisma.tranViagem.create({
      data,
    })

    return tranViagem
  }
}