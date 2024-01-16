import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './data/entities/user.entity';
import { UsersController } from './users.controller';
import { UserMapper } from './data/user.mapper';
import { UsersService } from './users.service';
import { AuthModule } from '../auth/auth.module';
import { ConfigurationModule } from '../../common/configuration/configuration.module';
import { LoggingModule } from '../logging/logging.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([User]),
    ConfigurationModule,
    forwardRef(() => AuthModule),
    LoggingModule,
  ],
  controllers: [UsersController],
  providers: [UserMapper, UsersService],
  exports: [UsersService],
})
export class UsersModule {}
