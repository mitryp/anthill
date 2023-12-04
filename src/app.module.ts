import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigurationModule } from './common/configuration/configuration.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { ServeStaticModule } from '@nestjs/serve-static';
import { AppLoggerMiddleware } from './utils/app_logger_middleware';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigService } from '@nestjs/config';

@Module({
  imports: [
    ConfigurationModule,
    ServeStaticModule.forRootAsync({
      imports: [
        ConfigurationModule,
        TypeOrmModule.forRootAsync({
          inject: [ConfigService],
          useFactory: (configService: ConfigService) => configService.getOrThrow('database'),
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
