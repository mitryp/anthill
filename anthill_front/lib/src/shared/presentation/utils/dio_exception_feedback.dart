import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart';

import '../../../modules/auth/application/providers/auth_provider.dart';
import '../../domain/dtos/server_error_dto.dart';
import '../../typedefs.dart';
import '../widgets/snack_bar_content.dart';

void provideExceptionFeedback(DioException error, BuildContext context) {
  final statusCode = error.response?.statusCode;

  if (statusCode == null) {
    return;
  }

  if (statusCode == HttpStatus.unauthorized) {
    ProviderScope.containerOf(context).invalidate(authProvider);
  }

  final data = error.response?.data;

  if (data is! JsonMap) {
    return;
  }

  final messageField = data['message'];
  if (messageField is List) {
    data['message'] = messageField.join('\n');
  }

  final errorDto = ServerErrorDto.fromJson(data);

  showSnackBar(
    context,
    title: Text(
      '${errorDto.statusCode} '
      '${errorDto.error?.isNotEmpty ?? false ? errorDto.error : ''}',
    ),
    subtitle: Text(errorDto.message),
    backgroundColor: Colors.red.shade200,
  );
}
