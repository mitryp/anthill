import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/http.dart';
import '../../../../shared/navigation.dart';
import '../../../../shared/widgets.dart';
import '../../domain/dtos/user_by_id_provider.dart';
import '../../users_module.dart';

class SingleUserPage extends ConsumerWidget with CanControlCollection<UserReadDto> {
  final int _userId;
  final UserReadDto? _user;

  const SingleUserPage({
    required int userId,
    UserReadDto? user,
    super.key,
  })  : _userId = userId,
        _user = user;

  factory SingleUserPage.pageBuilder(BuildContext _, GoRouterState state) {
    final (:id, :model) = modelFromRouterState<UserReadDto>(state);

    return SingleUserPage(userId: id, user: model);
  }

  @override
  AppPage get editorPage => AppPage.userEditor;

  @override
  ProviderListenable<
      CollectionControllerMixin<UserReadDto, Model, Model,
          HttpWriteMixin<UserReadDto, Model, Model>>> get collectionControllerProvider =>
      userControllerProvider.notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passedUser = _user;
    final userId = _userId;

    final value =
        passedUser != null ? AsyncData(passedUser) : ref.watch(userByIdProvider(userId, context));

    final stateRepr = switchSingleModelValue(value, context: context);
    if (stateRepr != null) {
      return stateRepr;
    }

    final user = value.requireValue;

    final (time: createdTime, date: createdDate) = formatDate(user.createDate);
    final deleteDate = user.deleteDate;
    final (time: deletedTime, date: deletedDate) =
        (deleteDate != null ? formatDate(deleteDate) : null) ?? (time: null, date: null);

    final child = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: ListTile(
            title: Text('User: ${user.name} (${user.role.name})'),
            subtitle: Text(user.email),
          ),
        ),
        ModelInfoChips(
          children: [
            Chip(
              label: Text('Created at $createdTime $createdDate'),
            ),
            if (deleteDate != null)
              Chip(
                color: MaterialStatePropertyAll(Colors.red[300]),
                label: Text('Deleted at $deletedTime $deletedDate'),
              ),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [CopyLinkButton(link: '${GoRouterState.of(context).uri}')],
      ),
      body: PageBody(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              child,
              const SizedBox(height: 32),
              SingleModelControls(
                onDeletePressed: () => deleteModel(context, ref, user),
                onEditPressed: () => openEditor(context, user),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
