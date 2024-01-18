import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/http/http_service.dart';
import '../../domain/interfaces/model.dart';
import '../utils/has_pagination_controller.dart';
import 'error_notice.dart';
import 'pagination_control_row.dart';
import 'pagination_controls.dart';
import 'riverpod_paginated_view.dart';

typedef PaginatedCollectionProvider<TRead extends Model>
    = AutoDisposeFutureProvider<Paginated<TRead>> Function(QueryParams params);

class PaginatedCollectionView<TRead extends Model> extends ConsumerStatefulWidget {
  final QueryParams _queryParams;
  final ProviderBase<HttpService> _httpServiceProvider;
  final PaginatedCollectionProvider<TRead> _collectionProvider;
  final PaginatedViewBuilder<TRead> _viewBuilder;
  final WidgetBuilder? _loadingIndicator;
  final ErrorBuilder? _errorBuilder;

  final bool _showSearch;
  final bool _showSort;
  final Widget Function(PaginationController controller)? _additionalFiltersBuilder;

  final Map<String, Set<FilterOperator>> _initialFilters;

  const PaginatedCollectionView({
    required ProviderBase<HttpService> httpServiceProvider,
    required PaginatedCollectionProvider<TRead> collectionProvider,
    required PaginatedViewBuilder<TRead> viewBuilder,
    bool showSearch = true,
    bool showSort = true,
    Widget Function(PaginationController controller)? additionalFiltersBuilder,
    Map<String, Set<FilterOperator>> initialFilters = const {},
    WidgetBuilder? loadingIndicator,
    ErrorBuilder? errorBuilder,
    QueryParams queryParams = const {},
    super.key,
  })  : _initialFilters = initialFilters,
        _additionalFiltersBuilder = additionalFiltersBuilder,
        _showSort = showSort,
        _showSearch = showSearch,
        _httpServiceProvider = httpServiceProvider,
        _collectionProvider = collectionProvider,
        _viewBuilder = viewBuilder,
        _loadingIndicator = loadingIndicator,
        _errorBuilder = errorBuilder,
        _queryParams = queryParams;

  @override
  ConsumerState<PaginatedCollectionView<TRead>> createState() =>
      _PaginatedCollectionViewState<TRead>();
}

class _PaginatedCollectionViewState<TRead extends Model>
    extends ConsumerState<PaginatedCollectionView<TRead>> with HasPaginationController {
  /// A metadata cache for pagination controls.
  PaginatedMetadata? _meta;

  /// A flag to lock the pagination controls during the requests.
  bool _areControlsLocked = true;

  @override
  ProviderBase<HttpService> get httpServiceProvider => widget._httpServiceProvider;

  @override
  QueryParams get queryParams => widget._queryParams;

  @override
  Map<String, Set<FilterOperator>> get initialFilters => widget._initialFilters;

  @override
  Widget build(BuildContext context) {
    const controlsPadding = EdgeInsets.symmetric(horizontal: 4, vertical: 16);

    final loadingIndicator = widget._loadingIndicator ??
        (BuildContext context) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            );

    if (!isControllerInitialized) {
      return loadingIndicator(context);
    }

    final meta = _meta;
    final additionalFilters = widget._additionalFiltersBuilder;

    return Column(
      children: [
        Padding(
          padding: controlsPadding,
          child: PaginationControlRow(
            controller: controller,
            isLocked: _areControlsLocked,
            includeSearch: widget._showSearch,
            includeSort: widget._showSort,
          ),
        ),
        if (additionalFilters != null)
          Padding(
            padding: controlsPadding.copyWith(top: 0),
            child: additionalFilters(controller),
          ),
        Expanded(
          child: RiverpodPaginatedView<TRead>(
            controller: controller,
            collectionProvider: widget._collectionProvider,
            onDataLoaded: (value) {
              if (!mounted || (_meta == value.meta && !_areControlsLocked)) return;

              setState(() {
                _meta = value.meta;
                _areControlsLocked = false;
              });
            },
            onUpdateRequest: () {
              if (!_areControlsLocked) {
                setState(() => _areControlsLocked = true);
              }
            },
            viewBuilder: widget._viewBuilder,
            errorBuilder: widget._errorBuilder ?? (context, error) => ErrorNotice(error: error),
            loadingIndicator: loadingIndicator,
          ),
        ),
        if (meta != null)
          PaginationControls.fromMetadata(meta, isLocked: _areControlsLocked).bind(controller),
      ],
    );
  }
}
