import { readFileSync } from 'fs';
import { load } from 'js-yaml';
import { resolve } from 'path';
import * as process from 'process';
import { registerAs } from '@nestjs/config';
import { dataSourceOptions } from './typeorm.config';

export const environmentConfigFactory = () => {
  const envName = process.env.NODE_ENV || 'development';

  return {
    env: envName,
  };
};

// A function that registers environment variables for http block ensuring that it has correct
// structure.
export const envHttpConfigFactory = registerAs('http', () => ({
  host: process.env.HOST,
  port: process.env.PORT,
  staticPath: process.env.STATIC_PATH,
}));

// A function that registers environment variables for database block ensuring it has correct
// structure.
export const envDatabaseConfigFactory = registerAs('database', () => dataSourceOptions);

export const envAuthConfigFactory = registerAs('auth', () => ({
  saltRounds: process.env.SALT_ROUNDS,

}));

export const commonConfigFactory = () => loadConfigYaml('common');

// Returns the record with the yaml file with the specified configuration name.
// If no such file exists, or the error occurred, returns an empty object.
function loadConfigYaml(cfgName: string): Record<string, any> {
  const path = resolve(`config/${cfgName}.yaml`);

  try {
    return load(readFileSync(path, { encoding: 'utf8' })) as Record<string, any>;
  } catch (_) {
    return {};
  }
}
