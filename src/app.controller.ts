import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getLifespan(): string {
    return `The app is active for ${this.appService.getCurrentLifespanSec()} seconds.`;
  }
}
