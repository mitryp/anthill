import { Injectable } from '@nestjs/common';
import { AutomapperProfile, InjectMapper } from 'automapper-nestjs';
import { createMap, forMember, mapFrom, Mapper, MappingProfile } from 'automapper-core';
import { LogEntry } from './entities/log-entry.entity';
import { LogEntryReadDto } from './dtos/log-entry.read.dto';
import { UserReadDto } from '../../users/data/dtos/user.read.dto';
import { User } from '../../users/data/entities/user.entity';
import { LogEntryCreateDto } from './dtos/log-entry.create.dto';

@Injectable()
export class LoggingMapper extends AutomapperProfile {
  constructor(@InjectMapper() mapper: Mapper) {
    super(mapper);
  }

  override get profile(): MappingProfile {
    return (mapper) => {
      createMap(
        mapper,
        LogEntry,
        LogEntryReadDto,
        forMember(
          (dest) => dest.user,
          mapFrom((source) => mapper.map(source.user, User, UserReadDto)),
        ),
      );
      createMap(
        mapper,
        LogEntryCreateDto,
        LogEntry,
        forMember(
          (dest) => dest.user,
          mapFrom((source) => ({ id: source.userId })),
        ),
        forMember(
          (dest) => dest.action,
          mapFrom((source) => source.action),
        ),
      );
    };
  }
}
