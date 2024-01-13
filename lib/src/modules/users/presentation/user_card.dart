import 'package:flutter/material.dart';

import '../../../shared/presentation/constraints/app_page.dart';
import '../../../shared/presentation/utils/context_app_pages.dart';
import '../../../shared/utils/date_format.dart';
import '../domain/dtos/user_read_dto.dart';

class UserCard extends StatelessWidget {
  final UserReadDto _user;

  const UserCard({
    required UserReadDto user,
    super.key,
  }) : _user = user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: _user.name),
              const TextSpan(text: ' - '),
              TextSpan(
                text: _user.role.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        subtitle: Text(_user.email),
        trailing: Text('Created on\n${formatDate(_user.createDate).date}'),
        onTap: () => context.pushPage(AppPage.user, resourceId: _user.id, extra: _user),
      ),
    );
  }
}
