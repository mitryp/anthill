import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { DataSourceOptions } from 'typeorm';

@Injectable()
export class ConfigurationDatabaseService {
  private static readonly section = 'database';

  constructor(private readonly config: ConfigService) {}

  get port() {
    return this.config.getOrThrow<number>(`${ConfigurationDatabaseService.section}.port`);
  }

  get host() {
    return this.config.getOrThrow<string>(`${ConfigurationDatabaseService.section}.host`);
  }

  get username() {
    const path = `${ConfigurationDatabaseService.section}.username`;

    return this.config.getOrThrow<string>(path);
  }

  get password() {
    const path = `${ConfigurationDatabaseService.section}.password`;

    return this.config.getOrThrow<string>(path);
  }

  get database() {
    const path = `${ConfigurationDatabaseService.section}.database`;

    return this.config.getOrThrow<string>(path);
  }
}
