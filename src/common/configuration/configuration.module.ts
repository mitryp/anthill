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
import { ConfigurationCoreService } from './configuration.core.service';

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
  providers: [ConfigurationHttpService, ConfigurationDatabaseService, ConfigurationCoreService],
  exports: [ConfigurationHttpService, ConfigurationDatabaseService, ConfigurationCoreService],
})
export class ConfigurationModule {}
