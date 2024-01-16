import { Injectable } from '@nestjs/common';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { LogEntryCreateDto } from './data/dtos/log-entry.create.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { LogEntryEntity } from './data/entities/log-entry.entity';
import { Repository } from 'typeorm';
import { paginate, PaginateConfig, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { LogEntryReadDto } from './data/dtos/log-entry.read.dto';

@Injectable()
export class LoggingService {
  constructor(
    @InjectRepository(LogEntryEntity)
    private readonly logEntryRepository: Repository<LogEntryEntity>,
    @InjectMapper() private readonly mapper: Mapper,
  ) {}

  async log(entryDto: LogEntryCreateDto<any>): Promise<void> {
    const entity = this.mapper.map(entryDto, LogEntryCreateDto, LogEntryEntity);

    console.log(entity);

    await this.logEntryRepository.save(entity);
  }

  async readAll(query: PaginateQuery): Promise<ReadManyDto<LogEntryReadDto>> {
    const paginated = await paginate(query, this.logEntryRepository, loggingPaginateConfig);

    return {
      meta: paginated.meta,
      data: paginated.data.map((value) => this.mapper.map(value, LogEntryEntity, LogEntryReadDto)),
    };
  }
}

const loggingPaginateConfig: PaginateConfig<LogEntryEntity> = {
  sortableColumns: ['createDate'],
  defaultSortBy: [['createDate', 'DESC']],
  relations: { user: true },
};
