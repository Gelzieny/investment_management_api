import bcrypt from "bcryptjs";

import { prisma } from "@/lib/prisma";

interface RegisterUserRequest {
  nome: string;
  email: string;
  senha: string;
}

export class RegisterUserUseCase {
  async execute({ nome, email, senha }: RegisterUserRequest) {
    // Normalizar email
    const emailNormalized = email.trim().toLowerCase();

    // Verificar se usuário existe
    const userAlreadyExists = await prisma.usuarios.findUnique({
      where: { email: emailNormalized },
    });

    if (userAlreadyExists) {
      throw new Error("Usuário já existe");
    }

    // Hash da senha
    const hashedPassword = await bcrypt.hash(senha, 10);

    // Criar usuário
    const user = await prisma.usuarios.create({
      data: {
        nome,
        email: emailNormalized,
        senha: hashedPassword,
      },
    });

    return user;
  }
}
