import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigurationModule } from './common/configuration/configuration.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';
import { ServeStaticModule } from '@nestjs/serve-static';

@Module({
  imports: [
    ConfigurationModule,
    ServeStaticModule.forRootAsync({
      imports: [ConfigurationModule],
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
export class AppModule {}
