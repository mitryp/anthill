import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

import '../../application/http/collection_controller_mixin.dart';
import '../../application/http/http_service.dart';
import '../../domain/interfaces/model.dart';
import '../constraints/app_page.dart';
import '../dialogs/confirmation_dialog.dart';
import 'context_app_pages.dart';

mixin CanControlCollection<TModel extends IdentifiableModel> on ConsumerWidget {
  @visibleForOverriding
  AppPage get editorPage;

  @visibleForOverriding
  ProviderListenable<
          CollectionControllerMixin<TModel, Model, Model, HttpWriteMixin<TModel, Model, Model>>>
      get collectionControllerProvider;

  @visibleForOverriding
  String localizeConfirmationMessage(BuildContext context) =>
      'Do you really want to delete this model?';

  @protected
  Future<void> deleteModel(BuildContext context, WidgetRef ref, TModel model) async {
    if (!await askUserConfirmation(
          context,
          Text(localizeConfirmationMessage(context)),
        ) ||
        !context.mounted) {
      return;
    }

    // ignore: use_build_context_synchronously
    ref.read(collectionControllerProvider).deleteResource(model.id, context);

    if (context.mounted) {
      context.pop();
    }
  }

  void openEditor(BuildContext context, TModel model) {
    if (!context.mounted) return;
    context.goPage(editorPage, extra: model);
  }
}
