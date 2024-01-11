import { ConfigService } from '@nestjs/config';

export abstract class ConfigurationBaseService {
  protected constructor(protected readonly config: ConfigService) {
  }

  abstract get configSection(): string;

  get<T>(name: string): T {
    return this.config.get<T>(`${this.configSection}.${name}`);
  }

  getOrThrow<T>(name: string): T {
    return this.config.getOrThrow<T>(`${this.configSection}.${name}`);
  }
}