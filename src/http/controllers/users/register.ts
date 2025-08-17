import { z } from "zod";
import type { FastifyReply, FastifyRequest } from "fastify";
import { RegisterUserUseCase } from "@/use-cases/user/register_user_case";
import { InMemoryUsersRepository } from "@/repositories/in-memory/in-memory-users-repository";
import { UserAlreadyExistsError } from "@/use-cases/errors/user-already-exists-error";

// const registerUserUseCase = new RegisterUserUseCase();

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
    const usersRepository = new InMemoryUsersRepository()
     const registerUseCase = new RegisterUserUseCase(usersRepository);

    
     await registerUseCase.execute({
      nome,
      email,
      senha,
    })
  } catch (err) {
   if (err instanceof UserAlreadyExistsError) {
      return reply.status(409).send({ message: err.message });
    }
     throw err
  }
  return reply.status(201).send()
}
