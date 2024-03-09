import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ConfigurationCoreService } from './common/configuration/configuration.core.service';
import cookieParser from 'cookie-parser';
import session from 'express-session';
import { TypeormStore } from 'connect-typeorm';
import { ConfigurationAuthService } from './common/configuration/configuration.auth.service';
import passport from 'passport';
import { Repository } from 'typeorm';
import { Session } from './modules/auth/data/entities/session.entity';
import { getRepositoryToken } from '@nestjs/typeorm';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix('api');
  app.use(cookieParser());

  await setupSessions(app);

  const isDevelopment = app.get(ConfigurationCoreService).env === 'development';

  if (isDevelopment) {
    app.enableCors({ origin: true, credentials: true });
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

async function setupSessions(app: INestApplication) {
  const msInSecond = 1000;
  const { sessionTtl, sessionSecret, useSecureCookies } = app.get(ConfigurationAuthService);

  const sessionRepo = app.get<Repository<Session>>(getRepositoryToken(Session));

  app.use(
    session({
      resave: false,
      rolling: false,
      saveUninitialized: false,
      secret: sessionSecret,
      store: new TypeormStore({
        cleanupLimit: 2,
        ttl: sessionTtl / msInSecond,
      }).connect(sessionRepo),
      cookie: {
        secure: useSecureCookies,
        httpOnly: true,
        maxAge: sessionTtl,
        sameSite: 'lax',
      },
    }),
  );

  app.use(passport.initialize());
  app.use(passport.session());
}

function setupSwaggerApi(app: INestApplication) {
  const config = new DocumentBuilder()
    .setTitle('Anthill API')
    .setDescription('The API for interacting with Anthill backend.')
    .setVersion('v1')
    .build();

  const document = SwaggerModule.createDocument(app, config);

  SwaggerModule.setup('api', app, document);
}

bootstrap();
