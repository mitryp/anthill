import { ForbiddenException, Injectable, NotFoundException } from '@nestjs/common';
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
import { UserRole } from '../users/data/entities/user.entity';
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
    const existing = await this.repository.findOne({ where: { id } });

    if (!existing || existing.deleteDate !== null) {
      throw new NotFoundException();
    }

    if (
      currentUser &&
      currentUser.id != existing.user.id &&
      currentUser.role === UserRole.volunteer
    ) {
      throw new ForbiddenException(null, 'Current user does not own the accessed resource');
    }

    const entity = this.mapper.map(dto, this.updateDtoType, this.entityType);
    const updated = await this.repository.save({ id, ...entity });

    return this.mapOne(Object.assign(updated, existing));
  }

  async delete(id: number, currentUser?: SessionPayloadDto): Promise<boolean> {
    const entity = await this.repository.findOne({
      where: { id },
      withDeleted: false,
      relations: this.paginateConfig.relations,
    });

    if (entity === null) {
      throw new NotFoundException();
    }

    if (
      currentUser &&
      currentUser.id != entity.user.id &&
      currentUser.role === UserRole.volunteer
    ) {
      throw new ForbiddenException(null, 'Current user does not own the accessed resource');
    }

    await this.repository.softDelete({ id });

    return true;
  }

  async getSuggestions(): Promise<SuggestionsDto> {
    const suggestions = await this.repository
      .createQueryBuilder('transactions')
      .select('transactions."sourceOrPurpose"')
      .distinct(true)
      .getRawMany<{sourceOrPurpose: string}>();

    return {
      suggestions: suggestions.map(e => e.sourceOrPurpose),
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
