import { PassportSerializer } from '@nestjs/passport';
import { User } from '../users/data/entities/user.entity';
import { Injectable } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SessionPayloadDto } from './data/dtos/session.payload.dto';

@Injectable()
export class AccountSerializer extends PassportSerializer {
  constructor(private readonly authService: AuthService) {
    super();
  }

  serializeUser(user: User, done: (err: Error, payload: number) => void) {
    done(null, user.id);
  }

  async deserializeUser(
    userId: number,
    done: (err: Error, account: SessionPayloadDto) => void,
  ): Promise<void> {
    try {
      const payload = await this.authService.getSessionPayload(userId);

      done(null, payload);
    } catch (err) {
      return done(err, null);
    }
  }
}
