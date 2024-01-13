import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class ConfigurationCoreService {
  constructor(private readonly config: ConfigService) {}

  get env() {
    return this.config.get<string>('NODE_ENV') || 'development';
  }

  get isDebug() {
    return this.env !== 'production';
  }
}
