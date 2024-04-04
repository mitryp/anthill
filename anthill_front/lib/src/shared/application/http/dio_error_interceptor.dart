import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../presentation/utils/dio_exception_feedback.dart';

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
