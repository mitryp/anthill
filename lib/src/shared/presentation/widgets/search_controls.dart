import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';

class SearchControls extends StatefulWidget {
  final PaginationController paginationController;
  final bool isLocked;

  const SearchControls({
    required this.paginationController,
    this.isLocked = false,
    super.key,
  });

  @override
  State<SearchControls> createState() => _SearchControlsState();
}

class _SearchControlsState extends State<SearchControls> {
  late final TextEditingController _controller = TextEditingController(
      text: widget.paginationController.search != null
          ? '${widget.paginationController.search}'
          : '');

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
    return ListenableBuilder(
      listenable: widget.paginationController,
      builder: (context, _) => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                // todo localize
                labelText: 'Search',
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _resetSearch,
                      icon: const Icon(Icons.clear),
                    ),
                    IconButton(
                      onPressed: _updateSearchQuery,
                      icon: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
              enabled: !widget.isLocked,
              onEditingComplete: _updateSearchQuery,
            ),
          ),
        ],
      ),
    );
  }
}
