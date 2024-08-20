import {
  ModifiableResourceServiceBase,
  SuggestionsEnabledResourceServiceBase,
} from '../../common/domain/resource.service.base';
import { Received } from './data/entities/received.entity';
import { ReceivedReadDto } from './data/dtos/received.read.dto';
import { ReceivedCreateDtoWithUser } from './data/dtos/received.create.dto';
import { ReceivedUpdateDto } from './data/dtos/received.update.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { FilterOperator, FilterSuffix, PaginateConfig } from 'nestjs-paginate';
import { SuggestionsDto } from '../../common/domain/suggestions.dto';
import { Injectable } from '@nestjs/common';
import { SessionPayloadDto } from '../auth/data/dtos/session.payload.dto';

@Injectable()
export class ReceivedHumanitarianService
  extends ModifiableResourceServiceBase<
    Received,
    ReceivedReadDto,
    ReceivedCreateDtoWithUser,
    ReceivedUpdateDto
  >
  implements SuggestionsEnabledResourceServiceBase
{
  constructor(
    @InjectRepository(Received) protected readonly repository: Repository<Received>,
    @InjectMapper() protected readonly mapper: Mapper,
  ) {
    super(
      repository,
      mapper,
      Received,
      ReceivedReadDto,
      ReceivedCreateDtoWithUser,
      ReceivedUpdateDto,
      receivedPaginateConfig,
    );
  }

  async update(
    id: number,
    dto: ReceivedUpdateDto,
    currentUser?: SessionPayloadDto,
  ): Promise<ReceivedReadDto> {
    const existing = await this.getOwnedOrFail<Received>(currentUser?.id, currentUser?.role, {
      where: { id: currentUser?.id },
    });

    const entity = this.mapper.map(dto, ReceivedUpdateDto, Received);
    const updated = await this.repository.save({ id, ...entity });

    return this.mapOne(Object.assign(existing, updated));
  }

  async delete(id: number, currentUser?: SessionPayloadDto): Promise<boolean> {
    await this.getOwnedOrFail<Received>(currentUser?.id, currentUser?.role, {
      where: { id },
      withDeleted: false,
      relations: this.paginateConfig.relations,
    });

    await this.repository.softDelete({ id });

    return true;
  }

  async getSuggestions(): Promise<SuggestionsDto> {
    const suggestions = await this.repository
      .createQueryBuilder('received')
      .select('received."source"')
      .distinct(true)
      .getRawMany<{ source: string }>();

    return {
      suggestions: suggestions.map((e) => e.source),
    };
  }
}

export const receivedPaginateConfig: PaginateConfig<Received> = {
  withDeleted: true,
  sortableColumns: ['createDate', 'quantity', 'source'],
  defaultSortBy: [['createDate', 'DESC']],
  searchableColumns: ['source', 'note'],
  filterableColumns: {
    deleteDate: [FilterOperator.NULL, FilterSuffix.NOT],
    createDate: [FilterOperator.BTW],
    source: [FilterOperator.EQ],
  },
};
