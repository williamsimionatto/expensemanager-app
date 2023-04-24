import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

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

  testWidgets('Should call Validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);
    await tester.pump();

    final description = faker.lorem.sentence();
    await tester.enterText(
      find.byKey(const ValueKey('descriptionInput')),
      description,
    );
    verify(() => presenter.validateDescription(description));

    final amount =
        faker.randomGenerator.decimal(min: 150).toStringAsFixed(2).toString();
    await tester.enterText(find.byKey(const ValueKey('amountInput')), amount);
    verify(() => presenter.validateAmount(amount));

    await tester.tap(find.byKey(const ValueKey('dateInput')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    verify(() => presenter.validateDate(any()));
  });
}
