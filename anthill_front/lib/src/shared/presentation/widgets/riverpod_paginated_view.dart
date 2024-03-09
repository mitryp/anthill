import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/interfaces/model.dart';
import '../utils/dio_exception_feedback.dart';

class RiverpodPaginatedView<TModel extends Model> extends ConsumerStatefulWidget {
  final PaginationController controller;
  final ErrorBuilder errorBuilder;
  final PaginatedViewBuilder<TModel> viewBuilder;
  final WidgetBuilder loadingIndicator;
  final AutoDisposeFutureProvider<Paginated<TModel>> Function(QueryParams params)
      collectionProvider;
  final VoidCallback? onUpdateRequest;
  final ValueChanged<Paginated<TModel>>? onDataLoaded;

  const RiverpodPaginatedView({
    required this.controller,
    required this.errorBuilder,
    required this.loadingIndicator,
    required this.viewBuilder,
    required this.collectionProvider,
    this.onUpdateRequest,
    this.onDataLoaded,
    super.key,
  });

  @override
  ConsumerState<RiverpodPaginatedView<TModel>> createState() =>
      _RiverpodPaginatedViewState<TModel>();
}

class _RiverpodPaginatedViewState<TModel extends Model>
    extends ConsumerState<RiverpodPaginatedView<TModel>> {
  late QueryParams _params;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_updateData);
    _params = widget.controller.toMap();
    _updateData();
  }

  @override
  void didUpdateWidget(covariant RiverpodPaginatedView<TModel> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_updateData);
      widget.controller.addListener(_updateData);
      _updateData();
    }
  }

  @override
  void dispose() {
    super.dispose();

    widget.controller.removeListener(_updateData);
  }

  Future<void> _updateData() async {
    if (!mounted) return;

    setState(() => _params = widget.controller.toMap());
  }

  void _deferCallback(void Function() fn) =>
      WidgetsBinding.instance.addPostFrameCallback((_) => fn());

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(widget.collectionProvider(_params));

    // generally speaking, putting callbacks in the build
    // method is not what you would want to do

    return value.when(
      data: (data) {
        _deferCallback(() => widget.onDataLoaded?.call(data));
        return widget.viewBuilder(context, data);
      },
      error: (error, _) {
        if (error is DioException) {
          _deferCallback(() => provideExceptionFeedback(error, context));
        }

        return widget.errorBuilder(context, error);
      },
      loading: () {
        _deferCallback(() => widget.onUpdateRequest?.call());
        return widget.loadingIndicator(context);
      },
    );
  }
}
