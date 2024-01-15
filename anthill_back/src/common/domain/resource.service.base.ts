import { DeepPartial, FindOptionsWhere, Repository } from 'typeorm';
import { Mapper } from 'automapper-core';
import { NotFoundException, Type } from '@nestjs/common';
import { EntityBase } from './entity.base';
import { paginate, Paginate, PaginateConfig, Paginated, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from './read-many.dto';

export abstract class ResourceServiceBase<TEntity extends EntityBase, TReadDto> {
  protected constructor(
    protected readonly repository: Repository<TEntity>,
    protected readonly mapper: Mapper,
    protected readonly entityType: Type<TEntity>,
    protected readonly readDtoType: Type<TReadDto>,
    protected readonly paginateConfig: PaginateConfig<TEntity>,
  ) {}

  protected mapOne(entity: TEntity): TReadDto {
    return this.mapper.map(entity, this.entityType, this.readDtoType);
  }

  protected mapPaginated(paginated: Paginated<TEntity>): ReadManyDto<TReadDto> {
    return {
      meta: paginated.meta,
      data: paginated.data.map((value) => this.mapOne(value)),
    };
  }

  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<TReadDto>> {
    const paginated = await paginate(query, this.repository, this.paginateConfig);

    return this.mapPaginated(paginated);
  }

  async readOne(id: number): Promise<TReadDto | undefined> {
    const entity = await this.repository.findOne({
      where: { id } as FindOptionsWhere<TEntity>,
      withDeleted: true,
    });

    return this.mapOne(entity);
  }
}

export abstract class ModifiableResourceServiceBase<
  TEntity extends EntityBase,
  TReadDto,
  TCreateDto,
  TUpdateDto,
> extends ResourceServiceBase<TEntity, TReadDto> {
  protected constructor(
    protected readonly repository: Repository<TEntity>,
    protected readonly mapper: Mapper,
    protected readonly entityType: Type<TEntity>,
    protected readonly readDtoType: Type<TReadDto>,
    protected readonly createDtoType: Type<TCreateDto>,
    protected readonly updateDtoType: Type<TUpdateDto>,
    protected readonly paginateConfig: PaginateConfig<TEntity>,
  ) {
    super(repository, mapper, entityType, readDtoType, paginateConfig);
  }

  async create(dto: TCreateDto): Promise<TReadDto> {
    const toInsert = this.mapper.map(dto, this.createDtoType, this.entityType);

    const res = await this.repository.save(toInsert);

    return this.mapOne(res);
  }

  async delete(id: number): Promise<boolean> {
    const entity = await this.repository.findOne({
      where: { id } as FindOptionsWhere<TEntity>,
      withDeleted: false,
      relations: this.paginateConfig.relations,
    });

    if (entity === null) {
      throw new NotFoundException();
    }

    await this.repository.softDelete({ id } as FindOptionsWhere<TEntity>);

    return true;
  }

  async update(id: number, dto: TUpdateDto): Promise<TReadDto | undefined> {
    const existing = await this.repository.findOne({ where: { id } as FindOptionsWhere<TEntity> });

    if (!existing || existing.deleteDate !== null) {
      throw new NotFoundException();
    }

    const entity = this.mapper.map(dto, this.updateDtoType, this.entityType);
    const updated = await this.repository.save({ id, ...entity } as DeepPartial<TEntity>);

    return this.mapOne(Object.assign(updated, existing));
  }
}
