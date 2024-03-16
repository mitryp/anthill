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
  @ApiQuery({ name: 'from', type: String, example: '20231231' })
  @ApiQuery({ name: 'to', type: String, example: '20231231' })
  async forRange(
    @Query('from', ParseDatePipe) from: Date,
    @Query('to', ParseDatePipe) to: Date,
  ): Promise<TransactionStatsDto> {
    // for the range to be inclusive
    to = addDay(to);

    return this.statsService.statsForRange(from, to);
  }
}

/**
 * Adds (24 hours - 1 ms) to the given date.
 */
function addDay(date: Date): Date {
  const msInSec = 1000;
  const secInMin = 60;
  const minInHour = 60;
  const hrsInDay = 24;

  return new Date(date.getTime() + hrsInDay * minInHour * secInMin * msInSec - 1);
}
