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
import { AutomapperModule } from 'automapper-nestjs';
import { classes } from 'automapper-classes';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { APP_FILTER, APP_GUARD } from '@nestjs/core';
import { QueryFailFilter } from './common/filters/query-fail.filter';
import { SessionAuthGuard } from './modules/auth/session-auth.guard';

@Module({
  imports: [
    ConfigurationModule,
    TransactionsModule,
    UsersModule,
    AuthModule,
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
  providers: [
    ConfigurationHttpService,
    AppService,
    {
      provide: APP_FILTER,
      useClass: QueryFailFilter,
    },
    {
      provide: APP_GUARD,
      useClass: SessionAuthGuard,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): any {
    consumer.apply(AppLoggerMiddleware).forRoutes('*');
  }
}
