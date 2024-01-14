import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/providers/auth_provider.dart';

class Loader extends ConsumerWidget {
  final Widget child;
  final Widget loginPage;

  const Loader({
    required this.child,
    required this.loginPage,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(authProvider);

    return switch (value) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncData(:final value) => value != null ? child : loginPage,
      _ => loginPage,
    };
  }
}
