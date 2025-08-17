import { FastifyInstance } from "fastify";
import swagger from "@fastify/swagger";
import swaggerUI from "@fastify/swagger-ui";

export async function swaggerConfig(app: FastifyInstance) {
  // Swagger JSON
  await app.register(swagger, {
    swagger: {
      info: {
        title: "Investimento Pessoal API",
        description: "API para gestão de investimentos pessoais",
        version: "1.0.0",
      },
      consumes: ["application/json"],
      produces: ["application/json"],
    },
  });

  // Swagger UI
  await app.register(swaggerUI, {
    routePrefix: "/docs",
    swagger: {
      info: {
        title: "Investimento Pessoal API",
        description: "Documentação interativa da API",
        version: "1.0.0",
      },
    },
    uiConfig: {
      docExpansion: "full",
      deepLinking: false,
    },
    staticCSP: true,
    transformStaticCSP: (header) => header,
  });
}
