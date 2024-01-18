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
import { JwtPayloadDto } from '../auth/data/dtos/jwt.payload.dto';
import { Request } from 'express';
import { LoggingService } from '../logging/logging.service';
import { LogEntryCreateDto } from '../logging/data/dtos/log-entry.create.dto';
import { RequireRoles } from '../auth/roles_guard/require-roles.decorator';
import { UserRole } from '../users/data/entities/user.entity';

@ApiTags('Transactions')
@Controller('transactions')
export class TransactionsController {
  constructor(
    private readonly transactionService: TransactionsService,
    private readonly logger: LoggingService,
  ) {}

  @Get('/paginate_config')
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
    const userId = (req.user as JwtPayloadDto).id;

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
    const res = await this.transactionService.update(id, transaction);

    await this.log({
      userId: (req.user as JwtPayloadDto).id,
      action: 'updateTransaction',
      targetEntityId: res.id,
    });

    return res;
  }

  @Delete(':id')
  async delete(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const res = await this.transactionService.delete(id);

    if (res) {
      await this.log({
        userId: (req.user as JwtPayloadDto).id,
        action: 'deleteTransaction',
        targetEntityId: id,
      });
    }

    return res;
  }

  @RequireRoles([UserRole.admin])
  @Post(':id')
  async restore(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const res = await this.transactionService.restore(id);

    await this.log({
      userId: (req.user as JwtPayloadDto).id,
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
