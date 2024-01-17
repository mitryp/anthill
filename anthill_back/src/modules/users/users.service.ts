import { Injectable } from '@nestjs/common';
import { ModifiableResourceServiceBase } from '../../common/domain/resource.service.base';
import { User } from './data/entities/user.entity';
import { UserReadDto } from './data/dtos/user.read.dto';
import { HashedPasswordUserDto, UserCreateDto } from './data/dtos/user.create.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InjectMapper } from 'automapper-nestjs';
import { Mapper } from 'automapper-core';
import { FilterOperator, FilterSuffix, PaginateConfig } from 'nestjs-paginate';
import { UserUpdateDto } from './data/dtos/user.update.dto';
import { EncryptionService } from '../../common/utils/encryption.service';

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
    private readonly encryptionService: EncryptionService,
  ) {
    super(repository, mapper, User, UserReadDto, UserCreateDto, UserUpdateDto, usersPaginateConfig);
  }

  // Returns User entity by the given email.
  // If no entity with the email exists, throws NotFoundException.
  //
  // Intended for internal use only.
  async readByEmail(email: string): Promise<User> {
    return await this.repository.findOne({ where: { email } });
  }

  async create(dto: UserCreateDto): Promise<UserReadDto> {
    const dtoWithPassword = dto as HashedPasswordUserDto;

    dtoWithPassword.passwordHash = await this.encryptionService.hashPassword(dto.password);
    dtoWithPassword.password = undefined;
    dto.password = undefined;

    return super.create(dtoWithPassword);
  }

  async update(id: number, dto: UserUpdateDto): Promise<UserReadDto | undefined> {
    const dtoWithPassword = dto as Partial<HashedPasswordUserDto>;

    if (dtoWithPassword.password) {
      dtoWithPassword.passwordHash = await this.encryptionService.hashPassword(dto.password);
    }
    dtoWithPassword.password = undefined;

    return super.update(id, dtoWithPassword);
  }
}

export const usersPaginateConfig: PaginateConfig<User> = {
  withDeleted: true,
  sortableColumns: ['createDate', 'name'],
  defaultSortBy: [['name', 'ASC']],
  searchableColumns: ['name', 'email'],
  filterableColumns: { deleteDate: [FilterOperator.NULL, FilterSuffix.NOT] },
  // todo filters
};
