import { Injectable, UnauthorizedException } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { User } from '../users/data/entities/user.entity';
import { LoginSuccessDto } from './data/dtos/login-success.dto';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import { JwtPayloadDto } from './data/dtos/jwt.payload.dto';
import { UserReadDto } from '../users/data/dtos/user.read.dto';

@Injectable()
export class AuthenticationService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async login(userPayload: JwtPayloadDto | null): Promise<LoginSuccessDto> {
    if (!userPayload) {
      throw new UnauthorizedException();
    }

    const userReadDto = await this.usersService.readOne(userPayload.id);

    const payload: JwtPayloadDto = {
      id: userReadDto.id,
      role: userReadDto.role,
    };

    return {
      user: userReadDto,
      accessToken: this.jwtService.sign(payload),
    };
  }

  async restoreUser(jwtPayload: JwtPayloadDto): Promise<UserReadDto> {
    return this.usersService.readOne(jwtPayload.id);
  }

  async validateUser(email: string, password: string): Promise<User | null> {
    const user = await this.usersService.readByEmail(email);

    if ((await bcrypt.compare(password, user.passwordHash)) === true) {
      return user;
    }

    return null;
  }
}
