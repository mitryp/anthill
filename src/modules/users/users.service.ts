import { Injectable } from '@nestjs/common';
import { ModifiableResourceServiceBase } from '../../common/domain/resource.service.base';
import { User } from './data/entities/user.entity';
import { UserReadDto } from './data/dtos/user.read.dto';
import { UserCreateDto, HashedPasswordUserDto } from './data/dtos/user.create.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { PaginateConfig } from 'nestjs-paginate';
import { UserUpdateDto } from './data/dtos/user.update.dto';
import { AuthenticationService } from '../auth/authentication.service';

@Injectable()
export class UsersService extends ModifiableResourceServiceBase<
  User,
  UserReadDto,
  UserCreateDto,
  UserUpdateDto
> {
  constructor(
    @InjectRepository(User) repository: Repository<User>,
    @InjectMapper() mapper: Mapper,
    private readonly authService: AuthenticationService
  ) {
    super(
      repository,
      mapper,
      User,
      UserReadDto,
      UserCreateDto,
      UserUpdateDto,
      usersPaginateConfig
    );
  }

  async create(dto: UserCreateDto): Promise<UserReadDto> {
    const dtoWithPassword = dto as HashedPasswordUserDto;

    dtoWithPassword.passwordHash = await this.authService.hashPassword(dto.password);
    dtoWithPassword.password = undefined;
    dto.password = undefined;

    return super.create(dtoWithPassword);
  }

  async update(id: number, dto: UserUpdateDto): Promise<UserReadDto | undefined> {
    const dtoWithPassword = dto as Partial<HashedPasswordUserDto>;

    if (dtoWithPassword.password !== undefined) {
      dtoWithPassword.passwordHash = await this.authService.hashPassword(dto.password);
      dtoWithPassword.password = undefined;
    }

    return super.update(id, dtoWithPassword);
  }
}

export const usersPaginateConfig: PaginateConfig<User> = {
  sortableColumns: ['createDate', 'name'],
  defaultSortBy: [['name', 'ASC']],
  searchableColumns: ['name']
  // todo filters
};
