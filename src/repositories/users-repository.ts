import { Prisma, type Usuarios } from '@prisma/client'

export interface UsersRepository {
  findById(id: number): Promise<Usuarios | null>
  findByEmail(email: string): Promise<Usuarios | null>
  create(data: Prisma.UsuariosCreateInput): Promise<Usuarios>
}
