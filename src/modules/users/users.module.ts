import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './data/entities/user.entity';
import { UsersController } from './users.controller';
import { UserMapper } from './data/user.mapper';
import { UsersService } from './users.service';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [TypeOrmModule.forFeature([User]), AuthModule],
  controllers: [UsersController],
  providers: [UserMapper, UsersService],
})
export class UsersModule {}
