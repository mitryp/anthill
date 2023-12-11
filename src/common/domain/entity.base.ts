import { AutoMap } from 'automapper-classes';
import { CreateDateColumn, DeleteDateColumn, PrimaryGeneratedColumn } from 'typeorm';

export abstract class EntityBase {
  @AutoMap()
  @PrimaryGeneratedColumn()
  id: number;

  @AutoMap()
  @CreateDateColumn()
  createDate: Date;

  @AutoMap()
  @DeleteDateColumn({ default: null })
  deleteDate?: Date;
}