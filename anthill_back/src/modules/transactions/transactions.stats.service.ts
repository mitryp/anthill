import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { Between, Repository } from 'typeorm';
import { TransactionStatsDto } from './data/dtos/transaction.stats.dto';
import { groupBy } from '../../common/utils/group-by';

@Injectable()
export class TransactionsStatsService {
  constructor(
    @InjectRepository(Transaction) private readonly transactionRepo: Repository<Transaction>,
  ) {}

  async statsForRange(from: Date, to: Date): Promise<TransactionStatsDto> {
    // transactions without users
    const transactions = await this.transactionRepo.find({
      where: {
        createDate: Between(from, to),
      },
      loadEagerRelations: false,
    });

    const incomes: Transaction[] = [];
    const expenses: Transaction[] = [];

    for (const transaction of transactions) {
      (transaction.isIncome ? incomes : expenses).push(transaction);
    }

    const incomesSum = TransactionsStatsService.sum(incomes);
    const expensesSum = TransactionsStatsService.sum(expenses);
    const incomesCount = incomes.length;
    const largestIncome = incomes.reduce((acc, cur) => Math.max(acc, cur.amount), 0);

    const grouped = groupBy(transactions, (t) => {
      const stripped = TransactionsStatsService.stripDate(t.createDate);

      return `${stripped.getFullYear()}-${stripped.getMonth() + 1}-${stripped.getDate()}`;
    });
    
    const balances: { [key: string]: number } = {};
    for (const date in grouped) {
      balances[date] = TransactionsStatsService.sum(grouped[date]);
    }

    return {
      fromDate: from,
      toDate: to,
      largestIncome,
      averageIncome: incomesCount === 0 ? 0 : incomesSum / incomesCount,
      incomesSum,
      incomesCount,
      expensesSum,
      expensesCount: expenses.length,
      balances,
    };
  }

  private static sum(arr: Transaction[]): number {
    return arr.reduce((acc, cur) => acc + cur.amount, 0);
  }

  private static stripDate(date: Date): Date {
    return new Date(date.getFullYear(), date.getMonth(), date.getDate());
  }
}
