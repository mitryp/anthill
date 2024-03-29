import { Column, Entity } from 'typeorm';
import { EntityBase } from '../../../../common/domain/entity.base';
import { AutoMap } from 'automapper-classes';

export enum UserRole {
  accountant = 'accountant',
  volunteer = 'volunteer',
  admin = 'admin',
}

@Entity('users')
export class User extends EntityBase {
  @AutoMap()
  @Column()
  name: string;

  @AutoMap()
  @Column({ unique: true })
  email: string;

  @AutoMap()
  @Column({ type: 'enum', enum: UserRole, default: UserRole.volunteer })
  role: UserRole;

  @Column()
  passwordHash: string;
}
