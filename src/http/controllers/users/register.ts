import { z } from "zod";
import type { FastifyReply, FastifyRequest } from "fastify";

import { RegisterUserUseCase } from "@/use-cases/user/register_user_case";



const registerUserUseCase = new RegisterUserUseCase();

export async function registerController(
  request: FastifyRequest,
  reply: FastifyReply
) {

  const registerBodySchema = z.object({
    nome: z.string().min(1, "Nome é obrigatório"),
    email: z.string().email("Email inválido"),
    senha: z.string().min(6, "Senha deve ter no mínimo 6 caracteres"),
  });

  const { nome, email, senha } = registerBodySchema.parse(request.body);

  try {
    const user = await registerUserUseCase.execute({ nome, email, senha });

    return reply.status(201).send({
      message: "Usuário criado com sucesso",
      user: { codigo: user.codigo, nome: user.nome, email: user.email },
    });
  } catch (err: any) {
    if (err.message === "Usuário já existe") {
      return reply.status(409).send({ message: err.message });
    }
    console.error(err);
    return reply.status(500).send({ message: "Erro interno do servidor" });
  }
}
