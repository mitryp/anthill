import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import {
  commonConfigFactory,
  envAuthConfigFactory,
  envDatabaseConfigFactory,
  envHttpConfigFactory,
  environmentConfigFactory,
} from './factories';
import { ConfigurationHttpService } from './configuration.http.service';
import { ConfigurationDatabaseService } from './configuration.database.service';
import { ConfigurationCoreService } from './configuration.core.service';
import { ConfigurationAuthService } from './configuration.auth.service';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [
        envHttpConfigFactory,
        envDatabaseConfigFactory,
        envAuthConfigFactory,
        environmentConfigFactory,
        commonConfigFactory,
      ],
      isGlobal: true,
    }),
  ],
  providers: [
    ConfigurationHttpService,
    ConfigurationDatabaseService,
    ConfigurationCoreService,
    ConfigurationAuthService,
  ],
  exports: [
    ConfigurationHttpService,
    ConfigurationDatabaseService,
    ConfigurationCoreService,
    ConfigurationAuthService,
  ],
})
export class ConfigurationModule {}
