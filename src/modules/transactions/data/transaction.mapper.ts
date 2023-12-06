import { AutomapperProfile, InjectMapper } from '@automapper/nestjs';
import { Injectable } from '@nestjs/common';
import { createMap, Mapper, MappingProfile } from '@automapper/core';
import { Transaction } from './entities/transaction.entity';
import { TransactionReadDto } from './dtos/transaction.read.dto';

@Injectable()
export class TransactionMapper extends AutomapperProfile {
  constructor(@InjectMapper() mapper: Mapper) {
    super(mapper);
  }

  override get profile(): MappingProfile {
    return (mapper) => {
      createMap(mapper, Transaction, TransactionReadDto);
    };
  }
}
