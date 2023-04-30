import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/presentation/presenter/presenter.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';

void main() {
  late LoadExpensesSpy loadExpenses;
  late DeleteExpenseSpy deleteExpense;
  late GetxExpensesPresenter sut;
  late List<ExpenseEntity> expenses;

  setUp(() {
    expenses = EntityFactory.makeExpenses();
    loadExpenses = LoadExpensesSpy();
    loadExpenses.mockLoad(expenses);

    deleteExpense = DeleteExpenseSpy();
    deleteExpense.mockDelete('1');

    sut = GetxExpensesPresenter(
        loadExpenses: loadExpenses, deleteExpenses: deleteExpense);
  });

  test('Shoudl call LoadExpenses on loadData', () async {
    await sut.loadData();
    verify(() => loadExpenses.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.expensesStream.listen(
      expectAsync1(
        (expensesData) => expect(
          expensesData,
          [
            ExpenseViewModel(
              id: expenses[0].id,
              description: expenses[0].description,
              amount: expenses[0].amount,
              date: expenses[0].date,
            ),
            ExpenseViewModel(
              id: expenses[1].id,
              description: expenses[1].description,
              amount: expenses[1].amount,
              date: expenses[1].date,
            ),
          ],
        ),
      ),
    );
    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    loadExpenses.mockLoadError(DomainError.unexpected);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.expensesStream.listen(
      null,
      onError: expectAsync1(
        (error) => expect(error, DomainError.unexpected.description),
      ),
    );

    await sut.loadData();
  });

  group('Delete Expense', () {
    test('Should call DeleteExpense on delete data', () async {
      await sut.deleteExpense('1');
      verify(() => deleteExpense.delete(id: '1')).called(1);
    });
  });
}
