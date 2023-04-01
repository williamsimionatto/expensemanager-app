import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/domain_error.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class LoadExpensesSpy extends Mock implements LoadExpenses {
  When mockLoadCall() => when(() => load());
  void mockLoad(List<ExpenseEntity> expenses) =>
      mockLoadCall().thenAnswer((_) async => expenses);
  void mockLoadError(DomainError error) => mockLoadCall().thenThrow(error);
}
