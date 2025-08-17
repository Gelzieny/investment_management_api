import { hash } from 'bcryptjs'
import { expect, describe, it, beforeEach } from 'vitest'

import { InMemoryUsersRepository } from '@/repositories/in-memory/in-memory-users-repository'
import { GetUserProfileUseCase } from './get-user-profile'
import { ResourceNotFoundError } from '../errors/resource-not-found-error'

let usersRepository: InMemoryUsersRepository
let sut: GetUserProfileUseCase

describe('Get User Profile Use Case', () => {
  beforeEach(() => {
    usersRepository = new InMemoryUsersRepository()
    sut = new GetUserProfileUseCase(usersRepository)
  })

  it('should be able to get user profile', async () => {
    const createdUser = await usersRepository.create({
      nome: 'Gelzieny R. Martins',
      email: 'gelzieny@gmail.com',
      senha: await hash('123456', 6),
    })

    const { user } = await sut.execute({
      userId: createdUser.codigo,

    })

    expect(user.nome).toEqual('Gelzieny R. Martins')
  })

  it('should not be able to get user profile with wrong id', async () => {
    expect(() =>
      sut.execute({
        userId: Number('non-existing-id'), // convertendo para number
      }),
    ).rejects.toBeInstanceOf(ResourceNotFoundError)
  })
})