import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaJurosWiseRepository {
  async create(data: Prisma.JurosWiseCreateInput) {
    const jurosWise = await prisma.jurosWise.create({
      data,
    })

    return jurosWise
  }
}