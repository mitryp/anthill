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

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                locale.dashboardGreeting(user.name),
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );

    return Scaffold(
      appBar: AppBar(title: greeting),
      body: Padding(
        padding: const EdgeInsets.all(padding),
        child: PageBody(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              GridView.extent(
                shrinkWrap: true,
                mainAxisSpacing: padding,
                crossAxisSpacing: padding,
                childAspectRatio: buttonRatio,
                maxCrossAxisExtent: maxExtent,
                children: [
                  for (var i = 0; i < tileDestinations.length; i++)
                    _DestinationButton(
                      destination: tileDestinations[i],
                      index: i,
                    ),
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
              const SizedBox(height: 144),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationButton extends StatelessWidget {
  final Destination destination;
  final int index;

  const _DestinationButton({
    required this.destination,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.goPage(destination.page),
      icon: Icon(destination.icon),
      label: Text(
        destination.localize(context),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        backgroundColor: MaterialStatePropertyAll(
          _colors[index % _colors.length],
        ),
      ),
    );
  }
}
