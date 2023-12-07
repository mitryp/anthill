import 'package:go_router/go_router.dart';

import 'dashboard.dart';

final router = GoRouter(
  // todo init
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const Dashboard(),
    ),
  ],
);
