import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ConfigurationCoreService } from './common/configuration/configuration.core.service';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const isDevelopment = app.get(ConfigurationCoreService).env === 'development';

  if (isDevelopment) {
    setupSwaggerApi(app);
  }

  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
      enableDebugMessages: isDevelopment,
    }),
  );

  const { port, host } = app.get(ConfigurationHttpService);

  await app.listen(port, host, () => console.log(`Listening on http://${host}:${port}`));
}

function setupSwaggerApi(app: INestApplication) {
  const config = new DocumentBuilder()
    .setTitle('Anthill API')
    .setDescription('The API for interacting with Anthill backend')
    .setVersion('1.0')
    .build();

  const document = SwaggerModule.createDocument(app, config);

  SwaggerModule.setup('api', app, document);
}

bootstrap();
