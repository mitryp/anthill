import { Controller, Get, NotFoundException, Param } from '@nestjs/common';
import { Paginate, PaginateConfig, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';
import { loggingPaginateConfig, LoggingService } from './logging.service';
import { ApiTags } from '@nestjs/swagger';
import { LogEntry } from './data/entities/log-entry.entity';

@ApiTags('Logs')
@Controller('logs')
export class LoggingController {
  constructor(private readonly loggingService: LoggingService) {}

  @Get('paginate_config')
  readPaginateConfig(): PaginateConfig<LogEntry> {
    return loggingPaginateConfig;
  }

  @Get()
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<LogEntryReadDto>> {
    return this.loggingService.readAll(query);
  }
}
