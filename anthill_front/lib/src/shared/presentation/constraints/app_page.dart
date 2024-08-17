import '../../../modules/logging/logging_module.dart';
import '../../../modules/transactions/presentation/pages/transaction_source_selector_page.dart';
import '../../../modules/transactions/transactions_module.dart';
import '../../../modules/users/users_module.dart';
import '../../typedefs.dart';
import '../pages/dashboard_page.dart';

const idParamPlaceholder = ':id';
const defaultPage = AppPage.transactionsSourceSelector;

enum AppPage {
  dashboard('/dashboard', DashboardPage.pageBuilder),
  transactions('/transactions', TransactionsPage.pageBuilder),
  transactionEditor('/transactions/editor', TransactionEditor.pageBuilder),
  transactionsSourceSelector('/transactions/sources', TransactionSourceSelectorPage.pageBuilder),
  transactionsStats('/transactions/stats', TransactionsStatsPage.pageBuilder),
  transaction('/transactions/$idParamPlaceholder', SingleTransactionPage.pageBuilder),
  users('/users', UsersPage.pageBuilder),
  userEditor('/users/editor', UserEditor.pageBuilder),
  user('/users/$idParamPlaceholder', SingleUserPage.pageBuilder),
  logs('/logs', LogsPage.pageBuilder),
  ;

  final String location;
  final PageBuilder pageBuilder;

  const AppPage(this.location, this.pageBuilder);

  String formatLocation([int? id]) {
    if (id == null) {
      return location;
    }

    return location.replaceAll(idParamPlaceholder, '$id');
  }
}
