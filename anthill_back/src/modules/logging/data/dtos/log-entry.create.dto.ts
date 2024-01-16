import { AutoMap } from 'automapper-classes';

// An internal dto used to create a log entry.
// <br>
// The TActions generic is specific to a module and defines a set of possible
// action name for a module to report.
// The TPayload generic defines a module-specific JSON payload interface.
export class LogEntryCreateDto<
  TActions extends readonly string[],
  TPayload extends object = object,
> {
  userId: number;

  @AutoMap()
  action: TActions[number];

  @AutoMap()
  moduleName: string;

  @AutoMap()
  resourceAffected?: string;

  @AutoMap()
  targetEntityId?: number;

  @AutoMap()
  jsonPayload?: TPayload;
}
