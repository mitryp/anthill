import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Received } from './data/entities/received.entity';
import { Sent } from './data/entities/sent.entity';
import { ReceivedHumanitarianService } from './received.humanitarian.service';
import { SentHumanitarianService } from './sent.humanitarian.service';
import { ReceivedHumanitarianController } from './received.humanitarian.controller';
import { LoggingModule } from '../logging/logging.module';
import { HumanitarianMapper } from './data/humanitarian.mapper';
import { SentHumanitarianController } from './sent.humanitarian.controller';

@Module({
  imports: [TypeOrmModule.forFeature([Received, Sent]), LoggingModule],
  controllers: [ReceivedHumanitarianController, SentHumanitarianController],
  providers: [HumanitarianMapper, ReceivedHumanitarianService, SentHumanitarianService],
})
export class HumanitarianModule {}
