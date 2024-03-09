import { UserRole } from '../../../users/data/entities/user.entity';
import { AutoMap } from 'automapper-classes';

export class SessionPayloadDto {
  @AutoMap()
  id: number;

  @AutoMap()
  role: UserRole;
}
