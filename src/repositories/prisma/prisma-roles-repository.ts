import { prisma } from "@/lib/prisma"
import type { Prisma } from "@prisma/client"

export class PrismaRolesRepository {
  async create(data: Prisma.RolesCreateInput) {
    const role = await prisma.roles.create({
      data,
    })

    return role
  }
}

export class PrismaPermissoesRepository {
  async create(data: Prisma.PermissoesCreateInput) {
    const permissao = await prisma.permissoes.create({
      data,
    })

    return permissao
  }
}

export class PrismaUserRolesRepository {
  async create(data: Prisma.UserRolesCreateInput) {
    const userRole = await prisma.userRoles.create({
      data,
    })

    return userRole
  }
}

export class PrismaRolePermissoesRepository {
  async create(data: Prisma.RolePermissoesCreateInput) {
    const rolePermissao = await prisma.rolePermissoes.create({
      data,
    })

    return rolePermissao
  }
}

