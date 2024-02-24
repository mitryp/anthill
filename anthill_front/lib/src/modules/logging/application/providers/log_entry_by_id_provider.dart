import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/application/http/invalidate_on_error.dart';
import '../../domain/dtos/log_entry_read_dto.dart';
import 'logging_service_provider.dart';

part 'log_entry_by_id_provider.g.dart';

@riverpod
Future<LogEntryReadDto> logEntryById(LogEntryByIdRef ref, int id) =>
    ref.watch(loggingServiceProvider).getOne(id).invalidateOnError(ref);
