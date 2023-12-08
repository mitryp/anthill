import { TransactionCreateDto } from './transaction.create.dto';
import { PartialType } from '@nestjs/swagger';

export class TransactionUpdateDto extends PartialType(TransactionCreateDto) {}