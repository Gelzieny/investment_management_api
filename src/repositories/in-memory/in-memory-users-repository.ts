

import { randomUUID } from 'node:crypto'

import type { UsersRepository } from '../users-repository'
import type { Prisma, Usuarios } from '@prisma/client'

export class InMemoryUsersRepository implements UsersRepository {
  public items: Usuarios[] = []

  async findById(id: string) {
    const user = this.items.find((item) => item.codigo === Number(id))

    if (!user) {
      return null
    }

    return user
  }

  async findByEmail(email: string) {
    const user = this.items.find((item) => item.email === email)

    if (!user) {
      return null
    }

    return user
  }

  async create(data: Prisma.UsuariosCreateInput) {
    const user = {
      codigo: Number(randomUUID()),
      nome: data.nome,
      email: data.email,
      data_criacao: new Date(),
      senha: data.senha,
    }

    this.items.push(user)

    return user
  }
}