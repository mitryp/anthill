import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart';

// the first provider request is not a retry, so to get the maximum
// of 3 requests, set the number of retries to 2
const _maxRetries = 2;
final Map<Ref, int> _invalidateCounts = {};

extension InvalidateOnError<T> on Future<T> {
  /// Invalidates the provider of the [ref] if this Future throws a [DioException].
  ///
  /// It will not invalidate when the exception thrown is due to the [HttpStatus.forbidden] status
  /// code received.
  Future<T> invalidateOnHttpError(Ref ref, {int maxRetries = _maxRetries}) {
    ref.onDispose(() => _invalidateCounts.remove(ref));

    return catchError(
      (error, _) {
        ref.invalidateSelf();
        _invalidateCounts[ref] = (_invalidateCounts[ref] ?? 0) + 1;

        throw error;
      },
      test: (error) =>
          error is DioException &&
          !error.isForbiddenError &&
          (_invalidateCounts[ref] ?? 0) < maxRetries,
    );
  }
}

extension _IsForbidden on DioException {
  bool get isForbiddenError => response?.statusCode == HttpStatus.forbidden;
}
