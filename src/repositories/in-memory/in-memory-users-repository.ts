import { randomUUID } from 'node:crypto'
import type { UsersRepository } from '../users-repository'
import type { Prisma, Usuarios } from '@prisma/client'

export class InMemoryUsersRepository implements UsersRepository {
  public items: Usuarios[] = []

  async findById(id: number) {
    const user = this.items.find((item) => item.codigo === id)
    return user ?? null
  }

  async findByEmail(email: string) {
    const user = this.items.find((item) => item.email === email)
    return user ?? null
  }

  async create(data: Prisma.UsuariosCreateInput) {
    const user: Usuarios = {
      codigo:  this.items.length + 1, 
      nome: data.nome,
      email: data.email,
      data_criacao: new Date(),
      senha: data.senha,
    }

    this.items.push(user)

    return user
  }
}
