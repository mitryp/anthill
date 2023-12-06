import { Injectable } from '@nestjs/common';
import { InjectMapper } from '@automapper/nestjs';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { Repository } from 'typeorm';
import { Mapper } from '@automapper/core';
import { TransactionCreateDto } from './data/dtos/transaction.create.dto';

@Injectable()
export class TransactionsService {
  constructor(
    @InjectRepository(Transaction) private readonly repository: Repository<Transaction>,
    @InjectMapper() private readonly mapper: Mapper,
  ) {}

  async readAll(): Promise<TransactionReadDto[]> {
    const transactions = await this.repository.find();

    return transactions.map((t) => this.mapper.map(t, Transaction, TransactionReadDto));
  }

  async create(dto: TransactionCreateDto): Promise<TransactionReadDto> {
    return this.repository.save(dto);
  }

  async readOne(id: number): Promise<TransactionReadDto | null> {
    return this.repository.findOne({ where: { id } });
  }
}
