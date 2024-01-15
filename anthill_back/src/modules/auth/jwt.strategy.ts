import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';
import { JwtPayloadDto } from './data/dtos/jwt.payload.dto';
import { Request } from 'express';
import { UsersService } from '../users/users.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    authConfig: ConfigurationAuthService,
    private readonly usersService: UsersService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        (req: Request): string | null => {
          if (!req || !req.cookies) return null;
          return req.cookies['accessToken'] as string;
        },
      ]),
      ignoreExpiration: false,
      secretOrKey: authConfig.jwtSecret,
    });
  }

  async validate(payload: JwtPayloadDto): Promise<JwtPayloadDto> {
    const user = await this.usersService.readOne(payload.id);

    if (!user || user.deleteDate !== undefined) {
      throw new UnauthorizedException(null, { description: 'User is not defined' });
    }

    return payload;
  }
}
