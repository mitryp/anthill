import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class ConfigurationHttpService {
  private static readonly section = 'http';

  constructor(private readonly config: ConfigService) {}

  get port() {
    return this.config.getOrThrow<string>(`${ConfigurationHttpService.section}.port`);
  }

  get host() {
    return this.config.getOrThrow<string>(`${ConfigurationHttpService.section}.host`);
  }

  get staticPath() {
    const path = `${ConfigurationHttpService.section}.staticPath`;

    return this.config.getOrThrow<string>(path);
  }
}
