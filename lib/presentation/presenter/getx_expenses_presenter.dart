import 'package:get/get.dart';

import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/presentation/mixins/mixins.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetxExpensesPresenter extends GetxController
    with LoadingManager, NavigationManager, SuccessManager
    implements ExpensesPresenter {
  final LoadExpenses loadExpenses;
  final DeleteExpense deleteExpenses;

  final _expenses = Rx<List<ExpenseViewModel>>([]);

  @override
  Stream<List<ExpenseViewModel>> get expensesStream =>
      _expenses.stream.map((expenses) => expenses.toList());

  GetxExpensesPresenter({
    required this.loadExpenses,
    required this.deleteExpenses,
  });

  @override
  Future<void> loadData() async {
    try {
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
    } catch (error) {
      _expenses.subject.addError(
        DomainError.unexpected.description,
        StackTrace.empty,
      );
    } finally {
      isLoading = false;
    }
  }

  @override
  Future<void> deleteExpense(String id) async {
    try {
      isLoading = true;
      await deleteExpenses.delete(id: id);
      success = 'Expense deleted successfully';
    } catch (error) {
      _expenses.subject.addError(
        DomainError.unexpected.description,
        StackTrace.empty,
      );
    } finally {
      loadData();
    }
  }
}
