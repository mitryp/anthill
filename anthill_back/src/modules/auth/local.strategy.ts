import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-local';
import { AuthService } from './auth.service';
import { SessionPayloadDto } from './data/dtos/session.payload.dto';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly authService: AuthService) {
    super({ usernameField: 'email' });
  }

  // noinspection JSUnusedGlobalSymbols
  async validate(email: string, password: string): Promise<SessionPayloadDto> {
    const sessionPayload = await this.authService.validateUser(email, password);

    if (!sessionPayload) {
      throw new UnauthorizedException();
    }

    return sessionPayload;
  }
}
