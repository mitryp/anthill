import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { commonConfigFactory, environmentConfigFactory } from './factories';
import { ConfigurationHttpService } from './configuration.http.service';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [environmentConfigFactory, commonConfigFactory],
      isGlobal: true,
    }),
  ],
  providers: [ConfigurationHttpService],
  exports: [ConfigurationHttpService],
})
export class ConfigurationModule {}
