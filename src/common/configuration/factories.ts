import { readFileSync } from 'fs';
import { load } from 'js-yaml';
import { resolve } from 'path';

export const environmentConfigFactory = () => {
  const envName = process.env.NODE_ENV || 'development';

  return {
    ...loadConfigYaml(envName),
    env: envName,
  };
};

export const commonConfigFactory = () => loadConfigYaml('common');

// Returns the record with the yaml file with the specified configuration name.
function loadConfigYaml(cfgName: string): Record<string, any> {
  const path = resolve(`config/${cfgName}.yaml`);

  return load(readFileSync(path, { encoding: 'utf8' })) as Record<string, any>;
}
