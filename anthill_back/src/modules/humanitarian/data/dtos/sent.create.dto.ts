import { AutoMap } from 'automapper-classes';
import { IsBoolean, IsInt, IsNotEmpty, IsPositive, IsString } from 'class-validator';

export class SentCreateDto {
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
}

export class SentCreateDtoWithUser extends SentCreateDto {
  userId: number;
}
