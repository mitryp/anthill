import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigurationModule } from './common/configuration/configuration.module';
import { TransactionsModule } from './modules/transactions/transactions.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { ServeStaticModule } from '@nestjs/serve-static';
import { AppLoggerMiddleware } from './common/utils/app_logger_middleware';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigService } from '@nestjs/config';
import { AutomapperModule } from '@automapper/nestjs';
import { classes } from '@automapper/classes';

@Module({
  imports: [
    ConfigurationModule,
    TransactionsModule,
    ServeStaticModule.forRootAsync({
      imports: [
        ConfigurationModule,
        TypeOrmModule.forRootAsync({
          inject: [ConfigService],
          useFactory: (configService: ConfigService) => configService.getOrThrow('database'),
        }),
        AutomapperModule.forRoot({
          strategyInitializer: classes(),
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
