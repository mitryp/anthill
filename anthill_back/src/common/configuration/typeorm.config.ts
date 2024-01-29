import * as dotenv from 'dotenv';
import { DataSource, DataSourceOptions } from 'typeorm';

dotenv.config({ path: '.env' });

export const dataSourceOptions: DataSourceOptions = {
  type: 'postgres',
  database: process.env.DB,
  host: process.env.DB_HOST,
  port: +process.env.DB_PORT,
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  logging: true,
  entities: ['dist/**/*.entity.{js,ts}'],
  migrations: ['migrations/*.{js,ts}'],
  synchronize: false,
};

// noinspection JSUnusedGlobalSymbols
export const dataSource = new DataSource(dataSourceOptions);
