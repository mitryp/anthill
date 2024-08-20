import { Injectable } from '@nestjs/common';
import { InjectMapper } from 'automapper-nestjs';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { Repository } from 'typeorm';
import { Mapper } from 'automapper-core';
import { TransactionCreateDtoWithUser } from './data/dtos/transaction.create.dto';
import { TransactionUpdateDto } from './data/dtos/transaction.update.dto';
import {
  ModifiableResourceServiceBase,
  SuggestionsEnabledResourceServiceBase,
} from '../../common/domain/resource.service.base';
import {
  FilterOperator,
  FilterSuffix,
  paginate,
  PaginateConfig,
  PaginateQuery,
} from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { SessionPayloadDto } from '../auth/data/dtos/session.payload.dto';
import { SuggestionsDto } from '../../common/domain/suggestions.dto';

@Injectable()
export class TransactionsService
  extends ModifiableResourceServiceBase<
    Transaction,
    TransactionReadDto,
    TransactionCreateDtoWithUser,
    TransactionUpdateDto
  >
  implements SuggestionsEnabledResourceServiceBase
{
  constructor(
    @InjectRepository(Transaction) protected readonly repository: Repository<Transaction>,
    @InjectMapper() protected readonly mapper: Mapper,
  ) {
    super(
      repository,
      mapper,
      Transaction,
      TransactionReadDto,
      TransactionCreateDtoWithUser,
      TransactionUpdateDto,
      transactionsPaginateConfig,
    );
  }

  override async readAll(query: PaginateQuery): Promise<ReadManyDto<TransactionReadDto>> {
    const queryBuilder = this.repository
      .createQueryBuilder('transactions')
      .withDeleted()
      .leftJoinAndSelect('transactions.user', 'user');

    const paginated = await paginate(query, queryBuilder, this.paginateConfig);

    return this.mapPaginated(paginated);
  }

  async update(
    id: number,
    dto: TransactionUpdateDto,
    currentUser?: SessionPayloadDto,
  ): Promise<TransactionReadDto> {
    const existing = await this.getOwnedOrFail<Transaction>(currentUser?.id, currentUser?.role, {
      where: { id: currentUser?.id },
    });

    const entity = this.mapper.map(dto, this.updateDtoType, this.entityType);
    const updated = await this.repository.save({ id, ...entity });

    return this.mapOne(Object.assign(existing, updated));
  }

  async delete(id: number, currentUser?: SessionPayloadDto): Promise<boolean> {
    await this.getOwnedOrFail<Transaction>(currentUser?.id, currentUser?.role, {
      where: { id },
      withDeleted: false,
      relations: this.paginateConfig.relations,
    });

    await this.repository.softDelete({ id });

    return true;
  }

  async getSuggestions(): Promise<SuggestionsDto> {
    const suggestions = await this.repository
      .createQueryBuilder('transactions')
      .select('transactions."sourceOrPurpose"')
      .distinct(true)
      .getRawMany<{ sourceOrPurpose: string }>();

    return {
      suggestions: suggestions.map((e) => e.sourceOrPurpose),
    };
  }
}

export const transactionsPaginateConfig: PaginateConfig<Transaction> = {
  withDeleted: true,
  sortableColumns: ['createDate', 'amount', 'sourceOrPurpose'],
  defaultSortBy: [['createDate', 'DESC']],
  searchableColumns: ['sourceOrPurpose', 'note'],
  filterableColumns: {
    deleteDate: [FilterOperator.NULL, FilterSuffix.NOT],
    createDate: [FilterOperator.BTW],
  },
};
