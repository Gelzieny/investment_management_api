import bcrypt, { hash } from "bcryptjs";

import { prisma } from "@/lib/prisma";
import type { PrismaUsersRepository } from "@/repositories/prisma/prisma-users-repository";
import { UserAlreadyExistsError } from "../errors/user-already-exists-error";

interface RegisterUseCaseRequest {
  nome: string;
  email: string;
  senha: string;
}

export class RegisterUserUseCase {
  constructor(private usersRepository: PrismaUsersRepository) {}

  async execute({ nome, email, senha }: RegisterUseCaseRequest) {

    const password_hash = await hash(senha, 6)
    const emailNormalized = email.trim().toLowerCase();

    const userAlreadyExists = await prisma.usuarios.findUnique({
      where: { email: emailNormalized },
    });

    if (userAlreadyExists) {
      throw new UserAlreadyExistsError();
    }

    const user = await prisma.usuarios.create({
      data: {
        nome,
        email: emailNormalized,
        senha: password_hash,
      },
    });

    return user;
  }
}
