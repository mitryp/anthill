import 'package:go_router/go_router.dart';

import 'constraints/app_page.dart';

final router = GoRouter(
  // todo init
  initialLocation: '/dashboard',
  routes: [
    for (final page in AppPage.values)
      GoRoute(
        path: page.location,
        name: page.name,
        builder: page.pageBuilder,
      ),
  ],
);
