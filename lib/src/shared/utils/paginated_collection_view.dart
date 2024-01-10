import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/http/http_service.dart';
import '../domain/interfaces/model.dart';
import '../presentation/utils/has_pagination_controller_mixin.dart';
import '../presentation/widgets/error_notice.dart';
import '../presentation/widgets/page_base.dart';
import '../presentation/widgets/pagination_controls.dart';
import '../presentation/widgets/riverpod_paginated_view.dart';
import 'pagination_control_row.dart';

typedef PaginatedCollectionProvider<TRead extends Model>
    = AutoDisposeFutureProvider<Paginated<TRead>> Function([QueryParams]);

class PaginatedCollectionView<TRead extends Model> extends ConsumerStatefulWidget {
  final QueryParams _queryParams;
  final ProviderBase<HttpService> _httpServiceProvider;
  final PaginatedCollectionProvider<TRead> _collectionProvider;
  final PaginatedViewBuilder<TRead> _viewBuilder;
  final WidgetBuilder? _loadingIndicator;
  final ErrorBuilder? _errorBuilder;

  const PaginatedCollectionView({
    required ProviderBase<HttpService> httpServiceProvider,
    required PaginatedCollectionProvider<TRead> collectionProvider,
    required PaginatedViewBuilder<TRead> viewBuilder,
    WidgetBuilder? loadingIndicator,
    ErrorBuilder? errorBuilder,
    QueryParams queryParams = const {},
    super.key,
  })  : _httpServiceProvider = httpServiceProvider,
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
  Widget build(BuildContext context) {
    final loadingIndicator = widget._loadingIndicator ??
        (BuildContext context) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            );

    if (!isControllerInitialized) {
      return loadingIndicator(context);
    }

    final meta = _meta;

    return PageBody(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            child: PaginationControlRow(
              controller: controller,
              isLocked: _areControlsLocked,
            ),
          ),
          Expanded(
            child: RiverpodPaginatedView<TRead>(
              controller: controller,
              collectionProvider: widget._collectionProvider,
              onDataLoaded: (value) {
                if (!mounted) return;

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
      ),
    );
  }
}
