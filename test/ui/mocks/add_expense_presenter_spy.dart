import 'package:mocktail/mocktail.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class AddExpensePresenterSpy extends Mock implements AddExpensePresenter {
  AddExpensePresenterSpy() {
    when(() => loadPeriods()).thenAnswer((_) async => _);
    when(() => getPeriods()).thenAnswer((_) => []);
    when(() => loadPeriodCategories('')).thenAnswer((_) async => _);
    when(() => getCategories()).thenAnswer((invocation) => []);
  }

  void dispose() {}
}
