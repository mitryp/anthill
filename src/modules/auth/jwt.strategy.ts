import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';
import { JwtPayloadDto } from './data/dtos/jwt.payload.dto';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(authConfig: ConfigurationAuthService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: authConfig.jwtSecret,
    });
  }

  async validate(payload: JwtPayloadDto): Promise<JwtPayloadDto> {
    return payload;
  }
}
