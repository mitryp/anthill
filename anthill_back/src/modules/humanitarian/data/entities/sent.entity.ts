// Date,  Purpose,          Quantity (boxes),  Note,     Shipment method   Report Provided

// 19.08  Orphanage         5                  hygiene   Delivery by post  yes
// 11.08  Orphanage         3                  medicine  Delivery by post  no
// 11.08  Refugees          3                  clothes   Delivery by truck yes

import { EntityBase } from '../../../../common/domain/entity.base';
import { AutoMap } from 'automapper-classes';
import { Column, Entity, Index, ManyToOne } from 'typeorm';
import { User } from '../../../users/data/entities/user.entity';

@Entity('sent_aid')
export class Sent extends EntityBase {
  @AutoMap()
  @Column()
  @Index()
  purpose: string;

  @AutoMap()
  @Column({ type: 'int' })
  quantity: number;

  @AutoMap()
  @Column({ default: '' })
  note: string;

  @AutoMap()
  @Column()
  @Index()
  shipmentMethod: string;

  @AutoMap()
  @Column()
  reportProvided: boolean;

  @ManyToOne(() => User, {
    eager: true,
    onDelete: 'RESTRICT',
    onUpdate: 'CASCADE',
    orphanedRowAction: 'disable',
    nullable: false,
  })
  user: User;
}
