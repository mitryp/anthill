import {
  Body,
  Controller,
  InternalServerErrorException,
  Post,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { Request, Response } from 'express';
import { LocalAuthGuard } from './local-auth.guard';
import { User } from '../users/data/entities/user.entity';
import { Public } from './public.guard';
import { UserReadDto } from '../users/data/dtos/user.read.dto';
import { ApiTags } from '@nestjs/swagger';
import { LoginDto } from './data/dtos/login.dto';
import { SessionPayloadDto } from './data/dtos/session.payload.dto';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('login')
  async login(@Body() _loginDto: LoginDto, @Req() req: Request): Promise<object> {
    return await this.authService.login(req.user as User);
  }

  @Post('restore')
  async restoreSession(@Req() req: Request): Promise<UserReadDto> {
    return this.authService.restoreUser(req.user as SessionPayloadDto);
  }

  @Post('logoff')
  async logoff(@Req() req: Request, @Res() res: Response) {
    req.session.destroy((err) => {
      if (err) {
        throw new InternalServerErrorException(null, 'Something went wrong when logging off');
      }

      res.sendStatus(200);
    });
  }
}
