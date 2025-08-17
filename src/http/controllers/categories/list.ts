import { prisma } from "@/lib/prisma"
import type { FastifyReply, FastifyRequest } from "fastify"


export async function listCategoriesController(request: FastifyRequest, reply: FastifyReply) {
  const categories = await prisma.cat_Investimento.findMany()
  return categories
}

