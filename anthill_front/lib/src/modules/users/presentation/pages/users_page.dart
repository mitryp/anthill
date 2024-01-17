import 'package:flutter/material.dart';
import 'package:flutter_nestjs_paginate/flutter_nestjs_paginate.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/navigation.dart';
import '../../../../shared/pagination.dart';
import '../../../../shared/widgets.dart';
import '../../../auth/auth_module.dart';
import '../../application/providers/user_service_provider.dart';
import '../../application/providers/users_provider.dart';
import '../../domain/constraints/user_role.dart';
import '../../domain/dtos/user_read_dto.dart';
import '../user_card.dart';

class UsersPage extends StatelessWidget {
  final QueryParams _queryParams;

  const UsersPage({
    QueryParams queryParams = const {},
    super.key,
  }) : _queryParams = queryParams;

  factory UsersPage.pageBuilder(BuildContext _, GoRouterState state) {
    final params = state.uri.queryParametersAll.normalize();

    return UsersPage(queryParams: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: const [CopyLinkButton()],
      ),
      floatingActionButton: VisibleFor(
        roles: const {UserRole.admin},
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => context.pushPage(AppPage.userEditor),
        ),
      ),
      body: PageBody(
        child: PaginatedCollectionView<UserReadDto>(
          queryParams: _queryParams,
          httpServiceProvider: userServiceProvider,
          collectionProvider: usersProvider,
          viewBuilder: (context, users) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: users.data.length,
              itemBuilder: (context, index) => UserCard(user: users.data[index]),
            );
          },
        ),
      ),
    );
  }
}
