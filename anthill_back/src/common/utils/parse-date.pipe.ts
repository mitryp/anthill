import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';

const dateRegex = /^(2\d\d\d)-(\d\d)-(\d\d)$/;

@Injectable()
export class ParseDatePipe implements PipeTransform<string, Date> {
  transform(value: string): Date {
    if (!value) {
      throw new BadRequestException(null, 'No date was provided');
    }

    const match = value.match(dateRegex);

    if (!match) {
      throw new BadRequestException(null, 'Incorrect date format in query param');
    }

    const intValues = match.slice(1).map((el) => parseInt(el));

    console.log(intValues);

    if (intValues.some(isNaN)) {
      throw new BadRequestException(null, 'Incorrect date format in query param');
    }

    return new Date(intValues[0], intValues[1] - 1, intValues[2]);
  }
}
