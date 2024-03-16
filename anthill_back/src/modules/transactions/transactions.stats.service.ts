import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { Between, Repository } from 'typeorm';
import { TransactionStatsDto } from './data/dtos/transaction.stats.dto';

@Injectable()
export class TransactionsStatsService {
  constructor(
    @InjectRepository(Transaction) private readonly transactionRepo: Repository<Transaction>,
  ) {}

  async statsForRange(from: Date, to: Date): Promise<TransactionStatsDto> {
    const transactions = await this.transactionRepo.find({
      where: {
        createDate: Between(from, to),
      },
    });

    const sum = transactions.reduce((acc, next) => acc + next.amount, 0);
    const count = transactions.length;
    const largest = transactions.reduce((acc, next) => Math.max(acc, next.amount), 0);

    return {
      fromDate: from,
      toDate: to,
      sum: sum,
      average: sum / count,
      count: count,
      largestDonation: largest,
    };
  }
}
