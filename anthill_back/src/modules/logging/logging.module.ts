import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LogEntryEntity } from './data/entities/log-entry.entity';
import { LoggingMapper } from './data/logging.mapper';
import { LoggingService } from './logging.service';

@Module({
  imports: [TypeOrmModule.forFeature([LogEntryEntity])],
  providers: [LoggingMapper, LoggingService],
  exports: [LoggingService],
})
export class LoggingModule {}
