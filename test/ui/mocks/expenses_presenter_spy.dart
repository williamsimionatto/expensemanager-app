import 'dart:async';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import 'package:mocktail/mocktail.dart';

class ExpensesPresenterSpy extends Mock implements ExpensesPresenter {
  final loadExpensesController = StreamController<List<ExpenseViewModel>>();

  ExpensesPresenterSpy() {
    when(() => loadData()).thenAnswer((_) async => {});
    when(() => expensesStream).thenAnswer((_) => loadExpensesController.stream);
  }

  void emitExpenses(List<ExpenseViewModel> data) =>
      loadExpensesController.add(data);

  void emitExpensesError(String error) =>
      loadExpensesController.addError(error);

  void dispose() {
    loadExpensesController.close();
  }
}
