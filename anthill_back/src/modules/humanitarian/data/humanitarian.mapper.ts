import { Injectable } from '@nestjs/common';
import { AutomapperProfile, InjectMapper } from 'automapper-nestjs';
import { createMap, forMember, mapFrom, Mapper, MappingProfile } from 'automapper-core';
import { Received } from './entities/received.entity';
import { ReceivedReadDto } from './dtos/received.read.dto';
import { UserReadDto } from '../../users/data/dtos/user.read.dto';
import { User } from '../../users/data/entities/user.entity';
import { ReceivedCreateDtoWithUser } from './dtos/received.create.dto';
import { ReceivedUpdateDto } from './dtos/received.update.dto';
import { Sent } from './entities/sent.entity';
import { SentReadDto } from './dtos/sent.read.dto';
import { SentCreateDtoWithUser } from './dtos/sent.create.dto';
import { SentUpdateDto } from './dtos/sent.update.dto';

@Injectable()
export class HumanitarianMapper extends AutomapperProfile {
  constructor(@InjectMapper() mapper: Mapper) {
    super(mapper);
  }

  override get profile(): MappingProfile {
    return (mapper) => {
      createMap(
        mapper,
        Received,
        ReceivedReadDto,
        forMember(
          (dest) => dest.user,
          mapFrom((source) => mapper.map(source.user, User, UserReadDto)),
        ),
      );
      createMap(
        mapper,
        ReceivedCreateDtoWithUser,
        Received,
        forMember(
          (dest) => dest.user,
          mapFrom((source) => ({ id: source.userId })),
        ),
      );
      createMap(
        mapper,
        ReceivedUpdateDto,
        Received,
        forMember(
          (dest) => dest.source,
          mapFrom((source) => source.source),
        ),
        forMember(
          (dest) => dest.note,
          mapFrom((source) => source.note),
        ),
        forMember(
          (dest) => dest.quantity,
          mapFrom((source) => source.quantity),
        ),
      );
      createMap(
        mapper,
        Sent,
        SentReadDto,
        forMember(
          (dest) => dest.user,
          mapFrom((source) => mapper.map(source.user, User, UserReadDto)),
        ),
      );
      createMap(
        mapper,
        SentCreateDtoWithUser,
        Sent,
        forMember(
          (dest) => dest.user,
          mapFrom((source) => ({ id: source.userId })),
        ),
      );
      createMap(
        mapper,
        SentUpdateDto,
        Sent,
        forMember(
          (dest) => dest.purpose,
          mapFrom((source) => source.purpose),
        ),
        forMember(
          (dest) => dest.note,
          mapFrom((source) => source.note),
        ),
        forMember(
          (dest) => dest.quantity,
          mapFrom((source) => source.quantity),
        ),
        forMember(
          (dest) => dest.shipmentMethod,
          mapFrom((source) => source.shipmentMethod),
        ),
        forMember(
          (dest) => dest.reportProvided,
          mapFrom((source) => source.reportProvided),
        ),
      );
    };
  }
}
