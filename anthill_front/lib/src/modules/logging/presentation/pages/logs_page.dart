import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/pagination.dart';
import '../../../../shared/presentation/widgets/page_title.dart';
import '../../../../shared/widgets.dart';
import '../../application/providers/logging_service_provider.dart';
import '../../application/providers/logs_provider.dart';
import '../../application/services/logging_service.dart';
import '../../domain/dtos/log_entry_read_dto.dart';
import '../log_entry_tile.dart';

class LogsPage extends StatelessWidget {
  final QueryParams _queryParams;

  const LogsPage({QueryParams params = const {}, super.key}) : _queryParams = params;

  static Widget pageBuilder(BuildContext _, GoRouterState state) {
    final params = state.uri.queryParametersAll.normalize();

    return PageTitle(
      title: 'Logs',
      child: LogsPage(params: params),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
        actions: [CopyLinkButton.fromProvider()],
      ),
      body: PageBody(
        child: PaginatedCollectionView<LogEntryReadDto>(
          queryParams: _queryParams,
          httpServiceProvider: loggingServiceProvider,
          collectionProvider: logsProvider,
          collectionName: logsResourceName,
          showSearch: false,
          viewBuilder: (context, logs) {
            return ListView.builder(
              shrinkWrap: false,
              itemCount: logs.data.length,
              itemBuilder: (context, index) => LogEntryTile(logEntry: logs.data[index]),
            );
          },
        ),
      ),
    );
  }
}
