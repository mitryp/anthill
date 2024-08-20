import { PartialType } from '@nestjs/swagger';
import { ReceivedCreateDto } from './received.create.dto';

export class ReceivedUpdateDto extends PartialType(ReceivedCreateDto) {}
