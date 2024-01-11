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
import { ApiTags } from '@nestjs/swagger';
import { usersPaginateConfig, UsersService } from './users.service';
import { transactionsPaginateConfig } from '../transactions/transactions.service';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { UserReadDto } from './data/dtos/user.read.dto';
import { User } from './data/entities/user.entity';
import { UserCreateDto } from './data/dtos/user.create.dto';
import { UserUpdateDto } from './data/dtos/user.update.dto';
import { AuthenticationService } from '../auth/authentication.service';

@ApiTags('Users')
@Controller('users')
export class UsersController {
  constructor(protected readonly usersService: UsersService) {}

  @Get('/paginate_config')
  readPaginateConfig(): PaginateConfig<User> {
    return usersPaginateConfig;
  }

  @Get()
  @PaginatedSwaggerDocs(UserReadDto, transactionsPaginateConfig)
  async readAll(@Paginate() query: PaginateQuery): Promise<ReadManyDto<UserReadDto>> {
    return this.usersService.readAll(query);
  }

  @Get(':id')
  async readOne(@Param('id') id: number): Promise<UserReadDto> {
    const user = await this.usersService.readOne(id);

    if (!user) {
      throw new NotFoundException();
    }

    return user;
  }

  @Post()
  async create(@Body() user: UserCreateDto): Promise<UserReadDto> {
    return this.usersService.create(user);
  }

  @Patch(':id')
  async update(@Param('id') id: number, @Body() user: UserUpdateDto): Promise<UserReadDto> {
    return this.usersService.update(id, user);
  }

  @Delete(':id')
  delete(@Param('id') id: number): Promise<boolean> {
    return this.usersService.delete(id);
  }
}
