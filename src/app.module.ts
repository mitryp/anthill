import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigurationModule } from './common/configuration/configuration.module';
import { ConfigurationHttpService } from './common/configuration/configuration.http.service';

@Module({
  imports: [ConfigurationModule],
  controllers: [AppController],
  providers: [AppService, ConfigurationHttpService],
})
export class AppModule {}
