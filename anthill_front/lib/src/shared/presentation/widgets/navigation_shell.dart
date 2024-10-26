import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation.dart';
import '../../widgets.dart';

enum Destination {
  dashboard(
    AppPage.dashboard,
    icon: Icons.dashboard,
    isShownAtDashboard: false,
  ),
  transactions(
    AppPage.transactions,
    icon: Icons.attach_money,
  ),
  users(
    AppPage.users,
    icon: Icons.people,
    isShownInMobileNav: false,
  ),
  logs(
    AppPage.logs,
    icon: Icons.pending_actions,
  );

  final AppPage page;
  final IconData icon;
  final bool isShownAtDashboard;
  final bool isShownInMobileNav;

  const Destination(
    this.page, {
    required this.icon,
    this.isShownAtDashboard = true,
    this.isShownInMobileNav = true,
  });

  String localize(BuildContext context) {
    final locale = context.locale;

    return switch (this) {
      Destination.transactions => locale.pageTitleTransactions,
      Destination.users => locale.pageTitleUsers,
      Destination.logs => locale.pageTitleLogs,
      Destination.dashboard => locale.pageTitleDashboard,
    };
  }
}

class NavigationShell extends StatelessWidget {
  final Widget child;
  final GoRouterState state;
  final double mobileLayoutMaxWidth;

  const NavigationShell({
    required this.child,
    required this.state,
    this.mobileLayoutMaxWidth = 512.0,
    super.key,
  });

  void _onDestinationSelected({
    required BuildContext context,
    required int index,
    String? currentPath,
  }) {
    final dest = Destination.values[index];

    if (dest.page.location == currentPath) return;

    context.goPage(dest.page);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final path = state.fullPath;
    final selectedIndex = path != null
        ? Destination.values.indexWhere(
            (dest) => path.startsWith(dest.page.location),
          )
        : null;

    final useMobileNav = size.width < mobileLayoutMaxWidth;

    if (useMobileNav) {
      return _MobileNavigationShell(
        onDestinationSelected: (index) => _onDestinationSelected(
          context: context,
          index: index,
          currentPath: path,
        ),
        selectedIndex: selectedIndex ?? 0,
        child: child,
      );
    }

    return _DesktopNavigationShell(
      onDestinationSelected: (index) => _onDestinationSelected(
        context: context,
        index: index,
        currentPath: path,
      ),
      selectedIndex: selectedIndex != -1 ? selectedIndex : null,
      child: child,
    );
  }
}

class _DesktopNavigationShell extends StatelessWidget {
  final ValueChanged<int> _onDestinationSelected;
  final int? _selectedIndex;
  final Widget _child;

  const _DesktopNavigationShell({
    required void Function(int) onDestinationSelected,
    int? selectedIndex,
    required Widget child,
  })  : _child = child,
        _selectedIndex = selectedIndex,
        _onDestinationSelected = onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.selected,
            onDestinationSelected: _onDestinationSelected,
            destinations: [
              for (final dest in Destination.values)
                NavigationRailDestination(
                  icon: Icon(dest.icon),
                  label: Text(dest.localize(context)),
                ),
            ],
            selectedIndex: _selectedIndex,
          ),
          Expanded(child: _child),
        ],
      ),
    );
  }
}

class _MobileNavigationShell extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final Widget child;

  const _MobileNavigationShell({
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final mobileDestinations =
        Destination.values.where((dest) => dest.isShownInMobileNav).toList(growable: false);

    final selectedIndex = mobileDestinations.indexOf(Destination.values[this.selectedIndex]);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex != -1 ? selectedIndex : 0,
        onDestinationSelected: (index) => onDestinationSelected(mobileDestinations[index].index),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          for (var i = 0; i < mobileDestinations.length; i++)
            (() {
              final dest = mobileDestinations[i];
              return NavigationDestination(
                icon: Icon(dest.icon),
                label: dest.localize(context),
              );
            })(),
        ],
      ),
    );
  }
}
