import { Column, Entity, ManyToOne } from 'typeorm';
import { EntityBase } from '../../../../common/domain/entity.base';
import { User } from '../../../users/data/entities/user.entity';
import { AutoMap } from 'automapper-classes';

@Entity('log_entries')
export class LogEntryEntity extends EntityBase {
  // A user who performed the action this log entry is about.
  @ManyToOne(() => User, {
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
    orphanedRowAction: 'disable',
    nullable: false,
  })
  user: User;

  // The name of the action performed.
  // Modules typically define a set of their actions.
  @AutoMap()
  @Column()
  action: string;

  // The name of the module which reported this action.
  @AutoMap()
  @Column()
  moduleName: string;

  // The name of the resource affected by this action.
  // Can be null if there is no resource affected.
  @AutoMap()
  @Column({ nullable: true })
  resourceAffected?: string;

  // An entity the action was performed on.
  // Can be null if there is no related entry.
  @AutoMap()
  @Column({ nullable: true })
  targetEntityId?: number;

  // A module-specific JSON payload.
  // Can be null if the action does not require additional data stored.
  @AutoMap()
  @Column({ type: 'jsonb', nullable: true })
  jsonPayload?: object;
}
