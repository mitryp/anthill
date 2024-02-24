import 'package:flutter_riverpod/flutter_riverpod.dart';

extension InvalidateOnError<T> on Future<T> {
  Future<T> invalidateOnError(Ref ref) => catchError((error, _) {
        ref.invalidateSelf();
        throw error;
      });
}
