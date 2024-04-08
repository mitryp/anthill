import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../modules/auth/auth_module.dart';
import '../../navigation.dart';
import '../../widgets.dart';
import '../widgets/page_title.dart';

const _colors = [
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.deepPurple,
  Colors.red,
];

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static Widget pageBuilder(BuildContext context, GoRouterState __) => PageTitle(
        title: context.locale.pageTitleDashboard,
        child: const DashboardPage(),
      );

  @override
  Widget build(BuildContext context) {
    const maxExtent = 240.0;
    const padding = 8.0;
    const buttonRatio = 2 / 1;

    final theme = Theme.of(context);
    final locale = context.locale;

    final tileDestinations =
        Destination.values.where((dest) => dest.isShownAtDashboard).toList(growable: false);

    final greeting = Consumer(
      builder: (context, ref, child) {
        final user = ref.watch(authProvider).value;
        if (user == null) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            locale.dashboardGreeting(user.name),
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(title: Text(locale.pageTitleDashboard)),
      body: Padding(
        padding: const EdgeInsets.all(padding),
        child: PageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              greeting,
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '${locale.dashboardShortcutsTitle}:',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              GridView.extent(
                shrinkWrap: true,
                mainAxisSpacing: padding,
                crossAxisSpacing: padding,
                childAspectRatio: buttonRatio,
                maxCrossAxisExtent: maxExtent,
                children: [
                  for (var i = 0; i < tileDestinations.length; i++)
                    (() {
                      final dest = tileDestinations[i];

                      return ElevatedButton.icon(
                        onPressed: () => context.goPage(dest.page),
                        icon: Icon(dest.icon),
                        label: Text(
                          dest.localize(context),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(_colors[i % _colors.length]),
                        ),
                      );
                    })(),
                  Consumer(
                    builder: (context, ref, _) => ProgressIndicatorButton.icon(
                      iconButtonBuilder: OutlinedButton.icon,
                      onPressed: ref.read(authProvider.notifier).logoff,
                      icon: const Icon(Icons.logout),
                      label: Text(locale.logoutButtonLabel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
