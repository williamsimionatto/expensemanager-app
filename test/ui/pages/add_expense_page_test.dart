import 'package:expensemanagerapp/ui/helpers/helpers.dart';
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

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
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

  testWidgets('Should present description error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitDescriptionError(UIError.invalidField);
    await tester.pumpAndSettle();
    expect(find.text('Invalid Field'), findsOneWidget);

    presenter.emitDescriptionError(UIError.requiredField);
    await tester.pumpAndSettle();
    expect(find.text('Required Field'), findsOneWidget);

    presenter.emitDescriptionValid();
    await tester.pump();

    expect(
      find.byKey(const ValueKey('descriptionInput')),
      findsOneWidget,
    );
  });

  testWidgets('Should present amount error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitAmountError(UIError.invalidField);
    await tester.pumpAndSettle();
    expect(find.text('Invalid Field'), findsOneWidget);

    presenter.emitAmountError(UIError.requiredField);
    await tester.pumpAndSettle();
    expect(find.text('Required Field'), findsOneWidget);

    presenter.emitAmountValid();
    await tester.pump();

    expect(
      find.byKey(const ValueKey('amountInput')),
      findsOneWidget,
    );
  });

  testWidgets('Should present date error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitDateError(UIError.invalidField);
    await tester.pumpAndSettle();
    expect(find.text('Invalid Field'), findsOneWidget);

    presenter.emitDateError(UIError.requiredField);
    await tester.pumpAndSettle();
    expect(find.text('Required Field'), findsOneWidget);

    presenter.emitDateValid();
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('dateInput')),
      findsOneWidget,
    );
  });

  testWidgets('Should presenter period error', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitPeriodError(UIError.invalidField);
    await widgetTester.pumpAndSettle();
    expect(find.text('Invalid Field'), findsOneWidget);

    presenter.emitPeriodError(UIError.requiredField);
    await widgetTester.pumpAndSettle();
    expect(find.text('Required Field'), findsOneWidget);

    presenter.emitPeriodValid();
    await widgetTester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('periodInput')),
      findsOneWidget,
    );
  });

  testWidgets('Should presenter category error', (widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitCategoryError(UIError.invalidField);
    await widgetTester.pumpAndSettle();
    expect(find.text('Invalid Field'), findsOneWidget);

    presenter.emitCategoryError(UIError.requiredField);
    await widgetTester.pumpAndSettle();
    expect(find.text('Required Field'), findsOneWidget);

    presenter.emitCategoryValid();
    await widgetTester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('categoryInput')),
      findsOneWidget,
    );
  });

  testWidgets('Should disabled button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);
    presenter.emitFormError();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should enabled button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitFormValid();
    await tester.pumpAndSettle();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });
}
