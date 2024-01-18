import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:universal_html/html.dart';

import '../../application/http/dio_error_interceptor.dart';
import '../../application/http/http_service.dart';
import '../../application/providers/paginate_config_provider.dart';
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
  late QueryParams _lastParams = queryParams;

  /// Initial filters for the controller to be initialized with.
  ///
  /// If the restored controller already has the filter by a field, the respective operators from
  /// this Map will not be applied.
  @visibleForOverriding
  Map<String, Set<FilterOperator>> get initialFilters => {};

  /// The collection name which will be used to fetch the [PaginateConfig].
  /// Has to be the same as apiPrefix of HttpService descendants.
  @visibleForOverriding
  String get collectionName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isControllerInitialized) _loadConfig();
  }

  @override
  void didUpdateWidget(W oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!isControllerInitialized) return;

    final newParams = queryParams;
    if (_lastParams != newParams) {
      controller.apply(newParams);
      _lastParams = newParams;
    }
  }

  Future<void> _loadConfig() async {
    final config = await ref.watch(paginateConfigProvider(collectionName).future).onError(
          (error, stackTrace) => interceptDioError(
            error,
            stackTrace,
            context: context,
            returnValue: const PaginateConfig(),
          ),
          test: isDioError,
        );

    _initController(config, queryParams);
    _lastParams = controller.toMap();
  }

  void _initController(PaginateConfig config, [QueryParams params = const {}]) {
    if (!mounted || isControllerInitialized) return;

    try {
      controller = restoreController(params, paginateConfig: config);
    } catch (_) {
      controller = PaginationController(paginateConfig: config);
    }
    // add initial filters
    final presentFilters = controller.filters;
    controller.silently((controller) {
      for (final MapEntry(key: field, value: filters) in initialFilters.entries) {
        for (final filter in filters) {
          if (presentFilters.containsKey(field)) return;
          controller.addFilter(field, filter);
        }
      }
    });

    controller.addListener(_updateUri);
    _updateUri();

    setState(() => isControllerInitialized = true);
  }

  @override
  void dispose() {
    super.dispose();

    if (isControllerInitialized) {
      controller.removeListener(_updateUri);
    }

    controller.dispose();
  }

  /// Updates a browser URI with query params of the [controller].
  void _updateUri() {
    if (!mounted) return;

    final state = GoRouterState.of(context);
    final uri = state.uri.cleanWithParams(
      controller.toMap().cast<String, Object>()..remove('limit'),
    );
    window.history.replaceState(null, '', '#$uri');
  }
}
