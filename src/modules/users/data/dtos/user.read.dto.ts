import { AutoMap } from 'automapper-classes';
import { IsDate, IsEmail, IsEnum, IsNumber } from 'class-validator';
import { UserRole } from '../entities/user.entity';

export class UserReadDto {
  @AutoMap()
  @IsNumber()
  id: number;

  @AutoMap()
  @IsDate()
  createDate: Date;

  @AutoMap()
  deleteDate?: Date;

  @AutoMap()
  name: string;

  @IsEmail()
  @AutoMap()
  email: string;

  @IsEnum(UserRole)
  @AutoMap()
  role: UserRole;
}
