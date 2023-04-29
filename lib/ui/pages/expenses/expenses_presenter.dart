import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';

abstract class ExpensesPresenter extends Listenable {
  Stream<bool?>? get isLoadingStream;
  Stream<List<ExpenseViewModel>?>? get expensesStream;
  Stream<String?>? get successMessageStream;

  Future<void> loadData();
  Future<void> deleteExpense(String id);
}
