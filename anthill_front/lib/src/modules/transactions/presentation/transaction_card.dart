import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/navigation.dart';
import '../../../shared/presentation/theme.dart';
import '../../../shared/widgets.dart';
import '../../auth/application/providers/current_user_provider.dart';
import '../../users/domain/constraints/user_role.dart';
import '../domain/dtos/transaction_read_dto.dart';

class TransactionCard extends ConsumerWidget {
  final TransactionReadDto _transaction;

  const TransactionCard({required TransactionReadDto transaction, super.key})
      : _transaction = transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    final tileColor =
        currentUser.role == UserRole.volunteer && _transaction.user.id == currentUser.id
            ? ownedResourceCardColor
            : null;

    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: ListTileThemeData(tileColor: tileColor),
      ),
      child: ResourceCard(
        model: _transaction,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${_transaction.amount}GBP',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ': '),
              TextSpan(text: _transaction.sourceOrPurpose),
            ],
          ),
        ),
        subtitle: _transaction.note.isNotEmpty ? Text(_transaction.note) : null,
        onTap: () => context.pushPage(
          AppPage.transaction,
          resourceId: _transaction.id,
        ),
      ),
    );
  }
}
