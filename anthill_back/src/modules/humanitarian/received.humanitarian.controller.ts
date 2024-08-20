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
  SuggestionEnabledControllerBase,
  SUGGESTIONS_ENDPOINT_NAME,
} from '../../common/domain/resource.controller.base';
import { Received } from './data/entities/received.entity';
import { ReceivedReadDto } from './data/dtos/received.read.dto';
import { ReceivedCreateDto, ReceivedCreateDtoWithUser } from './data/dtos/received.create.dto';
import { ReceivedUpdateDto } from './data/dtos/received.update.dto';
import {
  ReceivedHumanitarianService,
  receivedPaginateConfig,
} from './received.humanitarian.service';
import { LoggingService } from '../logging/logging.service';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { SuggestionsDto } from '../../common/domain/suggestions.dto';
import { Request } from 'express';
import { SessionPayloadDto } from '../auth/data/dtos/session.payload.dto';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { RolesGuard } from '../auth/roles.guard';
import { UserRole } from '../users/data/entities/user.entity';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Received Aid')
@Controller('aid/received')
export class ReceivedHumanitarianController
  implements
    ModifiableResourceControllerBase<
      Received,
      ReceivedReadDto,
      ReceivedCreateDto,
      ReceivedUpdateDto
    >,
    SuggestionEnabledControllerBase
{
  constructor(
    private readonly receivedService: ReceivedHumanitarianService,
    private readonly logger: LoggingService,
  ) {}

  @PaginateConfigEndpoint()
  readPaginateConfig(): PaginateConfig<Received> {
    return receivedPaginateConfig;
  }

  @Get(SUGGESTIONS_ENDPOINT_NAME)
  async readSuggestions(): Promise<SuggestionsDto> {
    return this.receivedService.getSuggestions();
  }

  @Get(':id')
  async readOne(@Param('id') id: number): Promise<ReceivedReadDto> {
    const received = await this.receivedService.readOne(id);

    if (!received) {
      throw new NotFoundException();
    }

    return received;
  }

  @Get()
  @PaginatedSwaggerDocs(ReceivedReadDto, receivedPaginateConfig)
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<ReceivedReadDto>> {
    return this.receivedService.readAll(query);
  }

  @Post()
  async create(@Body() received: ReceivedCreateDto, @Req() req: Request): Promise<ReceivedReadDto> {
    const userId = (req.user as SessionPayloadDto).id;

    const dto = received as ReceivedCreateDtoWithUser;
    dto.userId = userId;

    const res = await this.receivedService.create(dto);

    // todo logging

    return res;
  }

  @Patch(':id')
  async update(
    @Param('id') id: number,
    @Body() dto: ReceivedUpdateDto,
    @Req() req: Request,
  ): Promise<ReceivedReadDto> {
    const user = req.user as SessionPayloadDto;
    const res = await this.receivedService.update(id, dto, user);

    // todo logging

    return res;
  }

  @Delete(':id')
  async delete(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const user = req.user as SessionPayloadDto;
    const res = await this.receivedService.delete(id, user);

    // todo logging

    return res;
  }

  @UseGuards(new RolesGuard(UserRole.admin))
  @Post(':id')
  async restore(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    // todo logging
    return this.receivedService.restore(id);
  }
}
