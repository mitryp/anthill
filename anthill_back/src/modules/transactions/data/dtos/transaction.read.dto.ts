import { IsBoolean, IsDate, IsNotEmpty, IsNumber } from 'class-validator';
import { AutoMap } from 'automapper-classes';
import { UserReadDto } from '../../../users/data/dtos/user.read.dto';

export class TransactionReadDto {
  @AutoMap()
  @IsNumber()
  id: number;

  @AutoMap()
  @IsDate()
  createDate: Date;

  @AutoMap()
  deleteDate?: Date;

  @AutoMap()
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

  user: UserReadDto;
}
