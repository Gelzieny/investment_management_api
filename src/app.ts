import fastify from "fastify";
import { appRoutes } from "./http/controllers/users/routes";
import { categoriesRoutes } from "./http/controllers/categories/routes";

export const app = fastify();

app.register(appRoutes)
app.register(categoriesRoutes)
