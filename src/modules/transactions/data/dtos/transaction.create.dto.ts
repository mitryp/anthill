import { IsBoolean, IsNotEmpty, IsNumber, Max, Min } from 'class-validator';

export class TransactionCreateDto {
  @Min(-99999999.99)
  @Max(99999999.99)
  @IsNumber()
  amount: number;

  @IsBoolean()
  isIncome: boolean;

  @IsNotEmpty()
  sourceOrPurpose: string;

  note?: string;
}
