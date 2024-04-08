import 'package:flutter/material.dart';

import '../../../config.dart';
import '../../widgets.dart';

class ErrorNotice extends StatelessWidget {
  final Object? error;
  final bool _withScaffold;

  const ErrorNotice({this.error, bool withScaffold = false, super.key})
      : _withScaffold = withScaffold;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    final err = Center(
      child: Text(
        env == 'production' ? locale.errorNoticeErrorMessage : error.toString(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (!_withScaffold) {
      return err;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.errorNoticeTitle),
      ),
      body: err,
    );
  }
}
