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
import { transactionsPaginateConfig, TransactionsService } from './transactions.service';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import {
  TransactionCreateDto,
  TransactionCreateDtoWithUser,
} from './data/dtos/transaction.create.dto';
import { TransactionUpdateDto } from './data/dtos/transaction.update.dto';
import { ApiTags } from '@nestjs/swagger';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { Transaction } from './data/entities/transaction.entity';
import { SessionPayloadDto } from '../auth/data/dtos/session.payload.dto';
import { Request } from 'express';
import { LoggingService } from '../logging/logging.service';
import { LogEntryCreateDto } from '../logging/data/dtos/log-entry.create.dto';
import { UserRole } from '../users/data/entities/user.entity';
import { RolesGuard } from '../auth/roles.guard';
import {
  ModifiableResourceControllerBase,
  PaginateConfigEndpoint,
} from '../../common/domain/resource.controller.base';

@ApiTags('Transactions')
@Controller('transactions')
export class TransactionsController
  implements
    ModifiableResourceControllerBase<
      Transaction,
      TransactionReadDto,
      TransactionCreateDto,
      TransactionUpdateDto
    >
{
  constructor(
    private readonly transactionService: TransactionsService,
    private readonly logger: LoggingService,
  ) {}

  @PaginateConfigEndpoint()
  readPaginateConfig(): PaginateConfig<Transaction> {
    return transactionsPaginateConfig;
  }

  @Get()
  @PaginatedSwaggerDocs(TransactionReadDto, transactionsPaginateConfig)
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<TransactionReadDto>> {
    return this.transactionService.readAll(query);
  }

  @Get(':id')
  async readOne(@Param('id') id: number): Promise<TransactionReadDto> {
    const transaction = await this.transactionService.readOne(id);

    if (!transaction) {
      throw new NotFoundException();
    }

    return transaction;
  }

  @Post()
  async create(
    @Body() transaction: TransactionCreateDto,
    @Req() req: Request,
  ): Promise<TransactionReadDto> {
    const userId = (req.user as SessionPayloadDto).id;

    const transactionWithUser = transaction as TransactionCreateDtoWithUser;
    transactionWithUser.userId = userId;

    const res = await this.transactionService.create(transactionWithUser);

    await this.log({
      userId,
      action: 'createTransaction',
      targetEntityId: res.id,
    });

    return res;
  }

  @Patch(':id')
  async update(
    @Param('id') id: number,
    @Body() transaction: TransactionUpdateDto,
    @Req() req: Request,
  ): Promise<TransactionReadDto> {
    const user = req.user as SessionPayloadDto;

    const res = await this.transactionService.update(id, transaction, user);

    await this.log({
      userId: user.id,
      action: 'updateTransaction',
      targetEntityId: res.id,
    });

    return res;
  }

  @Delete(':id')
  async delete(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const user = req.user as SessionPayloadDto;
    const res = await this.transactionService.delete(id, user);

    if (res) {
      await this.log({
        userId: user.id,
        action: 'deleteTransaction',
        targetEntityId: id,
      });
    }

    return res;
  }

  @UseGuards(new RolesGuard(UserRole.admin))
  @Post(':id')
  async restore(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const res = await this.transactionService.restore(id);

    await this.log({
      userId: (req.user as SessionPayloadDto).id,
      action: 'restoreTransaction',
      targetEntityId: id,
    });

    return res;
  }

  async log(
    logDto: Omit<
      LogEntryCreateDto<typeof transactionsModuleActions>,
      'moduleName' | 'resourceAffected' | 'jsonPayload'
    >,
  ): Promise<void> {
    const dto: LogEntryCreateDto<any> = {
      moduleName: 'transactions',
      resourceAffected: 'transaction',
      ...logDto,
    };

    return this.logger.log(dto);
  }
}

const transactionsModuleActions = [
  'createTransaction',
  'deleteTransaction',
  'updateTransaction',
  'restoreTransaction',
] as const;
