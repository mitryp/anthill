import 'package:flutter/material.dart';

class SingleModelControls extends StatelessWidget {
  final bool showEditButton;
  final VoidCallback? onEditPressed;
  final bool showDeleteButton;
  final VoidCallback? onDeletePressed;
  final double overflowSpacing;
  final double controlsSeparation;

  const SingleModelControls({
    this.showEditButton = true,
    this.onEditPressed,
    this.showDeleteButton = true,
    this.onDeletePressed,
    this.overflowSpacing = 8.0,
    this.controlsSeparation = 32.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      overflowAlignment: OverflowBarAlignment.center,
      overflowSpacing: overflowSpacing,
      children: [
        if (showDeleteButton)
          OutlinedButton.icon(
            onPressed: onDeletePressed?.call,
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.disabled)) return null;
                  return Colors.red[400];
                },
              ),
            ),
          ),
        if (showDeleteButton && showEditButton)
          SizedBox(
            width: controlsSeparation,
          ),
        if (showEditButton)
          ElevatedButton.icon(
            onPressed: onEditPressed?.call,
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
          ),
      ],
    );
  }
}
