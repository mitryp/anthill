import 'package:flutter/material.dart';

import '../../http.dart';
import '../../widgets.dart';

/// A widget providing a base for representing a single resource.
///
/// When [leading] is not given, there will be a deleted marker, when the model is deleted.
/// When [trailing] is not given, there will be a creation date representation.
class ResourceCard extends StatelessWidget {
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
    final (:date, :time) = formatDate(model.createDate.toLocal());

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
        if (model.isDeleted) const _DeletedResourceMarker(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final elevation = model.isDeleted ? _Constants.deletedElevation : _Constants.elevation;
    final tintColor = model.isDeleted ? _Constants.deletedTintColor : null;

    return Card(
      shape: _Constants.cardShape,
      elevation: elevation,
      surfaceTintColor: tintColor,
      child: ListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing ?? _buildCreatedDateRepr(context),
        onTap: onTap,
        contentPadding: _Constants.contentPadding,
        shape: _Constants.cardShape,
      ),
    );
  }
}

class _DeletedResourceMarker extends StatelessWidget {
  const _DeletedResourceMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.locale.deletedResourceMarker,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

abstract final class _Constants {
  static const elevation = 3.0;
  static const deletedElevation = elevation / 2;
  static final deletedTintColor = Colors.red[600];
  static const contentPadding = EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
}
