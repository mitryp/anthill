import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget title;
  final Widget? content;
  final Widget? confirmButtonLabel;
  final Widget confirmButtonIcon;
  final Widget? cancelButtonLabel;
  final Widget cancelButtonIcon;

  const ConfirmationDialog({
    required this.title,
    this.content,
    this.confirmButtonLabel,
    this.confirmButtonIcon = const Icon(Icons.check),
    this.cancelButtonLabel,
    this.cancelButtonIcon = const Icon(Icons.cancel_outlined),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // todo localize
    final confirmButtonLabel = this.confirmButtonLabel ?? const Text('OK');
    final cancelButtonLabel = this.cancelButtonLabel ?? const Text('Cancel');

    return AlertDialog(
      title: title,
      content: content,
      actions: [
        ElevatedButton.icon(
          onPressed: () => context.pop(true),
          icon: confirmButtonIcon,
          label: confirmButtonLabel,
        ),
        OutlinedButton.icon(
          onPressed: () => context.pop(false),
          icon: cancelButtonIcon,
          label: cancelButtonLabel,
        ),
      ],
    );
  }
}

Future<bool> askUserConfirmation(
  BuildContext context,
  Text prompt, {
  Text? content,
  Widget? confirmButtonLabel,
  Widget confirmButtonIcon = const Icon(Icons.check),
  Widget? cancelButtonLabel,
  Widget cancelButtonIcon = const Icon(Icons.cancel_outlined),
}) =>
    showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: prompt,
        content: content,
        cancelButtonLabel: cancelButtonLabel,
        cancelButtonIcon: cancelButtonIcon,
        confirmButtonIcon: confirmButtonIcon,
        confirmButtonLabel: confirmButtonLabel,
      ),
    ).then((value) => value ?? false);
