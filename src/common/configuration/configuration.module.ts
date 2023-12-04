import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import {
  commonConfigFactory,
  envDatabaseConfigFactory,
  envHttpConfigFactory,
  environmentConfigFactory,
} from './factories';
import { ConfigurationHttpService } from './configuration.http.service';
import { ConfigurationDatabaseService } from './configuration.database.service';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [
        envHttpConfigFactory,
        envDatabaseConfigFactory,
        environmentConfigFactory,
        commonConfigFactory,
      ],
      isGlobal: true,
    }),
  ],
  providers: [ConfigurationHttpService, ConfigurationDatabaseService],
  exports: [ConfigurationHttpService, ConfigurationDatabaseService],
})
export class ConfigurationModule {}
