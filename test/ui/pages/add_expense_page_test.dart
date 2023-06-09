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

    final button = find.byKey(const ValueKey('continueButton'));
    expect(button, findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should enabled continue button if period is valid',
      (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    final button =
        widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should presenter period error',
      (WidgetTester widgetTester) async {
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

  testWidgets('Should change to second page',
      (WidgetTester widgetTester) async {
    await loadPage(widgetTester);

    presenter.emitPeriodValid();
    await widgetTester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await widgetTester.ensureVisible(button);
    await widgetTester.tap(button);

    await widgetTester.pumpAndSettle();

    final categoryDropdown = find.byKey(const ValueKey('categoryInput'));
    expect(categoryDropdown, findsOneWidget);

    final descriptionInput = find.byKey(const ValueKey('descriptionInput'));
    expect(descriptionInput, findsOneWidget);

    final amountInput = find.byKey(const ValueKey('amountInput'));
    expect(amountInput, findsOneWidget);

    final dateInput = find.byKey(const ValueKey('dateInput'));
    expect(dateInput, findsOneWidget);

    final saveButton =
        widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(saveButton.onPressed, null);

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call Validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);
    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pumpAndSettle();

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
  });

  testWidgets('Should present description error', (WidgetTester tester) async {
    await loadPage(tester);
    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pumpAndSettle();

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

    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pumpAndSettle();

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
    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pumpAndSettle();

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

  testWidgets('Should presenter category error', (widgetTester) async {
    await loadPage(widgetTester);
    presenter.emitPeriodValid();
    await widgetTester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await widgetTester.ensureVisible(button);
    await widgetTester.tap(button);

    await widgetTester.pumpAndSettle();

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
    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pumpAndSettle();

    presenter.emitFormError();

    final buttonSave =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(buttonSave.onPressed, null);
  });

  testWidgets('Should enabled button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    presenter.emitFormValid();
    await tester.pumpAndSettle();

    final buttonSave =
        tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(buttonSave.onPressed, isNotNull);
  });

  testWidgets('Should call add on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitPeriodValid();
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pumpAndSettle();

    presenter.emitFormValid();
    await tester.pumpAndSettle();
    final buttonSave = find.byType(ElevatedButton);
    await tester.ensureVisible(buttonSave);
    await tester.tap(buttonSave);
    await tester.pumpAndSettle();

    verify(() => presenter.add()).called(1);
  });

  testWidgets('Should present error message if add throws',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitMainError(UIError.unexpected);
    await tester.pumpAndSettle();

    expect(
      find.text('Something went wrong. Please try again soon.'),
      findsOneWidget,
    );
  });

  testWidgets('Should present success message if add succeeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitSuccess();
    await tester.pumpAndSettle();

    expect(
      find.text('Expense added successfully'),
      findsOneWidget,
    );
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);
    presenter.emitNavigateTo('/any_route');
    await tester.pumpAndSettle();
    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitNavigateTo('');
    await tester.pump();
    expect(currentRoute, '/expenses/add');
  });
}
