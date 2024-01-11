import { Injectable } from '@nestjs/common';
import { ConfigurationAuthService } from '../configuration/configuration.auth.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class EncryptionService {
  constructor(private readonly authConfig: ConfigurationAuthService) {}

  async hashPassword(password: string): Promise<string> {
    const saltRounds = this.authConfig.saltRounds;

    return bcrypt.hash(password, saltRounds);
  }
}
