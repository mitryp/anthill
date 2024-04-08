import 'package:flutter/material.dart';

import '../../typedefs.dart';
import '../../widgets.dart';

class SingleModelControls extends StatelessWidget {
  final bool showEditButton;
  final FutureVoidCallback? onEditPressed;
  final bool showDeleteButton;
  final FutureVoidCallback? onDeletePressed;
  final double overflowSpacing;
  final double controlsSeparation;
  final bool showRestoreButton;
  final FutureVoidCallback? onRestorePressed;

  const SingleModelControls({
    this.showEditButton = true,
    this.onEditPressed,
    this.showDeleteButton = true,
    this.onDeletePressed,
    this.showRestoreButton = true,
    this.onRestorePressed,
    this.overflowSpacing = 8.0,
    this.controlsSeparation = 32.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      spacing: overflowSpacing,
      runSpacing: MediaQuery.of(context).textScaleFactor * overflowSpacing,
      children: [
        if (showDeleteButton)
          ProgressIndicatorButton.icon(
            iconButtonBuilder: OutlinedButton.icon,
            onPressed: onDeletePressed?.call,
            label: Text(locale.modelControlsDeleteButtonLabel),
            icon: const Icon(Icons.delete),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.disabled)) return null;
                  return Colors.red[400];
                },
              ),
            ),
          ),
        if (showEditButton)
          ProgressIndicatorButton.icon(
            iconButtonBuilder: ElevatedButton.icon,
            onPressed: onEditPressed?.call,
            icon: const Icon(Icons.edit),
            label: Text(locale.modelControlsEditButtonLabel),
          ),
        if (showRestoreButton)
          ProgressIndicatorButton.icon(
            iconButtonBuilder: ElevatedButton.icon,
            onPressed: onRestorePressed,
            icon: const Icon(Icons.restore),
            label: Text(locale.modelControlsRestoreButtonLabel),
          ),
      ],
    );
  }
}
