import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

void _defaultCallback() {}

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLocked;

  const PaginationControls({
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
    this.isLocked = false,
    super.key,
  });

  factory PaginationControls.fromMetadata(
    PaginatedMetadata meta, {
    VoidCallback onNext = _defaultCallback,
    VoidCallback onPrevious = _defaultCallback,
    bool isLocked = false,
  }) =>
      PaginationControls(
        currentPage: meta.currentPage,
        totalPages: meta.totalPages,
        onNext: onNext,
        onPrevious: onPrevious,
        isLocked: isLocked,
      );

  PaginationControls bind(PaginationController controller) => PaginationControls(
        currentPage: currentPage,
        totalPages: totalPages,
        isLocked: isLocked,
        onNext: () => controller.page++,
        onPrevious: () => controller.page--,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: isLocked || currentPage <= 1 ? null : onPrevious,
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        Text('$currentPage'),
        IconButton(
          onPressed: isLocked || currentPage >= totalPages ? null : onNext,
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
