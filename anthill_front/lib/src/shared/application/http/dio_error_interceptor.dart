import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart';

import '../../../modules/auth/auth_module.dart';
import '../../domain/dtos/server_error_dto.dart';
import '../../presentation/utils/dio_exception_feedback.dart';
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
    provideExceptionFeedback(error, context);
  }

  if (returnValue != null) {
    return returnValue;
  }

  throw error;
}
