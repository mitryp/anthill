import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/auth_provider.dart';

class Loader extends ConsumerWidget {
  final Widget child;

  const Loader({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(authProvider);

    return switch (value) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      _ => child,
    };
  }
}
