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
import { ApiTags } from '@nestjs/swagger';
import { usersPaginateConfig, UsersService } from './users.service';
import { transactionsPaginateConfig } from '../transactions/transactions.service';
import { Paginate, PaginateConfig, PaginatedSwaggerDocs, PaginateQuery } from 'nestjs-paginate';
import { ReadManyDto } from '../../common/domain/read-many.dto';
import { UserReadDto } from './data/dtos/user.read.dto';
import { User, UserRole } from './data/entities/user.entity';
import { UserCreateDto } from './data/dtos/user.create.dto';
import { UserUpdateDto } from './data/dtos/user.update.dto';
import { LoggingService } from '../logging/logging.service';
import { LogEntryCreateDto } from '../logging/data/dtos/log-entry.create.dto';
import { Request } from 'express';
import { JwtPayloadDto } from '../auth/data/dtos/jwt.payload.dto';
import { RequireRoles } from '../auth/roles_guard/require-roles.decorator';

@ApiTags('Users')
@Controller('users')
export class UsersController {
  constructor(
    private readonly usersService: UsersService,
    private readonly logger: LoggingService,
  ) {}

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

  @RequireRoles([UserRole.admin])
  @Post()
  async create(@Body() user: UserCreateDto, @Req() req: Request): Promise<UserReadDto> {
    const res = await this.usersService.create(user);

    await this.log({
      userId: (req.user as JwtPayloadDto).id,
      action: 'createUser',
      targetEntityId: res.id,
    });

    return res;
  }

  @RequireRoles([UserRole.admin])
  @Patch(':id')
  async update(
    @Param('id') id: number,
    @Body() user: UserUpdateDto,
    @Req() req: Request,
  ): Promise<UserReadDto> {
    const res = await this.usersService.update(id, user);

    await this.log({
      userId: (req.user as JwtPayloadDto).id,
      action: 'updateUser',
      targetEntityId: res.id,
    });

    return res;
  }

  @RequireRoles([UserRole.admin])
  @Delete(':id')
  async delete(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const res = await this.usersService.delete(id);

    if (res) {
      await this.log({
        userId: (req.user as JwtPayloadDto).id,
        action: 'deleteUser',
        targetEntityId: id,
      });
    }

    return res;
  }

  @RequireRoles([UserRole.admin])
  @Post(':id')
  async restore(@Param('id') id: number, @Req() req: Request): Promise<boolean> {
    const res = await this.usersService.restore(id);

    await this.log({
      userId: (req.user as JwtPayloadDto).id,
      action: 'restoreUser',
      targetEntityId: id,
    });

    return res;
  }

  async log(
    logDto: Omit<
      LogEntryCreateDto<typeof usersModuleActions>,
      'moduleName' | 'resourceAffected' | 'jsonPayload'
    >,
  ): Promise<void> {
    const dto: LogEntryCreateDto<any> = {
      moduleName: 'users',
      resourceAffected: 'user',
      ...logDto,
    };

    return this.logger.log(dto);
  }
}

const usersModuleActions = [
  'createUser',
  'deleteUser',
  'updateUser',
  'restoreUser',
  //
] as const;
