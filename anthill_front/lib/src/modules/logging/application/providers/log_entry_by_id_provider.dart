import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/http.dart';
import '../../domain/dtos/log_entry_read_dto.dart';
import 'logging_service_provider.dart';

part 'log_entry_by_id_provider.g.dart';

@riverpod
Future<LogEntryReadDto> logEntryById(
  LogEntryByIdRef ref,
  int id, [
  BuildContext? context,
]) =>
    ref.watch(loggingServiceProvider).getOne(id).onError(
          (error, stackTrace) => interceptDioError(error, stackTrace, context: context),
          test: isDioError,
        );
