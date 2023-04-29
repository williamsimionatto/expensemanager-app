import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/delete_expense.dart';
import 'package:mocktail/mocktail.dart';

class DeleteExpenseSpy extends Mock implements DeleteExpense {
  When mockDeleteCall() => when(() => delete(id: any(named: 'id')));
  void mockDelete(String id) => mockDeleteCall().thenAnswer((_) async => id);
  void mockDeleteError(DomainError error) => mockDeleteCall().thenThrow(error);
}
