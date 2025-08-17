import type { FastifyInstance } from "fastify";
import { registerController } from "./register";


export async function appRoutes(app: FastifyInstance) {
  app.post('/users', registerController)
}