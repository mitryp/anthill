import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_notice.dart';

Widget? switchSingleModelValue(
  AsyncValue value, {
  required BuildContext context,
  ErrorBuilder? errorBuilder,
  WidgetBuilder? loadingBuilder,
}) =>
    switch (value) {
      AsyncError(:final error) => errorBuilder?.call(context, error) ??
          ErrorNotice(
            error: error,
            withScaffold: true,
          ),
      AsyncLoading() => loadingBuilder?.call(context) ??
          Scaffold(
            appBar: AppBar(title: const Text('Loading')),
            body: const Center(child: CircularProgressIndicator()),
          ),
      _ => null,
    };
