import { compare } from 'bcryptjs'
import { expect, describe, it } from 'vitest'
import { RegisterUserUseCase } from './register_user_case'
import { InMemoryUsersRepository } from '@/repositories/in-memory/in-memory-users-repository'
import { UserAlreadyExistsError } from '../errors/user-already-exists-error'

describe('Register Use Case', () => {
  it('should hash user password upon registration', async () => {

    const usersRepository = new InMemoryUsersRepository()
    const registerUseCase = new RegisterUserUseCase(usersRepository)


    const user = await registerUseCase.execute({
      nome: 'Gelzieny R. Martins',
      email: 'gelzieny@example.com',
      senha: '123456',
    })

    const isPasswordCorrectlyHashed = await compare(
      '123456',
      user.senha, // agora pega a senha hashada
    )
    expect(user.codigo).toEqual(expect.any(Number))
    expect(isPasswordCorrectlyHashed).toBe(true)
  })

  it('should hash user password upon registration', async () => {
    const usersRepository = new InMemoryUsersRepository()
    const registerUseCase = new RegisterUserUseCase(usersRepository)

    const user = await registerUseCase.execute({
      nome: 'Gelzieny R. Martins',
      email: 'gelzieny@example.com',
      senha: '123456',
    })

    const isPasswordCorrectlyHashed = await compare(
      '123456',
      user.senha,
    )

    expect(isPasswordCorrectlyHashed).toBe(true)
  })

  it('should not be able to register with same email twice', async () => {
    const usersRepository = new InMemoryUsersRepository()
    const registerUserUseCase = new RegisterUserUseCase(usersRepository)

    const email = 'gelzieny@example.com'

    await registerUserUseCase.execute({
      nome: 'Gelzieny R. Martins',
      email,
      senha: '123456',
    })

    expect(() =>
      registerUserUseCase.execute({
        nome: 'Gelzieny R. Martins',
        email,
        senha: '123456',
      }),
    ).rejects.toBeInstanceOf(UserAlreadyExistsError)
  })
})