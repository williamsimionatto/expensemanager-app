import 'package:expensemanagerapp/ui/pages/pages.dart';

abstract class ExpensesPresenter {
  Stream<bool?>? get isLoadingStream;
  Stream<List<ExpenseViewModel>?>? get expensesStream;

  Future<void> loadData();
}
