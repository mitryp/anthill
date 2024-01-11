import { Injectable } from '@nestjs/common';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';
import * as bcrypt from 'bcrypt';
import { Repository } from 'typeorm';
import { User } from '../users/data/entities/user.entity';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class AuthenticationService {
  constructor(
    private readonly authConfig: ConfigurationAuthService,
    @InjectRepository(User) private readonly userRepository: Repository<User>
  ) {
  }

  async hashPassword(password: string): Promise<string> {
    const saltRounds = this.authConfig.saltRounds;

    return bcrypt.hash(password, saltRounds);
  }

  async validatePassword(email: string, password: string): Promise<boolean> {
    const user = await this.userRepository.findOne({ where: { email } });

    return bcrypt.compare(password, user.passwordHash);
  }
}
