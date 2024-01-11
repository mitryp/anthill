import {
  Body,
  Controller,
  Delete,
  Get,
  NotFoundException,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { transactionsPaginateConfig, TransactionsService } from './transactions.service';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { TransactionCreateDto } from './data/dtos/transaction.create.dto';
import { TransactionUpdateDto } from './data/dtos/transaction.update.dto';
import { ApiTags } from '@nestjs/swagger';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { Transaction } from './data/entities/transaction.entity';

@ApiTags('Transactions')
@Controller('transactions')
export class TransactionsController {
  constructor(protected readonly transactionService: TransactionsService) {}

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
  async create(@Body() transaction: TransactionCreateDto): Promise<TransactionReadDto> {
    return this.transactionService.create(transaction);
  }

  @Patch(':id')
  async update(
    @Param('id') id: number,
    @Body() transaction: TransactionUpdateDto,
  ): Promise<TransactionReadDto> {
    return this.transactionService.update(id, transaction);
  }

  @Delete(':id')
  delete(@Param('id') id: number): Promise<boolean> {
    return this.transactionService.delete(id);
  }
}
