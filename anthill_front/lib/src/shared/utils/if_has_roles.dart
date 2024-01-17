import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/auth/auth_module.dart';
import '../../modules/users/users_module.dart';

/// Returns the value of [then] if the current user has one of the given [roles].
/// Otherwise, returns [orElse].
///
/// If the user is not initialized yet, will return [orElse].
T? ifHasRoles<T extends Object>(
  BuildContext context, {
  required Set<UserRole> roles,
  required T then,
  T? orElse,
}) {
  final userRole = ProviderScope.containerOf(context).read(authProvider).value?.role;

  if (roles.contains(userRole)) {
    return then;
  }

  return orElse;
}
