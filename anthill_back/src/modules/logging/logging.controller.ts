import { Controller, Get, NotFoundException, Param } from '@nestjs/common';
import { Paginate, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';
import { LoggingService } from './logging.service';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Logs')
@Controller('logs')
export class LoggingController {
  constructor(private readonly loggingService: LoggingService) {}

  @Get()
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<LogEntryReadDto>> {
    return this.loggingService.readAll(query);
  }

  @Get(':id')
  async readOne(@Param('id') id: number) {
    const entry = await this.loggingService.readOne(id);

    if (!entry) {
      throw new NotFoundException();
    }

    return entry;
  }
}
