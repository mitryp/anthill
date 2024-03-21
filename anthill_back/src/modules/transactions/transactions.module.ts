import { Module } from '@nestjs/common';
import { TransactionMapper } from './data/transaction.mapper';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Transaction } from './data/entities/transaction.entity';
import { TransactionsController } from './transactions.controller';
import { TransactionsService } from './transactions.service';
import { LoggingModule } from '../logging/logging.module';
import { TransactionsStatsController } from './transactions.stats.controller';
import { TransactionsStatsService } from './transactions.stats.service';

@Module({
  imports: [TypeOrmModule.forFeature([Transaction]), LoggingModule],
  controllers: [TransactionsController, TransactionsStatsController],
  providers: [TransactionMapper, TransactionsService, TransactionsStatsService],
})
export class TransactionsModule {}
