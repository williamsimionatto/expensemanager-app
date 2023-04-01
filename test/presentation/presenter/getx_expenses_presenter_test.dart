import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/presentation/presenter/presenter.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {
  late LoadExpensesSpy loadExpenses;
  late GetxExpensesPresenter sut;
  late List<ExpenseEntity> expenses;

  setUp(() {
    expenses = EntityFactory.makeExpenses();
    loadExpenses = LoadExpensesSpy();
    loadExpenses.mockLoad(expenses);
    sut = GetxExpensesPresenter(loadExpenses: loadExpenses);
  });

  test('Shoudl call LoadExpenses on loadData', () async {
    await sut.loadData();
    verify(() => loadExpenses.load()).called(1);
  });
}
