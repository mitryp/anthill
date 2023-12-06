import { Body, Controller, Get, NotFoundException, Post, Query } from '@nestjs/common';
import { TransactionsService } from './transactions.service';
import { TransactionReadDto } from './data/dtos/transaction.read.dto';
import { TransactionCreateDto } from './data/dtos/transaction.create.dto';

@Controller('transactions')
export class TransactionsController {
  constructor(private readonly transactionService: TransactionsService) {}

  @Get('')
  async readAll(): Promise<TransactionReadDto[]> {
    return this.transactionService.readAll();
  }

  @Get(':id')
  async readOne(@Query('id') id: number): Promise<TransactionReadDto> {
    const transaction = await this.transactionService.readOne(id);

    if (!transaction) {
      throw new NotFoundException();
    }

    return transaction;
  }

  @Post('')
  async create(@Body() transaction: TransactionCreateDto): Promise<TransactionReadDto> {
    return this.transactionService.create(transaction);
  }
}
