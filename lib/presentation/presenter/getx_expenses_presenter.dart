import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetxExpensesPresenter implements ExpensesPresenter {
  final LoadExpenses loadExpenses;

  GetxExpensesPresenter({required this.loadExpenses});

  @override
  Future<void> loadData() async {
    await loadExpenses.load();
  }
}
