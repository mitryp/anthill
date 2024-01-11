import { BaseExceptionFilter } from '@nestjs/core';
import { ArgumentsHost, BadRequestException, Catch } from '@nestjs/common';
import { QueryFailedError } from 'typeorm';

const errorCodeToMessage = {
  '23505': 'Unique constraint violation'
};

@Catch(QueryFailedError)
export class QueryFailFilter extends BaseExceptionFilter {
  catch(exception: QueryFailedError, host: ArgumentsHost) {
    const message = errorCodeToMessage[exception.driverError.code];

    super.catch(new BadRequestException(message ?? exception.message), host);
  }
}
