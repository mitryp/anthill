import { Injectable } from '@nestjs/common';
import { InjectMapper } from 'automapper-nestjs';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { Repository } from 'typeorm';
import { Mapper } from 'automapper-core';
import { TransactionCreateDtoWithUser } from './data/dtos/transaction.create.dto';
import { TransactionUpdateDto } from './data/dtos/transaction.update.dto';
import { ModifiableResourceServiceBase } from '../../common/domain/resource.service.base';
import {
  FilterOperator,
  FilterSuffix,
  paginate,
  PaginateConfig,
  PaginateQuery,
} from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';

@Injectable()
export class TransactionsService extends ModifiableResourceServiceBase<
  Transaction,
  TransactionReadDto,
  TransactionCreateDtoWithUser,
  TransactionUpdateDto
> {
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
  // todo filters
};
