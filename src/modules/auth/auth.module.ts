import { Module } from '@nestjs/common';
import { AuthenticationService } from './authentication.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../users/data/entities/user.entity';
import { ConfigurationModule } from '../../common/configuration/configuration.module';

@Module({
  imports: [TypeOrmModule.forFeature([User]), ConfigurationModule],
  providers: [AuthenticationService],
  exports: [AuthenticationService],
})
export class AuthModule {}
