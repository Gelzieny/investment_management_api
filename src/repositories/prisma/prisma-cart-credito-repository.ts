import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaCartCreditoRepository {
  async create(data: Prisma.CartCreditoCreateInput) {
    const cartCredito = await prisma.cartCredito.create({
      data,
    })

    return cartCredito
  }
}