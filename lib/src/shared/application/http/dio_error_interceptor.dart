import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/dtos/server_error_dto.dart';
import '../../presentation/widgets/snack_bar_content.dart';
import '../../typedefs.dart';

bool isDioError(Object error) => error is DioException;

Future<R> interceptDioError<R>(
  Object? error,
  StackTrace stackTrace, {
  BuildContext? context,
  R? returnValue,
}) async {
  assert(error is DioException);
  error = error as DioException;

  if (context != null) {
    final data = error.response?.data;

    if (data != null && data is JsonMap) {
      final messageField = data['message'];
      if (messageField is List) {
        data['message'] = messageField.join('\n');
      }

      final errorDto = ServerErrorDto.fromJson(data);

      showSnackBar(
        context,
        title: Text(
            '${errorDto.statusCode} ${errorDto.error?.isNotEmpty ?? false ? errorDto.error : ''}'),
        subtitle: Text(errorDto.message),
        backgroundColor: Colors.red.shade200,
      );
    }
  }

  if (returnValue != null) {
    return returnValue;
  }

  throw error;
}
