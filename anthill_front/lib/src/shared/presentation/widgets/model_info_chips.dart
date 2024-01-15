import 'package:flutter/material.dart';

class ModelInfoChips extends StatelessWidget {
  final List<Widget> children;
  final double elementsSpacing;
  final EdgeInsetsGeometry? padding;

  const ModelInfoChips({
    required this.children,
    this.elementsSpacing = 8.0,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(elementsSpacing / 2),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: elementsSpacing,
        runSpacing: elementsSpacing,
        children: children,
      ),
    );
  }
}
