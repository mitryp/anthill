import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { AutoMap } from '@automapper/classes';

@Entity('transactions')
export class Transaction {
  @AutoMap()
  @PrimaryGeneratedColumn()
  id: number;

  @AutoMap()
  @CreateDateColumn()
  createDate: Date;

  @DeleteDateColumn({ default: null })
  deleteDate?: Date;

  @AutoMap()
  @Column({ type: 'numeric', scale: 2, precision: 10 })
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
