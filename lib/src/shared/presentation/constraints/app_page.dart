import '../../../modules/transactions/presentation/pages/transaction_view.dart';
import '../../../modules/transactions/presentation/pages/transactions_view.dart';
import '../../../modules/transactions/presentation/transaction_editor.dart';
import '../../typedefs.dart';
import '../pages/dashboard.dart';

const idParamPlaceholder = ':id';
const defaultPage = AppPage.dashboard;

enum AppPage {
  dashboard('/dashboard', Dashboard.pageBuilder),
  transactions('/transactions', TransactionsView.pageBuilder),
  transactionEditor('/transactions/editor', TransactionEditor.pageBuilder),
  transaction('/transactions/$idParamPlaceholder', TransactionView.pageBuilder);

  final String location;
  final PageBuilder pageBuilder;

  const AppPage(this.location, this.pageBuilder);

  String formatLocation({int? id}) =>
      id == null ? location.replaceAll(idParamPlaceholder, '$id') : location;
}
