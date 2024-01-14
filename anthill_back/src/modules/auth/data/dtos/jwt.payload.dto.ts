import { UserRole } from '../../../users/data/entities/user.entity';

export class JwtPayloadDto {
  id: number;
  role: UserRole;
}
