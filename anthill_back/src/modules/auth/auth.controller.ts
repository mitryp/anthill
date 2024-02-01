import { Body, Controller, Post, Req, Res, UseGuards } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { Request, Response } from 'express';
import { LocalAuthGuard } from './local-auth.guard';
import { User } from '../users/data/entities/user.entity';
import { Public } from './public.guard';
import { UserReadDto } from '../users/data/dtos/user.read.dto';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';
import { ApiTags } from '@nestjs/swagger';
import { LoginDto } from './data/dtos/login.dto';
import { JwtPayloadDto } from './data/dtos/jwt.payload.dto';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(
    private readonly authConfig: ConfigurationAuthService,
    private readonly authService: AuthenticationService,
  ) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(
    @Body() loginDto: LoginDto,
    @Req() req: Request,
    @Res() res: Response,
  ): Promise<object> {
    const successDto = await this.authService.login(req.user as User);

    res
      .cookie('accessToken', successDto.accessToken, {
        httpOnly: true,
        secure: this.authConfig.useSecureCookies,
        sameSite: 'strict',
        maxAge: this.authConfig.sessionTtl,
      })
      .send();

    return {};
  }

  @Post('restore')
  async restoreSession(@Req() req: Request): Promise<UserReadDto> {
    return this.authService.restoreUser(req.user as JwtPayloadDto);
  }
}
