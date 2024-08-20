import { AutoMap } from 'automapper-classes';
import { IsInt, IsNotEmpty, IsPositive, IsString } from 'class-validator';

export class ReceivedCreateDto {
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
}

export class ReceivedCreateDtoWithUser extends ReceivedCreateDto {
  userId: number;
}
