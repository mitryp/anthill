import '../../../modules/transactions/presentation/pages/transaction_view.dart';
import '../../../modules/transactions/presentation/pages/transactions_view.dart';
import '../../typedefs.dart';
import '../pages/dashboard.dart';

enum AppPage {
  dashboard('/dashboard', Dashboard.pageBuilder),
  transactions('/transactions', TransactionsView.pageBuilder),
  transaction('/transactions/cache', TransactionView.cachedPageBuilder),
  transactionById('/transactions/:id', TransactionView.pageBuilder);

  final String location;
  final PageBuilder pageBuilder;

  const AppPage(this.location, this.pageBuilder);
}
