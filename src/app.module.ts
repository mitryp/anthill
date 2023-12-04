import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigurationModule } from './common/configuration/configuration.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { ServeStaticModule } from '@nestjs/serve-static';
import { AppLoggerMiddleware } from './utils/app_logger_middleware';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigurationDatabaseService } from './common/configuration/configuration.database.service';

@Module({
  imports: [
    ConfigurationModule,
    ServeStaticModule.forRootAsync({
      imports: [
        ConfigurationModule,
        TypeOrmModule.forRootAsync({
          imports: [ConfigurationModule],
          inject: [ConfigurationDatabaseService],
          useFactory: (dbConfig: ConfigurationDatabaseService) => ({
            type: 'postgres',
            database: dbConfig.database,
            host: dbConfig.host,
            port: dbConfig.port,
            username: dbConfig.username,
            password: dbConfig.password,
            entities: [],
            logging: true,
          }),
        }),
      ],
      inject: [ConfigurationHttpService],
      useFactory: (httpConfig: ConfigurationHttpService) => [
        {
          rootPath: httpConfig.staticPath,
        },
      ],
    }),
  ],
  controllers: [AppController],
  providers: [AppService, ConfigurationHttpService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): any {
    consumer.apply(AppLoggerMiddleware).forRoutes('*');
  }
}
