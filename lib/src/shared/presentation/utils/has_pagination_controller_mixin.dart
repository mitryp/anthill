import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../application/http/http_service.dart';
import '../../application/providers/paginate_config_provider.dart';
import '../../application/providers/shareable_url_provider.dart';
import '../../utils/clean_uri.dart';
import '../../utils/restore_pagination_controller.dart';

mixin HasPaginationController<W extends ConsumerStatefulWidget> on ConsumerState<W> {
  /// A [PaginationController] provided by a [HasPaginationController] mixin.
  ///
  /// You should never access the controller before [isControllerInitialized] is true.
  @protected
  late final PaginationController controller;

  /// Whether the [controller] field is initialized.
  ///
  /// You should never access the controller before the value of this field is true.
  @protected
  bool isControllerInitialized = false;

  /// A getter for [HttpService] of this collection view.
  ///
  /// Is used by [HasPaginationController] mixin to fetch the respective [PaginateConfig] to
  /// initialize the [controller] with.
  @visibleForOverriding
  ProviderBase<HttpService> get httpServiceProvider;

  /// A query parameters to be used to restore a [PaginationController].
  ///
  /// Will be used only once during the initialization.
  @visibleForOverriding
  QueryParams get queryParams => const {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isControllerInitialized) _loadConfig();
  }

  Future<void> _loadConfig() async {
    final config = await ref.watch(paginateConfigProvider(httpServiceProvider).future);
    _initController(config, queryParams);
  }

  void _initController(PaginateConfig config, [QueryParams params = const {}]) {
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

    controller.dispose();
  }

  /// Updates a [ShareableUrl] instance in the current scope with query params of the [controller].
  void _updateMemento() {
    final uri = GoRouterState.of(context).uri.cleanWithParams(
          controller.toMap().cast<String, Object>(),
        );

    ProviderScope.containerOf(context).read(shareableUrlProvider.notifier).set('$uri');
  }
}
