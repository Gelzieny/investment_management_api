import type { Usuarios } from '@prisma/client'

import { UsersRepository } from '@/repositories/users-repository'
import { ResourceNotFoundError } from '../errors/resource-not-found-error'

interface GetUserProfileUseCaseRequest {
  userId: number
}

interface GetUserProfileUseCaseResponse {
  user: Usuarios
}

export class GetUserProfileUseCase {
  constructor(private usersRepository: UsersRepository) {}

  async execute({
    userId,
  }: GetUserProfileUseCaseRequest): Promise<GetUserProfileUseCaseResponse> {
    const user = await this.usersRepository.findById(userId) // já é number

    if (!user) {
      throw new ResourceNotFoundError()
    }

    return {
      user,
    }
  }
}
