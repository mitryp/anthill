import { Column, Entity } from 'typeorm';
import { AutoMap } from 'automapper-classes';
import { NumericToNumber } from '../../../../common/utils/type_transformers/numericToNumber';
import { EntityBase } from '../../../../common/domain/entity.base';

@Entity('transactions')
export class Transaction extends EntityBase {
  @AutoMap()
  @Column({ type: 'numeric', scale: 2, precision: 10, transformer: new NumericToNumber() })
  amount: number;

  @AutoMap()
  @Column()
  isIncome: boolean;

  @AutoMap()
  @Column()
  sourceOrPurpose: string;

  @AutoMap()
  @Column({ default: '' })
  note: string;
}
