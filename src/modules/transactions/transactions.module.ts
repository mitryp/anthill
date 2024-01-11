import { Module } from '@nestjs/common';
import { TransactionMapper } from './data/transaction.mapper';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionsController } from './transactions.controller';
import { TransactionsService } from './transactions.service';

@Module({
  imports: [TypeOrmModule.forFeature([Transaction])],
  controllers: [TransactionsController],
  providers: [TransactionMapper, TransactionsService],
})
export class TransactionsModule {}
