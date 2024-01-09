import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/shareable_url_provider.dart';
import '../../utils/clean_uri.dart';
import '../../utils/restore_pagination_controller.dart';

mixin HasPaginationController<W extends StatefulWidget> on State<W> {
  @protected
  late final PaginationController controller;

  @protected
  bool isControllerInitialized = false;

  @protected
  void initController(PaginateConfig config, [QueryParams params = const {}]) {
    if (!mounted || isControllerInitialized) return;

    controller = restoreController(params, paginateConfig: config);
    controller.addListener(_updateMemento);
    _updateMemento();

    setState(() => isControllerInitialized = true);
  }

  @override
  void dispose() {
    super.dispose();
    if (isControllerInitialized) {
      controller.removeListener(_updateMemento);
    }
  }

  void _updateMemento() {
    final uri = GoRouterState.of(context).uri.cleanWithParams(
          controller.toMap().cast<String, Object>(),
        );

    ProviderScope.containerOf(context).read(shareableUrlProvider.notifier).set('$uri');
  }
}
