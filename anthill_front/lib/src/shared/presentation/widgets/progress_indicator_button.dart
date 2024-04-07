import 'dart:async';

import 'package:flutter/material.dart';

import '../../typedefs.dart';

class ProgressIndicatorButton extends StatefulWidget {
  final FutureOr<void> Function()? onPressed;
  final ButtonBuilder buttonBuilder;
  final Widget child;
  final Widget? errorChild;
  final ButtonStyle? style;

  const ProgressIndicatorButton({
    required this.onPressed,
    required this.child,
    required this.buttonBuilder,
    this.errorChild,
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
  bool _hadError = false;

  Future<void> _onPressed() async {
    final onPressed = widget.onPressed;

    if (onPressed == null) {
      return;
    }

    setState(() => _isLoading = true);

    final isSuccessful =
        await Future(() => onPressed()).then((_) => true).onError((_, __) => false);

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
      _hadError = !isSuccessful;
    });
  }

  @override
  Widget build(BuildContext context) {
    late final colorScheme = Theme.of(context).colorScheme;

    final Widget child;

    if (_hadError) {
      child = Padding(
        padding: const EdgeInsets.all(2),
        child: widget.errorChild ?? const Icon(Icons.warning),
      );
    } else if (_isLoading) {
      child = SizedBox(
        height: 24,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(
              color: widget.style?.foregroundColor?.resolve({}) ?? colorScheme.onPrimary,
            ),
          ),
        ),
      );
    } else {
      child = widget.child;
    }

    return widget.buttonBuilder(
      style: ButtonStyle(
        foregroundColor: _hadError ? MaterialStatePropertyAll(colorScheme.onError) : null,
        backgroundColor: _hadError ? MaterialStatePropertyAll(colorScheme.error) : null,
      ).merge(widget.style),
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
