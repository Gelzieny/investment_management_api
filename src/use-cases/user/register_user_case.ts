import { hash } from 'bcryptjs'
import { UsersRepository } from '@/repositories/users-repository'
import { UserAlreadyExistsError } from '../errors/user-already-exists-error'

interface RegisterUserRequest {
  nome: string
  email: string
  senha: string
}

export class RegisterUserUseCase {
  constructor(private userRepository: UsersRepository) {}

  async execute({ nome, email, senha }: RegisterUserRequest) {
    const userAlreadyExists = await this.userRepository.findByEmail(email)

    if (userAlreadyExists) {
      throw new UserAlreadyExistsError()
    }

    const hashedPassword = await hash(senha, 6)

    const user = await this.userRepository.create({
      nome,
      email,
      senha: hashedPassword,
    })

    return user
  }
}
