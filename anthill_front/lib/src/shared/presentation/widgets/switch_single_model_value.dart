import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets.dart';

Widget? switchSingleModelValue(
  AsyncValue value, {
  required BuildContext context,
  ErrorBuilder? errorBuilder,
  WidgetBuilder? loadingBuilder,
}) {
  if (kDebugMode && value is AsyncError) {
    final error = value.error;
    log('${error is Error ? error.stackTrace : error}');
  }

  return switch (value) {
    AsyncError(:final error) => errorBuilder?.call(context, error) ??
        ErrorNotice(
          error: error,
          withScaffold: true,
        ),
    AsyncLoading() => loadingBuilder?.call(context) ??
        Scaffold(
          appBar: AppBar(title: Text(context.locale.loadingPageTitle)),
          body: const Center(child: CircularProgressIndicator()),
        ),
    _ => null,
  };
}
