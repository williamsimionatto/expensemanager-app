import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class AddExpenseSpy extends Mock implements AddExpense {
  When mockCall() => when(() => add(any()));

  void mockAdd(ExpenseEntity expense) =>
      mockCall().thenAnswer((_) async => expense);

  void mockError(DomainError error) => mockCall().thenThrow(error);
}
