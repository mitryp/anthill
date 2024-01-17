import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../users/users_module.dart';
import '../application/providers/auth_provider.dart';

/// A widget to hide its [child] when the current user does not have one of the required [roles].
/// In that case, the [unauthorizedPlaceholder] will be shown instead.
///
/// It utilizes riverpod and [authProvider] to get the current user.
/// If the user is not yet initialized, it will consider the user not authorized.
class VisibleFor extends ConsumerWidget {
  /// The set of [UserRole]s allowed to see the [child].
  final Set<UserRole> roles;

  /// The widget which should not be visible for roles not in the [roles] list.
  final Widget child;

  /// The placeholder widget to be shown when the current user is not allowed to see the [child].
  final Widget unauthorizedPlaceholder;

  const VisibleFor({
    required this.roles,
    required this.child,
    this.unauthorizedPlaceholder = const SizedBox(),
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider).value?.role;

    if (!roles.contains(role)) {
      return unauthorizedPlaceholder;
    }

    return child;
  }
}
