import { Get } from '@nestjs/common';
import { PaginateConfig, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from './read-many.dto';
import { Request } from 'express';
import { SuggestionsDto } from './suggestions.dto';

export const PaginateConfigEndpoint = () => Get('paginate_config');

export interface ResourceControllerBase<TEntity, TRead> {
  readPaginateConfig(): PaginateConfig<TEntity>;

  readAll(query: PaginateQuery): Promise<ReadManyDto<TRead>>;

  readOne(id: number): Promise<TRead>;
}

export interface ModifiableResourceControllerBase<TEntity, TRead, TCreate, TUpdate>
  extends ResourceControllerBase<TEntity, TRead> {
  create(_: TCreate, req: Request): Promise<TRead>;

  update(id: number, _: TUpdate, req: Request): Promise<TRead>;

  delete(id: number, req: Request): Promise<boolean>;

  restore(id: number, req: Request): Promise<boolean>;
}

export interface SuggestionEnabledControllerBase {
  readSuggestions(): Promise<SuggestionsDto>;
}

export const SUGGESTIONS_ENDPOINT_NAME = 'suggestions';
