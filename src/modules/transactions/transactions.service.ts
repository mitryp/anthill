import { Injectable } from '@nestjs/common';
import { InjectMapper } from 'automapper-nestjs';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { Repository } from 'typeorm';
import { Mapper } from 'automapper-core';
import { TransactionCreateDto } from './data/dtos/transaction.create.dto';
import { TransactionUpdateDto } from './data/dtos/transaction.update.dto';
import { ModifiableResourceServiceBase } from '../../common/domain/resource.service.base';
import { FilterOperator, PaginateConfig } from 'nestjs-paginate';

@Injectable()
export class TransactionsService extends ModifiableResourceServiceBase<
  Transaction,
  TransactionReadDto,
  TransactionCreateDto,
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
      TransactionCreateDto,
      TransactionUpdateDto,
      transactionsPaginateConfig,
    );
  }
}

export const transactionsPaginateConfig: PaginateConfig<Transaction> = {
  sortableColumns: ['createDate', 'amount', 'sourceOrPurpose'],
  defaultSortBy: [['createDate', 'DESC']],
  searchableColumns: ['sourceOrPurpose', 'note'],
  // todo filters
};
