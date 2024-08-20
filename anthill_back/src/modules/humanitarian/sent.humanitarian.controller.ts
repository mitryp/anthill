import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Patch,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import {
  ModifiableResourceControllerBase,
  PaginateConfigEndpoint,
  SUGGESTIONS_ENDPOINT_NAME,
} from '../../common/domain/resource.controller.base';
import { LoggingService } from '../logging/logging.service';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { SuggestionsDto } from '../../common/domain/suggestions.dto';
import { Request } from 'express';
import { SessionPayloadDto } from '../auth/data/dtos/session.payload.dto';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { RolesGuard } from '../auth/roles.guard';
import { UserRole } from '../users/data/entities/user.entity';
import { ApiTags } from '@nestjs/swagger';
import { Sent } from './data/entities/sent.entity';
import { SentCreateDto, SentCreateDtoWithUser } from './data/dtos/sent.create.dto';
import { SentUpdateDto } from './data/dtos/sent.update.dto';
import { SentReadDto } from './data/dtos/sent.read.dto';
import { SentHumanitarianService, sentPaginateConfig } from './sent.humanitarian.service';

@ApiTags('Sent Aid')
@Controller('aid/sent')
export class SentHumanitarianController
  implements ModifiableResourceControllerBase<Sent, SentReadDto, SentCreateDto, SentUpdateDto>
{
  constructor(
    private readonly sentService: SentHumanitarianService,
    private readonly logger: LoggingService,
  ) {}

  @PaginateConfigEndpoint()
  readPaginateConfig(): PaginateConfig<Sent> {
    return sentPaginateConfig;
  }

  @Get(`${SUGGESTIONS_ENDPOINT_NAME}/purpose`)
  async readPurposeSuggestions(): Promise<SuggestionsDto> {
    return this.sentService.getPurposeSuggestions();
  }

  @Get(`${SUGGESTIONS_ENDPOINT_NAME}/shipment_method`)
  async readShipmentMethodSuggestions(): Promise<SuggestionsDto> {
    return this.sentService.getShipmentMethodSuggestions();
  }

  @Get(':id')
  async readOne(@Param('id') id: number): Promise<SentReadDto> {
    const received = await this.sentService.readOne(id);

    if (!received) {
      throw new NotFoundException();
    }

    return received;
  }

  @Get()
  @PaginatedSwaggerDocs(SentReadDto, sentPaginateConfig)
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<SentReadDto>> {
    return this.sentService.readAll(query);
  }

  @Post()
  async create(@Body() received: SentCreateDto, @Req() req: Request): Promise<SentReadDto> {
    const userId = (req.user as SessionPayloadDto).id;

    const dto = received as SentCreateDtoWithUser;
    dto.userId = userId;

    const res = await this.sentService.create(dto);

    // todo logging

    return res;
  }

  @Patch(':id')
  async update(
    @Param('id') id: number,
    @Body() dto: SentUpdateDto,
    @Req() req: Request,
  ): Promise<SentReadDto> {
    const user = req.user as SessionPayloadDto;
    const res = await this.sentService.update(id, dto, user);

    // todo logging

    return res;
  }

  @Delete(':id')
  async delete(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const user = req.user as SessionPayloadDto;
    const res = await this.sentService.delete(id, user);

    // todo logging

    return res;
  }

  @UseGuards(new RolesGuard(UserRole.admin))
  @Post(':id')
  async restore(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    // todo logging
    return this.sentService.restore(id);
  }
}
