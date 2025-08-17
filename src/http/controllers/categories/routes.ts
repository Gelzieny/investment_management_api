import type { FastifyInstance } from "fastify"

import { registerController } from "./register"
import { listCategoriesController } from "./list"


export async function categoriesRoutes(app: FastifyInstance) {
  app.post('/categories', registerController)
  app.get('/categories', listCategoriesController)
}