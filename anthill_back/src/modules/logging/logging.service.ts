import { Injectable } from '@nestjs/common';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { LogEntryCreateDto } from './data/dtos/log-entry.create.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { LogEntry } from './data/entities/log-entry.entity';
import { Repository } from 'typeorm';
import { PaginateConfig } from 'nestjs-paginate';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';
import { ResourceServiceBase } from '../../common/domain/resource.service.base';

@Injectable()
export class LoggingService extends ResourceServiceBase<LogEntry, LogEntryReadDto> {
  constructor(
    @InjectRepository(LogEntry)
    repository: Repository<LogEntry>,
    @InjectMapper() mapper: Mapper,
  ) {
    super(repository, mapper, LogEntry, LogEntryReadDto, loggingPaginateConfig);
  }

  async log(entryDto: LogEntryCreateDto<any>): Promise<void> {
    const entity = this.mapper.map(entryDto, LogEntryCreateDto, LogEntry);

    await this.repository.save(entity);
  }
}

export const loggingPaginateConfig: PaginateConfig<LogEntry> = {
  sortableColumns: ['createDate'],
  defaultSortBy: [['createDate', 'DESC']],
  relations: { user: true },
};
