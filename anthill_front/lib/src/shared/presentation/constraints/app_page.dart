import '../../../modules/logging/logging_module.dart';
import '../../../modules/transactions/transactions_module.dart';
import '../../../modules/users/users_module.dart';
import '../../typedefs.dart';

const idParamPlaceholder = ':id';
const defaultPage = AppPage.logs;

// todo invent a way to register routes for modules dynamically

enum AppPage {
  transactions('/transactions', TransactionsPage.pageBuilder),
  transactionEditor('/transactions/editor', TransactionEditor.pageBuilder),
  transaction('/transactions/$idParamPlaceholder', SingleTransactionPage.pageBuilder),
  users('/users', UsersPage.pageBuilder),
  userEditor('/users/editor', UserEditor.pageBuilder),
  user('/users/$idParamPlaceholder', SingleUserPage.pageBuilder),
  logs('/logs', LogsPage.pageBuilder),
  ;

  final String location;
  final PageBuilder pageBuilder;

  const AppPage(this.location, this.pageBuilder);

  String formatLocation({int? id}) =>
      id == null ? location.replaceAll(idParamPlaceholder, '$id') : location;
}
