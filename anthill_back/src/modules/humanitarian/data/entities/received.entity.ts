// Date,  Source,           Quantity (sacks),  Note

// 19.08  Library           5                  clothes
// 11.08  Library           3                  medicine
// 11.08  Private donation  3                  clothes

import { EntityBase } from '../../../../common/domain/entity.base';
import { AutoMap } from 'automapper-classes';
import { Column, Entity, Index, ManyToOne } from 'typeorm';
import { User } from '../../../users/data/entities/user.entity';

@Entity('received_aid')
export class Received extends EntityBase {
  @AutoMap()
  @Column()
  @Index()
  source: string;

  @AutoMap()
  @Column({ type: 'int' })
  quantity: number;

  @AutoMap()
  @Column({ default: '' })
  note: string;

  @ManyToOne(() => User, {
    eager: true,
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
    orphanedRowAction: 'disable',
    nullable: false,
  })
  user: User;
}
