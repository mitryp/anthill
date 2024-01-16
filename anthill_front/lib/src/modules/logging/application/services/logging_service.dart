import '../../../../shared/http.dart';
import '../../domain/dtos/log_entry_read_dto.dart';

class LoggingService extends HttpService<LogEntryReadDto> {
  const LoggingService({required super.client})
      : super(
          apiPrefix: 'logs',
          decoder: LogEntryReadDto.fromJson,
        );
}
