import 'package:flutter/material.dart';

import '../../http.dart';
import '../../utils/date_format.dart';

/// A widget providing a base for representing a single resource.
///
/// When [leading] is not given, there will be a deleted marker, when the model is deleted.
/// When [trailing] is not given, there will be a creation date representation.
class ResourceCard extends StatelessWidget {
  static const _deletedMarker = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text('Deleted', style: TextStyle(fontWeight: FontWeight.bold))],
  );

  final Widget title;
  final Widget? subtitle;
  final IdentifiableModel model;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  const ResourceCard({
    required this.model,
    required this.title,
    this.subtitle,
    this.onTap,
    this.leading,
    this.trailing,
    super.key,
  });

  Widget _buildCreatedDateRepr(BuildContext context) {
    final (:date, :time) = formatDate(model.createDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(date),
        Text(
          time,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final leading = this.leading ?? (model.isDeleted ? _deletedMarker : null);

    return Card(
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing ?? _buildCreatedDateRepr(context),
        onTap: onTap,
      ),
    );
  }
}
