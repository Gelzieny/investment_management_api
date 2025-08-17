import { app } from "./app";
import { env } from "./env";
import { swaggerConfig } from "./config/swagger";

const PORT = Number(env.PORT) || 3333

async function bootstrap() {
  await swaggerConfig(app);

  await app.listen({ host: "0.0.0.0", port: PORT });
  console.log(`🚀 HTTP Server Running on http://localhost:${PORT}`);
  console.log(`📖 Swagger Docs: http://localhost:${PORT}/docs`);
}

bootstrap();