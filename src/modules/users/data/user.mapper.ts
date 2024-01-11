import { Injectable } from '@nestjs/common';
import { AutomapperProfile, InjectMapper } from 'automapper-nestjs';
import { createMap, forMember, mapFrom, Mapper, MappingProfile } from 'automapper-core';
import { User } from './entities/user.entity';
import { UserReadDto } from './dtos/user.read.dto';
import { HashedPasswordUserDto, UserCreateDto } from './dtos/user.create.dto';
import { UserUpdateDto } from './dtos/user.update.dto';

@Injectable()
export class UserMapper extends AutomapperProfile {
  constructor(@InjectMapper() mapper: Mapper) {
    super(mapper);
  }

  override get profile(): MappingProfile {
    return (mapper) => {
      createMap(mapper, User, UserReadDto);
      createMap(
        mapper,
        UserCreateDto,
        User,
        forMember(
          (user) => user.passwordHash,
          mapFrom((source) => (source as HashedPasswordUserDto).passwordHash),
        ),
      );
      createMap(
        mapper,
        UserUpdateDto,
        User,
        forMember(
          (user) => user.name,
          mapFrom((source) => source.name),
        ),
        forMember(
          (user) => user.email,
          mapFrom((source) => source.email),
        ),
        forMember(
          (user) => user.role,
          mapFrom((source) => source.role),
        ),
        forMember(
          (user) => user.passwordHash,
          mapFrom((source) => (source as Partial<HashedPasswordUserDto>).passwordHash),
        ),
      );
    };
  }
}
