import { AutoMap } from 'automapper-classes';
import { IsDate, IsInt, IsNotEmpty, IsNumber, IsPositive, IsString } from 'class-validator';
import { UserReadDto } from '../../../users/data/dtos/user.read.dto';

export class ReceivedReadDto {
  @AutoMap()
  @IsNumber()
  id: number;

  @AutoMap()
  @IsDate()
  createDate: Date;

  @AutoMap()
  deleteDate: Date;

  @AutoMap()
  @IsString()
  @IsNotEmpty()
  source: string;

  @AutoMap()
  @IsInt()
  @IsPositive()
  quantity: number;

  @AutoMap()
  @IsString()
  note: string;

  @AutoMap()
  user: UserReadDto;
}
