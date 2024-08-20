import { AutoMap } from 'automapper-classes';
import {
  IsBoolean,
  IsDate,
  IsInt,
  IsNotEmpty,
  IsNumber,
  IsPositive,
  IsString,
} from 'class-validator';
import { UserReadDto } from '../../../users/data/dtos/user.read.dto';

export class SentReadDto {
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
  purpose: string;

  @AutoMap()
  @IsInt()
  @IsPositive()
  quantity: number;

  @AutoMap()
  @IsString()
  note: string;

  @AutoMap()
  @IsString()
  @IsNotEmpty()
  shipmentMethod: string;

  @AutoMap()
  @IsBoolean()
  reportProvided: boolean;

  @AutoMap()
  user: UserReadDto;
}
