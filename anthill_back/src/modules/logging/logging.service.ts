import { Injectable } from '@nestjs/common';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { LogEntryCreateDto } from './data/dtos/log-entry.create.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { LogEntryEntity } from './data/entities/log-entry.entity';
import { Repository } from 'typeorm';
import { PaginateConfig } from 'nestjs-paginate';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';
import { ResourceServiceBase } from '../../common/domain/resource.service.base';

@Injectable()
export class LoggingService extends ResourceServiceBase<LogEntryEntity, LogEntryReadDto> {
  constructor(
    @InjectRepository(LogEntryEntity)
    repository: Repository<LogEntryEntity>,
    @InjectMapper() mapper: Mapper,
  ) {
    super(repository, mapper, LogEntryEntity, LogEntryReadDto, loggingPaginateConfig);
  }

  async log(entryDto: LogEntryCreateDto<any>): Promise<void> {
    const entity = this.mapper.map(entryDto, LogEntryCreateDto, LogEntryEntity);

    await this.repository.save(entity);
  }
}

const loggingPaginateConfig: PaginateConfig<LogEntryEntity> = {
  sortableColumns: ['createDate'],
  defaultSortBy: [['createDate', 'DESC']],
  relations: { user: true },
};
