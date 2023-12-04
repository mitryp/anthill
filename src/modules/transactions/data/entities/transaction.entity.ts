import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('transactions')
export class Transaction {
  @PrimaryGeneratedColumn()
  id: number;

  @CreateDateColumn()
  createDate: Date;

  @DeleteDateColumn({ default: null })
  deleteDate?: Date;

  @Column({ type: 'numeric', scale: 10, precision: 5 })
  amount: number;

  @Column()
  isIncome: boolean;

  @Column()
  sourceOrPurpose: string;

  @Column()
  note: string;
}
