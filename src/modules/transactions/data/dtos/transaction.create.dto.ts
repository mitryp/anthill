import { IsBoolean, IsNotEmpty, IsNumber, Max, Min } from 'class-validator';
import { AutoMap } from '@automapper/classes';

export class TransactionCreateDto {
  @AutoMap()
  @Min(-99999999.99)
  @Max(99999999.99)
  @IsNumber()
  amount: number;

  @AutoMap()
  @IsBoolean()
  isIncome: boolean;

  @AutoMap()
  @IsNotEmpty()
  sourceOrPurpose: string;

  @AutoMap()
  note?: string;
}
