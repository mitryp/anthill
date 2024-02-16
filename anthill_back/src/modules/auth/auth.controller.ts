import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { Request } from 'express';
import { LocalAuthGuard } from './local-auth.guard';
import { User } from '../users/data/entities/user.entity';
import { Public } from './public.guard';
import { UserReadDto } from '../users/data/dtos/user.read.dto';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';
import { ApiTags } from '@nestjs/swagger';
import { LoginDto } from './data/dtos/login.dto';
import { SessionPayloadDto } from './data/dtos/session.payload.dto';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authConfig: ConfigurationAuthService,
    private readonly authService: AuthService,
  ) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(
    @Body() _loginDto: LoginDto,
    @Req() req: Request,
  ): Promise<object> {
    return await this.authService.login(req.user as User);
  }

  @Post('restore')
  async restoreSession(@Req() req: Request): Promise<UserReadDto> {
    return this.authService.restoreUser(req.user as SessionPayloadDto);
  }
}
