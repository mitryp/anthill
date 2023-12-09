import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'constraints/app_page.dart';

GoRouter buildRouter(BuildContext context) {
  return GoRouter(
    // todo init
    initialLocation: defaultPage.location,
    redirect: (context, state) {
      // todo redirect to login
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
