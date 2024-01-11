import { Injectable, UnauthorizedException } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { User } from '../users/data/entities/user.entity';
import { LoginSuccessDto } from './data/dtos/login-success.dto';
import { JwtService } from '@nestjs/jwt';
import { Mapper } from 'automapper-core';
import { UserReadDto } from '../users/data/dtos/user.read.dto';
import { UsersService } from '../users/users.service';
import { InjectMapper } from 'automapper-nestjs';

@Injectable()
export class AuthenticationService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
    @InjectMapper() private readonly mapper: Mapper,
  ) {}

  async login(user: User | null): Promise<LoginSuccessDto> {
    if (user === null) {
      throw new UnauthorizedException();
    }

    const userReadDto = this.mapper.map(user, User, UserReadDto);

    const payload = {
      id: userReadDto.id,
      email: userReadDto.email,
      role: userReadDto.role,
    };

    return {
      user: userReadDto,
      accessToken: this.jwtService.sign(payload),
    };
  }

  async validateUser(email: string, password: string): Promise<User | null> {
    const user = await this.usersService.readByEmail(email);

    if ((await bcrypt.compare(password, user.passwordHash)) === true) {
      return user;
    }

    return null;
  }
}
