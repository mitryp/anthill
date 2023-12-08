import { Injectable } from '@nestjs/common';
import { InjectMapper } from '@automapper/nestjs';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { Repository } from 'typeorm';
import { Mapper } from '@automapper/core';
import { TransactionCreateDto } from './data/dtos/transaction.create.dto';
import { TransactionUpdateDto } from './data/dtos/transaction.update.dto';
import { ModifiableResourceServiceBase } from '../../common/domain/resource.service.base';

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
    );
  }

  //
  // mapOne(transaction: Transaction): TransactionReadDto {
  //   return this.mapper.map(transaction, Transaction, TransactionReadDto);
  // }
  //
  // async readAll(): Promise<TransactionReadDto[]> {
  //   const transactions = await this.repository.find();
  //
  //   return transactions.map(this.mapOne);
  // }
  //
  // async create(dto: TransactionCreateDto): Promise<TransactionReadDto> {
  //   const transaction = await this.repository.save(dto);
  //
  //   return this.mapOne(transaction);
  // }
  //
  // async readOne(id: number): Promise<TransactionReadDto | undefined> {
  //   const transaction = await this.repository.findOne({ where: { id } });
  //
  //   return this.mapOne(transaction);
  // }
  //
  // async delete(id: number): Promise<boolean> {
  //   const res = await this.repository.softDelete({ id });
  //
  //   return (res.affected || 0) > 0;
  // }
  //
  // async update(id: number, dto: TransactionUpdateDto): Promise<TransactionReadDto | undefined> {
  //   console.log('update', this);
  //   if (!(await this.repository.exist({ where: { id } }))) {
  //     throw new NotFoundException();
  //   }
  //
  //   const transaction = await this.repository.save({ id, ...dto });
  //
  //   return this.mapOne(transaction);
  // }
}
