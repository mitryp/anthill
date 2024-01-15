import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-local';
import { AuthenticationService } from './authentication.service';
import { UserReadDto } from '../users/data/dtos/user.read.dto';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly authService: AuthenticationService) {
    super({ usernameField: 'email' });
  }

  async validate(email: string, password: string): Promise<UserReadDto> {
    const user = await this.authService.validateUser(email, password);

    if (user === null) {
      throw new UnauthorizedException();
    }

    return user;
  }
}