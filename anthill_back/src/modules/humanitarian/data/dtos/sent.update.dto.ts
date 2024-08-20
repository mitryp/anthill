import { PartialType } from '@nestjs/swagger';
import { SentCreateDto } from './sent.create.dto';

export class SentUpdateDto extends PartialType(SentCreateDto) {}
