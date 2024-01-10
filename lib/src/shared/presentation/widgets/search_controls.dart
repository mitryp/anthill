import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

class SearchControls extends StatefulWidget {
  final PaginationController paginationController;
  final bool isLocked;
  final EdgeInsetsGeometry contentPadding;

  const SearchControls({
    required this.paginationController,
    this.isLocked = false,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12),
    super.key,
  });

  @override
  State<SearchControls> createState() => _SearchControlsState();
}

class _SearchControlsState extends State<SearchControls> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.paginationController.search != null ? '${widget.paginationController.search}' : '',
  );

  void _updateSearchQuery() =>
      widget.paginationController.search = _controller.text.isNotEmpty ? _controller.text : null;

  void _resetSearch() {
    widget.paginationController.search = null;
    _controller.clear();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = 16.0;

    return ListenableBuilder(
      listenable: widget.paginationController,
      builder: (context, _) => TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          // todo localize
          labelText: 'Search',
          contentPadding: widget.contentPadding,
          suffixIcon: _controller.text.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      splashRadius: iconSize,
                      onPressed: _resetSearch,
                      icon: const Icon(Icons.clear, size: iconSize),
                    ),
                    IconButton(
                      splashRadius: iconSize,
                      onPressed: _updateSearchQuery,
                      icon: const Icon(Icons.check, size: iconSize),
                    ),
                  ],
                )
              : null,
        ),
        enabled: !widget.isLocked,
        onEditingComplete: _updateSearchQuery,
      ),
    );
  }
}
