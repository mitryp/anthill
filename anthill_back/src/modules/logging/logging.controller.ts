import { Controller, Get } from '@nestjs/common';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';
import { loggingPaginateConfig, LoggingService } from './logging.service';
import { ApiTags } from '@nestjs/swagger';
import { LogEntry } from './data/entities/log-entry.entity';
import { PaginateConfigEndpoint } from '../../common/domain/resource.controller.base';

@ApiTags('Logs')
@Controller('logs')
export class LoggingController {
  constructor(private readonly loggingService: LoggingService) {}

  @PaginateConfigEndpoint()
  readPaginateConfig(): PaginateConfig<LogEntry> {
    return loggingPaginateConfig;
  }

  @Get()
  @PaginatedSwaggerDocs(LogEntryReadDto, loggingPaginateConfig)
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<LogEntryReadDto>> {
    return this.loggingService.readAll(query);
  }
}
