import '../../../modules/transactions/transactions_module.dart';
import '../../../modules/users/presentation/pages/single_user_page.dart';
import '../../../modules/users/presentation/pages/users_page.dart';
import '../../typedefs.dart';

const idParamPlaceholder = ':id';
const defaultPage = AppPage.transactions;

// todo invent a way to register routes for modules dynamically

enum AppPage {
  transactions('/transactions', TransactionsPage.pageBuilder),
  transactionEditor('/transactions/editor', TransactionEditor.pageBuilder),
  transaction('/transactions/$idParamPlaceholder', SingleTransactionView.pageBuilder),
  users('/users', UsersPage.pageBuilder),
  user('/users/$idParamPlaceholder', SingleUserPage.pageBuilder),
  ;

  final String location;
  final PageBuilder pageBuilder;

  const AppPage(this.location, this.pageBuilder);

  String formatLocation({int? id}) =>
      id == null ? location.replaceAll(idParamPlaceholder, '$id') : location;
}
