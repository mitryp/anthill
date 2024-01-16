import { Controller, Get } from '@nestjs/common';
import { Paginate, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';
import { LoggingService } from './logging.service';

@Controller('logs')
export class LoggingController {
  constructor(private readonly loggingService: LoggingService) {}

  @Get()
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<LogEntryReadDto>> {
    return this.loggingService.readAll(query);
  }
}
