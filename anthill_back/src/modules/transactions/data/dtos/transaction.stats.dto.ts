import { ApiProperty } from '@nestjs/swagger';

export class TransactionStatsDto {
  fromDate: Date;
  toDate: Date;
  largestIncome: number;
  averageIncome: number;
  incomesSum: number;
  incomesCount: number;
  expensesCount: number;
  expensesSum: number;

  // a map from a Date string representation (YYYY-MM-DD)
  // to total amount received at that day
  @ApiProperty({
    name: 'balances',
    type: {},
    example: {
      '2024-03-18': 12.3,
      '2024-03-17': 3.4,
    },
  })
  balances: {
    [key: string]: number;
  };
}
