import { Injectable } from '@nestjs/common';
import { AutomapperProfile, InjectMapper } from 'automapper-nestjs';
import { createMap, Mapper, MappingProfile } from 'automapper-core';
import { SessionPayloadDto } from './dtos/session.payload.dto';
import { UserReadDto } from '../../users/data/dtos/user.read.dto';
import { User } from '../../users/data/entities/user.entity';

@Injectable()
export class AuthMapper extends AutomapperProfile {
  constructor(@InjectMapper() mapper: Mapper) {
    super(mapper);
  }

  override get profile(): MappingProfile {
    return (mapper) => {
      createMap(mapper, UserReadDto, SessionPayloadDto);
      createMap(mapper, User, SessionPayloadDto);
    };
  }
}
