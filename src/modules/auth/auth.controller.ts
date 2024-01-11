import { Controller, Post, Req, Res, UseGuards } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { Request, Response } from 'express';
import { LocalAuthGuard } from './local-auth.guard';
import { User } from '../users/data/entities/user.entity';
import { LoginSuccessDto } from './data/dtos/login-success.dto';
import { Public } from './public.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthenticationService) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Req() req: Request): Promise<LoginSuccessDto> {
    return this.authService.login(req.user as User);
  }
}
