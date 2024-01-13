import { AutomapperProfile, InjectMapper } from 'automapper-nestjs';
import { Injectable } from '@nestjs/common';
import { createMap, forMember, mapFrom, Mapper, MappingProfile } from 'automapper-core';
import { Transaction } from './entities/transaction.entity';
import { TransactionReadDto } from './dtos/transaction.read.dto';
import { TransactionCreateDto } from './dtos/transaction.create.dto';
import { TransactionUpdateDto } from './dtos/transaction.update.dto';

@Injectable()
export class TransactionMapper extends AutomapperProfile {
  constructor(@InjectMapper() mapper: Mapper) {
    super(mapper);
  }

  override get profile(): MappingProfile {
    return (mapper) => {
      createMap(mapper, Transaction, TransactionReadDto);
      createMap(mapper, TransactionCreateDto, Transaction);
      createMap(
        mapper,
        TransactionUpdateDto,
        Transaction,
        forMember(
          (dest) => dest.amount,
          mapFrom((source) => source.amount),
        ),
        forMember(
          (dest) => dest.note,
          mapFrom((source) => source.note),
        ),
        forMember(
          (dest) => dest.sourceOrPurpose,
          mapFrom((source) => source.sourceOrPurpose),
        ),
        forMember(
          (dest) => dest.isIncome,
          mapFrom((source) => source.isIncome),
        ),
      );
    };
  }
}
