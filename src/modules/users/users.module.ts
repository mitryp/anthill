import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './data/entities/user.entity';
import { UsersController } from './users.controller';
import { UserMapper } from './data/user.mapper';
import { UsersService } from './users.service';
import { AuthModule } from '../auth/auth.module';
import { EncryptionService } from '../../common/utils/encryption.service';
import { ConfigurationModule } from '../../common/configuration/configuration.module';

@Module({
  imports: [TypeOrmModule.forFeature([User]), ConfigurationModule],
  controllers: [UsersController],
  providers: [UserMapper, UsersService, EncryptionService],
  exports: [UsersService],
})
export class UsersModule {}
