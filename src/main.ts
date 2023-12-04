import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { INestApplication } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import {
  ConfigurationDatabaseService
} from './common/configuration/configuration.database.service';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const env = process.env.NODE_ENV;
  if (!env || env === 'development') {
    setupSwaggerApi(app);
  }

  const { port, host, staticPath } = app.get(ConfigurationHttpService);
  console.log(host, port, staticPath);

  const dbConfig = app.get(ConfigurationDatabaseService);
  const { username, password, database} = dbConfig;
  const [dbPort, dbHost] = [dbConfig.port, dbConfig.host];
  console.log(dbPort, dbHost, username, password, database);

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
