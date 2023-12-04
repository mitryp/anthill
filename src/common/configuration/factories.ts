import { readFileSync } from 'fs';
import { load } from 'js-yaml';
import { resolve } from 'path';
import * as process from 'process';
import { registerAs } from '@nestjs/config';

export const environmentConfigFactory = () => {
  const envName = process.env.NODE_ENV || 'development';

  return {
    ...loadConfigYaml(envName),
    env: envName,
  };
};

// A function that copies all variables containing `__` as they contained dots instead.
// This is required to support both YAML and ENV configurations, as ENVs do not support dots.
export const yamlEnvHttpConfigFactory = registerAs('http', () => ({
  host: process.env.HOST,
  port: process.env.PORT,
  staticPath: process.env.STATIC_PATH,
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
