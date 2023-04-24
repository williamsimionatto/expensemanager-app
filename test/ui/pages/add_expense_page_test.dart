import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../helpers/helpers.dart';
import '../mocks/mocks.dart';

void main() {
  late AddExpensePresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = AddExpensePresenterSpy();

    await tester.pumpWidget(makePage(
      path: '/expenses/add',
      page: () => AddExpensePage(presenter),
    ));

    await tester.pump(const Duration(seconds: 3));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should load page with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);
    await tester.pump();

    final periodDropdown = find.byKey(const ValueKey('periodInput'));
    expect(periodDropdown, findsOneWidget);

    await tester.pump();

    final categoryDropdown = find.byKey(const ValueKey('categoryInput'));
    expect(categoryDropdown, findsOneWidget);

    final descriptionInput = find.byKey(const ValueKey('descriptionInput'));
    expect(descriptionInput, findsOneWidget);

    final amountInput = find.byKey(const ValueKey('amountInput'));
    expect(amountInput, findsOneWidget);

    final dateInput = find.byKey(const ValueKey('dateInput'));
    expect(dateInput, findsOneWidget);
  });
}
