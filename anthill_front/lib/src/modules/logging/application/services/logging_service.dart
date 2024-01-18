import '../../../../shared/http.dart';
import '../../domain/dtos/log_entry_read_dto.dart';

const logsResourceName = 'logs';

class LoggingService extends HttpService<LogEntryReadDto> {
  const LoggingService({required super.client})
      : super(
          apiPrefix: logsResourceName,
          decoder: LogEntryReadDto.fromJson,
        );
}
