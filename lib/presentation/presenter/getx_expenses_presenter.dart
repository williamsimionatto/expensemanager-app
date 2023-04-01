import 'package:expensemanagerapp/presentation/mixins/loading_manager.dart';
import 'package:get/get.dart';

import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetxExpensesPresenter extends GetxController
    with LoadingManager
    implements ExpensesPresenter {
  final LoadExpenses loadExpenses;

  final _expenses = Rx<List<ExpenseViewModel>>([]);

  @override
  Stream<List<ExpenseViewModel>> get expensesStream =>
      _expenses.stream.map((expenses) => expenses.toList());

  GetxExpensesPresenter({required this.loadExpenses});

  @override
  Future<void> loadData() async {
    isLoading = true;
    final expenses = await loadExpenses.load();
    _expenses.value = expenses
        .map(
          (expense) => ExpenseViewModel(
            id: expense.id,
            description: expense.description,
            amount: expense.amount,
            date: expense.date,
          ),
        )
        .toList();

    isLoading = false;
  }
}
