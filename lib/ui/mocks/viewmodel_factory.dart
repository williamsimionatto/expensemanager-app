import 'package:expensemanagerapp/ui/pages/pages.dart';

class ViewModelFactory {
  static List<ExpenseViewModel> makeExpenseList() => [
        const ExpenseViewModel(
          id: 1,
          description: 'Expense 1',
          amount: 100,
          date: '2021-01-01',
        ),
        const ExpenseViewModel(
          id: 2,
          description: 'Expense 2',
          amount: 200,
          date: '2021-01-02',
        ),
      ];
}
