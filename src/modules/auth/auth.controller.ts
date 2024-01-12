import { Controller, Post, Req, Res, UseGuards } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { Request, Response } from 'express';
import { LocalAuthGuard } from './local-auth.guard';
import { User } from '../users/data/entities/user.entity';
import { Public } from './public.guard';
import { UserReadDto } from '../users/data/dtos/user.read.dto';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authConfig: ConfigurationAuthService,
    private readonly authService: AuthenticationService,
  ) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Req() req: Request, @Res() res: Response): Promise<UserReadDto> {
    const successDto = await this.authService.login(req.user as User);

    res
      .cookie('accessToken', successDto.accessToken, {
        httpOnly: true,
        secure: this.authConfig.useSecureCookies,
        sameSite: 'lax',
        maxAge: this.authConfig.jwtTtl,
      })
      .json(successDto.user);

    return;
  }
}
