import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/dto/server_error_dto.dart';
import '../../presentation/widgets/snack_bar_content.dart';
import '../../typedefs.dart';

Future<R> interceptDioError<R>(Object? error, StackTrace stackTrace, [BuildContext? context]) {
  if (error is DioException && context != null) {
    final data = error.response?.data;

    if (data != null && data is JsonMap) {
      final messageField = data['message'];
      if (messageField is List) {
        data['message'] = messageField.join('\n');
      }

      final errorDto = ServerErrorDto.fromJson(data);

      showSnackBar(
        context,
        title: Text('${errorDto.statusCode} ${errorDto.error}'),
        subtitle: Text(errorDto.message),
        backgroundColor: Colors.red.shade200,
      );
    }
  }

  throw error ?? 'Something is terribly wrong';
}
