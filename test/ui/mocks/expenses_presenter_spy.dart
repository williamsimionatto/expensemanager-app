import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

class ExpensesPresenterSpy extends Mock implements ExpensesPresenter {
  ExpensesPresenterSpy() {
    when(() => loadData()).thenAnswer((_) async => {});
  }

  void dispose() {}
}
