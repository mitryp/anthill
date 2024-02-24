import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Session } from './data/entities/session.entity';
import { JsonContains, Repository } from 'typeorm';

@Injectable()
export class SessionsService {
  constructor(@InjectRepository(Session) private readonly sessionRepository: Repository<Session>) {}

  async logOffUser(userId: number): Promise<void> {
    await this.sessionRepository.softDelete({
      json: JsonContains({
        passport: { user: userId },
      }),
    });
  }
}
