import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import {
  commonConfigFactory,
  environmentConfigFactory,
  yamlEnvAdapterConfigFactory,
} from './factories';
import { ConfigurationHttpService } from './configuration.http.service';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [environmentConfigFactory, yamlEnvAdapterConfigFactory, commonConfigFactory],
      isGlobal: true,
    }),
  ],
  providers: [ConfigurationHttpService],
  exports: [ConfigurationHttpService],
})
export class ConfigurationModule {}
