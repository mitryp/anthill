import { Controller, Get, Query } from '@nestjs/common';
import { ApiQuery, ApiTags } from '@nestjs/swagger';
import { ParseDatePipe } from '../../common/utils/parse-date.pipe';
import { TransactionsStatsService } from './transactions.stats.service';
import { TransactionStatsDto } from './data/dtos/transaction.stats.dto';

@ApiTags('Transactions', 'Stats')
@Controller('transactions/stats')
export class TransactionsStatsController {
  constructor(private readonly statsService: TransactionsStatsService) {}

  @Get('range')
  @ApiQuery({ name: 'from', type: String, example: '2023-12-31' })
  @ApiQuery({ name: 'to', type: String, example: '2023-12-31' })
  async forRange(
    @Query('from', ParseDatePipe) from: Date,
    @Query('to', ParseDatePipe) to: Date,
  ): Promise<TransactionStatsDto> {
    return this.statsService.statsForRange(from, to);
  }
}
