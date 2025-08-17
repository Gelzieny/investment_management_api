import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaUsersRepository {
  async create(data: Prisma.UsuariosCreateInput) {

    const user = await prisma.usuarios.create({
      data,
    })

    return user
  }

  async findByEmail(email: string) {
    const user = await prisma.usuarios.findUnique({
      where: {
        email,
      },
    })

    return user
  }

  async findById(id: string) {
    const user = await prisma.usuarios.findUnique({
      where: {
        codigo: Number(id),
      },
    })

    return user
  }


}
