import 'dart:async';

import 'package:flutter/material.dart';

import '../../typedefs.dart';

class ProgressIndicatorButton extends StatefulWidget {
  final FutureOr<void> Function()? onPressed;
  final ButtonBuilder buttonBuilder;
  final Widget child;
  final ButtonStyle? style;

  const ProgressIndicatorButton({
    required this.onPressed,
    required this.child,
    required this.buttonBuilder,
    this.style,
    super.key,
  });

  factory ProgressIndicatorButton.icon({
    required FutureOr<void> Function()? onPressed,
    required Widget icon,
    required Widget label,
    required IconButtonBuilder iconButtonBuilder,
    ButtonStyle? style,
    Key? key,
  }) =>
      ProgressIndicatorButton(
        key: key,
        buttonBuilder: _iconButtonToButtonBuilderAdapter(iconButtonBuilder, icon),
        style: style,
        onPressed: onPressed,
        child: label,
      );

  @override
  State<ProgressIndicatorButton> createState() => _ProgressIndicatorButtonState();
}

class _ProgressIndicatorButtonState extends State<ProgressIndicatorButton> {
  bool _isLoading = false;

  Future<void> _onPressed() async {
    final onPressed = widget.onPressed;

    if (onPressed == null) {
      return;
    }

    setState(() => _isLoading = true);

    await onPressed();

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = _isLoading
        ? SizedBox(
            height: 24,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: AspectRatio(
                aspectRatio: 1,
                child: CircularProgressIndicator(
                  color: widget.style?.foregroundColor?.resolve({}) ??
                      Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          )
        : widget.child;

    return widget.buttonBuilder(
      style: widget.style,
      onPressed: widget.onPressed == null ? null : _onPressed,
      child: child,
    );
  }
}

ButtonBuilder _iconButtonToButtonBuilderAdapter(IconButtonBuilder iconButtonBuilder, Widget icon) {
  return ({required child, required onPressed, style}) => iconButtonBuilder(
        onPressed: onPressed,
        icon: icon,
        label: child,
        style: style,
      );
}
