import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { ConfigurationBaseService } from './configuration.base.service';
import ms from 'ms';

@Injectable()
export class ConfigurationAuthService extends ConfigurationBaseService {
  constructor(config: ConfigService) {
    super(config);
  }

  get configSection(): string {
    return 'auth';
  }

  get saltRounds() {
    return Number(this.get<number>('saltRounds') || 10);
  }

  get jwtSecret() {
    return this.getOrThrow<string>('jwtSecret');
  }

  get jwtTtl() {
    return ms(this.getOrThrow<string>('jwtTtl'));
  }

  get useSecureCookies() {
    return (this.get<number>('secureCookies') || 1) == 1;
  }
}
