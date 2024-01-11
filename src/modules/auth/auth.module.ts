import { Module } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../users/data/entities/user.entity';
import { ConfigurationModule } from '../../common/configuration/configuration.module';
import { JwtModule } from '@nestjs/jwt';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';
import { UsersModule } from '../users/users.module';
import { PassportModule } from '@nestjs/passport';
import { LocalStrategy } from './local.strategy';
import { JwtStrategy } from './jwt.strategy';
import { AuthController } from './auth.controller';
import { JwtAuthGuard } from './jwt-auth.guard';

@Module({
  imports: [
    UsersModule,
    PassportModule,
    TypeOrmModule.forFeature([User]),
    JwtModule.registerAsync({
      global: true,
      imports: [ConfigurationModule],
      inject: [ConfigurationAuthService],
      useFactory: (authConfig: ConfigurationAuthService) => ({
        secret: authConfig.jwtSecret,
        signOptions: {
          expiresIn: authConfig.jwtTtl,
        },
      }),
    }),
    ConfigurationModule,
  ],
  controllers: [AuthController],
  providers: [AuthenticationService, LocalStrategy, JwtStrategy],
  exports: [AuthenticationService],
})
export class AuthModule {}
