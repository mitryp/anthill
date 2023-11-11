import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const { port, host, staticPath } = app.get(ConfigurationHttpService);

  console.log(staticPath);

  await app.listen(port, host, () => console.log(`Listening on http://${host}:${port}`));
}

bootstrap();
