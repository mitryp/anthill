import '../../../modules/transactions/transactions_module.dart';
import '../../typedefs.dart';

const idParamPlaceholder = ':id';
const defaultPage = AppPage.transactions;

enum AppPage {
  transactions('/transactions', TransactionsPage.pageBuilder),
  transactionEditor('/transactions/editor', TransactionEditor.pageBuilder),
  transaction('/transactions/$idParamPlaceholder', SingleTransactionView.pageBuilder);

  final String location;
  final PageBuilder pageBuilder;

  const AppPage(this.location, this.pageBuilder);

  String formatLocation({int? id}) =>
      id == null ? location.replaceAll(idParamPlaceholder, '$id') : location;
}
