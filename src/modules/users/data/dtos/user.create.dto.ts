import { AutoMap } from 'automapper-classes';
import { IsEmail, IsEnum, IsStrongPassword } from 'class-validator';
import { UserRole } from '../entities/user.entity';

export class UserCreateDto {
  @AutoMap()
  name: string;

  @IsEmail()
  @AutoMap()
  email: string;

  @IsEnum(UserRole)
  @AutoMap()
  role: UserRole;

  @IsStrongPassword({
    minLength: 8,
    minNumbers: 1,
    minLowercase: 1,
    minUppercase: 1,
    minSymbols: 0,
  })
  password: string;
}

export type HashedPasswordUserDto = UserCreateDto & {
  passwordHash: string;
};
