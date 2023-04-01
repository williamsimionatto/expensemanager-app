import 'package:flutter_test/flutter_test.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late ExpensesPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = ExpensesPresenterSpy();
    await tester.pumpWidget(makePage(
      path: '/users',
      page: () => ExpensesPage(presenter),
    ));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call LoadExpenses on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadData()).called(1);
  });
}
