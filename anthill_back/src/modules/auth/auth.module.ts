import { forwardRef, Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../users/data/entities/user.entity';
import { ConfigurationModule } from '../../common/configuration/configuration.module';
import { UsersModule } from '../users/users.module';
import { LocalStrategy } from './local.strategy';
import { AuthController } from './auth.controller';
import { EncryptionService } from '../../common/utils/encryption.service';
import { Session } from './data/entities/session.entity';
import { AuthMapper } from './data/auth.mapper';
import { AccountSerializer } from './account.serializer';
import { PassportModule } from '@nestjs/passport';
import { SessionsService } from './sessions.service';

@Module({
  imports: [
    forwardRef(() => UsersModule),
    PassportModule.register({ session: true }),
    TypeOrmModule.forFeature([User, Session]),
    ConfigurationModule,
  ],
  controllers: [AuthController],
  providers: [AuthService, LocalStrategy, EncryptionService, AuthMapper, AccountSerializer, SessionsService],
  exports: [AuthService, EncryptionService, SessionsService],
})
export class AuthModule {}
