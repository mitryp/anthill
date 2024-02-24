import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/invalidate_on_error.dart';
import '../../domain/dtos/log_entry_read_dto.dart';
import 'logging_service_provider.dart';

part 'logs_provider.g.dart';

@riverpod
Future<Paginated<LogEntryReadDto>> logs(LogsRef ref, QueryParams params) =>
    ref.watch(loggingServiceProvider).getMany(params).invalidateOnError(ref);
