import 'package:expensemanagerapp/domain/helpers/domain_error.dart';
import 'package:expensemanagerapp/ui/mocks/viewmodel_factory.dart';
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

  testWidgets('Should presenter error if loadExpensesStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitExpensesError(DomainError.unexpected.description);
    await tester.pump();

    expect(
      find.text('Algo errado aconteceu. Tente novamente em breve.'),
      findsOneWidget,
    );
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Expense 1'), findsNothing);
  });

  testWidgets('Should presenter list if loadExpensesStream succeeds',
      (WidgetTester tester) async {
    await loadPage(tester);
    presenter.emitUsers(ViewModelFactory.makeExpenseList());
    await tester.pump();

    expect(
      find.text('Algo errado aconteceu. Tente novamente em breve.'),
      findsNothing,
    );
    expect(find.text('Recarregar'), findsNothing);

    expect(find.text('Expense 1'), findsOneWidget);
    expect(find.text('Expense 2'), findsOneWidget);
  });
}
