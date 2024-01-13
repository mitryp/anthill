import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { ConfigurationBaseService } from './configuration.base.service';

@Injectable()
export class ConfigurationHttpService extends ConfigurationBaseService {
  constructor(config: ConfigService) {
    super(config);
  }

  get configSection(): string {
    return 'http';
  }

  get port() {
    return this.getOrThrow<number>('port');
  }

  get host() {
    return this.getOrThrow<string>('host');
  }

  get staticPath() {
    return this.getOrThrow<string>('staticPath');
  }
}
