import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../application/providers/auth_provider.dart';
import 'constraints/app_page.dart';

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    initialLocation: defaultPage.location,
    redirect: (context, state) {
      final container = ProviderScope.containerOf(context);
      final isAuthorized = container.read(authProvider).requireValue;

      if (!isAuthorized) {
        return '/login';
      }

      return null;
    },
    routes: [
      for (final page in AppPage.values)
        GoRoute(
          path: page.location,
          name: page.name,
          builder: page.pageBuilder,
        ),
    ],
  );
}
