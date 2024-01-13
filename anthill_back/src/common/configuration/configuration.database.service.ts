import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { ConfigurationBaseService } from './configuration.base.service';

@Injectable()
export class ConfigurationDatabaseService extends ConfigurationBaseService {
  constructor(config: ConfigService) {
    super(config);
  }

  get configSection(): string {
    return 'database';
  }

  get port() {
    return this.getOrThrow<number>('port');
  }

  get host() {
    return this.getOrThrow<string>('host');
  }

  get username() {
    return this.getOrThrow<string>('username');
  }

  get password() {
    return this.getOrThrow<string>('password');
  }

  get database() {
    return this.getOrThrow<string>('database');
  }
}
