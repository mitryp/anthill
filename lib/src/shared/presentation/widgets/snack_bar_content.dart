import 'package:flutter/material.dart';

class SnackBarContent extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Color backgroundColor;
  final Color? textColor;

  const SnackBarContent({
    required this.title,
    this.subtitle,
    required this.backgroundColor,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = DefaultTextStyle.of(context).style;

    final subtitle = this.subtitle;

    return DefaultTextStyle(
      style: textStyle.copyWith(
        color: textColor,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        title: DefaultTextStyle(
          style: textTheme.titleMedium!,
          child: title,
        ),
        subtitle: subtitle != null
            ? DefaultTextStyle(
                style: textTheme.labelLarge!,
                child: subtitle,
              )
            : null,
        tileColor: backgroundColor,
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSnackBar(
  BuildContext context, {
  required Widget title,
  Widget? subtitle,
  required Color backgroundColor,
  Color? textColor,
}) {
  if (!context.mounted) return null;

  return ScaffoldMessenger.maybeOf(context)?.showSnackBar(
    SnackBar(
      padding: EdgeInsets.zero,
      content: SnackBarContent(
        title: title,
        subtitle: subtitle,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    ),
  );
}
