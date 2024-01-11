import { Module } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../users/data/entities/user.entity';
import { ConfigurationModule } from '../../common/configuration/configuration.module';
import { JwtModule } from '@nestjs/jwt';
import { ConfigurationAuthService } from '../../common/configuration/configuration.auth.service';

@Module({
  imports: [
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
  providers: [AuthenticationService],
  exports: [AuthenticationService],
})
export class AuthModule {}
