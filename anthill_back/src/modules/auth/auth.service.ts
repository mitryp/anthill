import { Injectable, UnauthorizedException } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { User } from '../users/data/entities/user.entity';
import { LoginSuccessDto } from './data/dtos/login-success.dto';
import { UsersService } from '../users/users.service';
import { SessionPayloadDto } from './data/dtos/session.payload.dto';
import { UserReadDto } from '../users/data/dtos/user.read.dto';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    @InjectMapper() private readonly mapper: Mapper,
  ) {}

  async getSessionPayload(userId: number): Promise<SessionPayloadDto> {
    const user = await this.usersService.readOne(userId);

    return this.mapper.map(user, UserReadDto, SessionPayloadDto);
  }

  async login(userPayload: SessionPayloadDto | null): Promise<LoginSuccessDto> {
    if (!userPayload) {
      throw new UnauthorizedException();
    }

    const userReadDto = await this.usersService.readOne(userPayload.id);

    const payload: SessionPayloadDto = {
      id: userReadDto.id,
      role: userReadDto.role,
    };

    console.log('logged in with a payload:', payload);

    return {
      user: userReadDto,
      accessToken: undefined,
    };
  }

  async restoreUser(sessionPayload: SessionPayloadDto): Promise<UserReadDto> {
    return this.usersService.readOne(sessionPayload.id);
  }

  async validateUser(email: string, password: string): Promise<SessionPayloadDto> {
    const user = await this.usersService.readByEmail(email);

    if (user && (await bcrypt.compare(password, user.passwordHash))) {
      return this.mapper.map(user, User, SessionPayloadDto);
    }

    return null;
  }
}
