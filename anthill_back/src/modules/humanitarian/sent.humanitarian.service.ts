import { ModifiableResourceServiceBase } from '../../common/domain/resource.service.base';
import { Sent } from './data/entities/sent.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { SuggestionsDto } from '../../common/domain/suggestions.dto';
import { SentReadDto } from './data/dtos/sent.read.dto';
import { SentCreateDtoWithUser } from './data/dtos/sent.create.dto';
import { SentUpdateDto } from './data/dtos/sent.update.dto';
import { FilterOperator, FilterSuffix, PaginateConfig } from 'nestjs-paginate';
import { SessionPayloadDto } from '../auth/data/dtos/session.payload.dto';

@Injectable()
export class SentHumanitarianService extends ModifiableResourceServiceBase<
  Sent,
  SentReadDto,
  SentCreateDtoWithUser,
  SentUpdateDto
> {
  constructor(
    @InjectRepository(Sent) protected readonly repository: Repository<Sent>,
    @InjectMapper() protected readonly mapper: Mapper,
  ) {
    super(
      repository,
      mapper,
      Sent,
      SentReadDto,
      SentCreateDtoWithUser,
      SentUpdateDto,
      sentPaginateConfig,
    );
  }

  async update(
    id: number,
    dto: SentUpdateDto,
    currentUser?: SessionPayloadDto,
  ): Promise<SentReadDto> {
    const existing = await this.getOwnedOrFail<Sent>(currentUser?.id, currentUser?.role, {
      where: { id: currentUser?.id },
    });

    const entity = this.mapper.map(dto, SentUpdateDto, Sent);
    const updated = await this.repository.save({ id, ...entity });

    return this.mapOne(Object.assign(existing, updated));
  }

  async delete(id: number, currentUser?: SessionPayloadDto): Promise<boolean> {
    await this.getOwnedOrFail<Sent>(currentUser?.id, currentUser?.role, {
      where: { id },
      withDeleted: false,
      relations: this.paginateConfig.relations,
    });

    await this.repository.softDelete({ id });

    return true;
  }

  async getPurposeSuggestions(): Promise<SuggestionsDto> {
    const suggestions = await this.repository
      .createQueryBuilder('sent')
      .select('sent."purpose"')
      .distinct(true)
      .getRawMany<{ purpose: string }>();

    return {
      suggestions: suggestions.map((e) => e.purpose),
    };
  }

  async getShipmentMethodSuggestions(): Promise<SuggestionsDto> {
    const suggestions = await this.repository
      .createQueryBuilder('sent')
      .select('sent."shipmentMethod"')
      .distinct(true)
      .getRawMany<{ shipmentMethod: string }>();

    return {
      suggestions: suggestions.map((e) => e.shipmentMethod),
    };
  }
}

export const sentPaginateConfig: PaginateConfig<Sent> = {
  withDeleted: true,
  sortableColumns: ['createDate', 'quantity', 'purpose', 'shipmentMethod', 'reportProvided'],
  defaultSortBy: [['createDate', 'DESC']],
  searchableColumns: ['purpose', 'note', 'shipmentMethod'],
  filterableColumns: {
    deleteDate: [FilterOperator.NULL, FilterSuffix.NOT],
    createDate: [FilterOperator.BTW],
    reportProvided: [FilterOperator.EQ],
    purpose: [FilterOperator.EQ],
    shipmentMethod: [FilterOperator.EQ],
  },
};
