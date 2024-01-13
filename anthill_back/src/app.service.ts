import { Injectable } from '@nestjs/common';

const msInSecond = 1000;

@Injectable()
export class AppService {
  private readonly createdAtMs: number;

  constructor() {
    this.createdAtMs = Date.now();
  }

  getCurrentLifespanSec(): number {
    return (Date.now() - this.createdAtMs) / msInSecond;
  }
}
