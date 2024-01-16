import { AutoMap } from 'automapper-classes';
import { UserReadDto } from '../../../users/data/dtos/user.read.dto';

// A user-facing dto representing a log entry.
export class LogEntryReadDto {
  @AutoMap()
  id: number;

  @AutoMap()
  createDate: Date;

  user: UserReadDto;

  @AutoMap()
  action: string;

  @AutoMap()
  moduleName: string;

  @AutoMap()
  resourceAffected?: string;

  @AutoMap()
  targetEntityId?: number;

  @AutoMap()
  jsonPayload?: object;
}
