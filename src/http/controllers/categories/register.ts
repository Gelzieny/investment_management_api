import { prisma } from "@/lib/prisma";
import type { FastifyReply, FastifyRequest } from "fastify";
import z from "zod";

export async function registerController(request: FastifyRequest, reply: FastifyReply) {
  const registerBodySchema = z.object({ nome_categoria: z.string()});

  const { nome_categoria } = registerBodySchema.parse(request.body);

  await prisma.cat_Investimento.create({
    data: {
      nome_categoria
    },
  });

  return reply.status(201).send()

}