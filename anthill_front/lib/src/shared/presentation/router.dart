import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/auth_module.dart';
import 'constraints/app_page.dart';
import 'widgets/navigation_shell.dart';

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    initialLocation: defaultPage.location,
    redirect: (context, state) {
      final container = ProviderScope.containerOf(context);
      final user = container.read(authProvider);

      const loginLocation = '/login';

      return user.maybeWhen<String?>(
        data: (user) => user != null ? null : loginLocation,
        orElse: () => loginLocation,
      );
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => NavigationShell(state: state, child: child),
        routes: [
          for (final page in AppPage.values)
            GoRoute(
              path: page.location,
              name: page.name,
              builder: page.pageBuilder,
            ),
        ],
      ),
    ],
  );
}
