import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/presentation/presenter/presenter.dart';
import 'package:expensemanagerapp/presentation/protocols/validation.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../data/mocks/mocks.dart';
import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  late AddExpensePresenter sut;
  late ValidationSpy validation;
  late LoadPeriodsSpy loadPeriods;
  late LoadPeriodCategoriesSpy loadPeriodCategories;
  late AddExpenseSpy addExpense;

  late List<PeriodEntity> periods;
  late List<PeriodCategoryEntity> periodCategories;

  late String periodId;
  late String categoryId;
  late String description;
  late String amount;
  late String date;

  late ExpenseEntity expense;

  setUpAll(() {
    registerFallbackValue(EntityFactory.makeExpense());
    registerFallbackValue(ParamsFactory.makeAddExpenseParams());
  });

  setUp(() {
    categoryId = faker.randomGenerator.integer(10).toString();
    description = faker.lorem.sentence();
    amount = faker.randomGenerator.decimal().toString();
    date = faker.date.dateTime().toIso8601String();

    loadPeriods = LoadPeriodsSpy();
    loadPeriodCategories = LoadPeriodCategoriesSpy();
    validation = ValidationSpy();

    periods = EntityFactory.makePeriods();
    loadPeriods.mockLoadPeriods(periods);
    periodId = periods.first.id.toString();

    periodCategories = EntityFactory.makePeriodCategories();
    loadPeriodCategories.mockLoadPeriodCategories(periodCategories);

    expense = EntityFactory.makeExpense();
    addExpense = AddExpenseSpy();
    addExpense.mockAdd(expense);

    sut = GetXAddExpensePresenter(
      validation: validation,
      loadPeriod: loadPeriods,
      loadPeriodCategory: loadPeriodCategories,
      addExpense: addExpense,
    );
  });

  group('LoadPeriods', () {
    test('Should call LoadPeriods on load periods', () async {
      await sut.loadPeriods();
      verify(() => loadPeriods.load()).called(1);
    });

    test('Should emit correct event on LoadPeriods fails', () async {
      loadPeriods.mockLoadPeriodsError(DomainError.unexpected);

      sut.periodsStream.listen(
        null,
        onError: expectAsync1(
          (error) => expect(error, DomainError.unexpected.description),
        ),
      );

      await sut.loadPeriods();
    });
  });

  group('LoadPeriodCategories', () {
    test('Should call LoadPeriodCategories on load period categories',
        () async {
      await sut.loadPeriodCategories(periodId);
      verify(() => loadPeriodCategories.load(periodId)).called(1);
    });

    test('Should emit correct event on LoadPeriodCategories fails', () async {
      loadPeriodCategories
          .mockLoadPeriodCategoriesError(DomainError.unexpected);

      sut.periodCategoriesStream.listen(
        null,
        onError: expectAsync1(
          (error) => expect(error, DomainError.unexpected.description),
        ),
      );

      await sut.loadPeriodCategories(periodId);
    });
  });

  group('Period', () {
    setUp(() async {
      await sut.loadPeriods();
    });

    test('Shoul call Validation with correct period id', () {
      final formDate = {
        'periodId': periodId,
        'categoryId': null,
        'description': null,
        'amount': null,
        'date': null,
      };

      sut.validatePeriod(periodId);

      verify(() => validation.validate(field: 'periodId', input: formDate))
          .called(1);
    });

    test('Should emit invalidFieldError if period value is invalid', () async {
      await sut.loadPeriods();
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.periodErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.invalidField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePeriod(periodId);
      sut.validatePeriod(periodId);
    });

    test('Should emit requiredFieldError if period value is empty', () async {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.periodErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.requiredField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePeriod(periodId);
      sut.validatePeriod(periodId);
    });

    test('Should emit null if period validation succeeds', () {
      sut.periodErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validatePeriod(periodId);
      sut.validatePeriod(periodId);
    });

    test('Should call LoadPeriodCategories after a period is selected', () {
      sut.validatePeriod(periodId);
      verify(() => loadPeriodCategories.load(periodId)).called(1);
    });
  });

  group('Category', () {
    test('Should call Validation with correct category id', () {
      final formDate = {
        'periodId': null,
        'categoryId': categoryId,
        'description': null,
        'amount': null,
        'date': null,
      };

      sut.validateCategory(categoryId);

      verify(() => validation.validate(field: 'categoryId', input: formDate))
          .called(1);
    });

    test('Should emit invalidFieldError if category value is invalid',
        () async {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.categoryErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.invalidField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateCategory(categoryId);
      sut.validateCategory(categoryId);
    });

    test('Should emit requiredFieldError if category value is empty', () async {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.categoryErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.requiredField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateCategory(categoryId);
      sut.validateCategory(categoryId);
    });

    test('Should emit null if category validation succeeds', () {
      sut.categoryErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateCategory(categoryId);
      sut.validateCategory(categoryId);
    });
  });

  group('Description', () {
    test('Should call Validation with correct description', () {
      final formDate = {
        'periodId': null,
        'categoryId': null,
        'description': description,
        'amount': null,
        'date': null,
      };

      sut.validateDescription(description);

      verify(() => validation.validate(field: 'description', input: formDate))
          .called(1);
    });

    test('Should emit invalidFieldError if description value is invalid',
        () async {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.descriptionErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.invalidField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateDescription(description);
      sut.validateDescription(description);
    });

    test('Should emit requiredFieldError if description value is empty',
        () async {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.descriptionErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.requiredField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateDescription(description);
      sut.validateDescription(description);
    });

    test('Should emit null if description validation succeeds', () {
      sut.descriptionErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateDescription(description);
      sut.validateDescription(description);
    });
  });

  group('Amount', () {
    test('Should call Validation with correct amount', () {
      final formDate = {
        'periodId': null,
        'categoryId': null,
        'description': null,
        'amount': amount,
        'date': null,
      };

      sut.validateAmount(amount);

      verify(() => validation.validate(field: 'amount', input: formDate))
          .called(1);
    });

    test('Should emit invalidFieldError if amount value is invalid', () async {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.amountErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.invalidField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateAmount(amount);
      sut.validateAmount(amount);
    });

    test('Should emit requiredFieldError if amount value is empty', () async {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.amountErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.requiredField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateAmount(amount);
      sut.validateAmount(amount);
    });

    test('Should emit null if amount validation succeeds', () {
      sut.amountErrorStream
          ?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateAmount(amount);
      sut.validateAmount(amount);
    });
  });

  group('Date', () {
    test('Should call Validation with correct date', () {
      final formDate = {
        'periodId': null,
        'categoryId': null,
        'description': null,
        'amount': null,
        'date': date,
      };

      sut.validateDate(date);

      verify(() => validation.validate(field: 'date', input: formDate))
          .called(1);
    });

    test('Should emit invalidFieldError if date value is invalid', () async {
      validation.mockValidationError(error: ValidationError.invalidField);

      sut.dateErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.invalidField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateDate(date);
      sut.validateDate(date);
    });

    test('Should emit requiredFieldError if date value is empty', () async {
      validation.mockValidationError(error: ValidationError.requiredField);

      sut.dateErrorStream?.listen(
          expectAsync1((error) => expect(error, UIError.requiredField)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateDate(date);
      sut.validateDate(date);
    });

    test('Should emit null if date validation succeeds', () {
      sut.dateErrorStream?.listen(expectAsync1((error) => expect(error, null)));
      sut.isFormValidStream
          ?.listen(expectAsync1((isValid) => expect(isValid, false)));

      sut.validateDate(date);
      sut.validateDate(date);
    });
  });

  test('Should emit form valid if all fields are valid', () async {
    await sut.loadPeriods();
    expect(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validatePeriod(periodId);
    sut.validateCategory(categoryId);
    sut.validateDescription(description);
    sut.validateAmount(amount);
    sut.validateDate(date);
  });

  test('Should call AddExpense with correct values', () async {
    await sut.loadPeriods();
    sut.validatePeriod(periodId);
    sut.validateCategory(categoryId);
    sut.validateDescription(description);
    sut.validateAmount(amount);
    sut.validateDate(date);

    final params = AddExpenseParams(
      periodId: int.parse(periodId),
      categoryId: int.parse(categoryId),
      description: description,
      amount: double.parse(amount),
      date: date,
    );

    await sut.add();
    verify(() => addExpense.add(params)).called(1);
  });

  test('Should emit correct events on AddExpense success', () async {
    await sut.loadPeriods();
    sut.validatePeriod(periodId);
    sut.validateCategory(categoryId);
    sut.validateDescription(description);
    sut.validateAmount(amount);
    sut.validateDate(date);

    expectLater(sut.mainErrorStream, emits(null));
    expectLater(sut.isLoadingStream, emits(true));
    expectLater(
      sut.successMessageStream,
      emits('Expense added successfully'),
    );
    expectLater(sut.navigateToStream, emits('/expenses'));
    await sut.add();
  });

  test('Should emit correct events on UnexpectedError', () async {
    await sut.loadPeriods();
    addExpense.mockError(DomainError.unexpected);

    sut.validatePeriod(periodId);
    sut.validateCategory(categoryId);
    sut.validateDescription(description);
    sut.validateAmount(amount);
    sut.validateDate(date);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.mainErrorStream, emitsInOrder([null, UIError.unexpected]));

    await sut.add();
  });

  test('Should return correct period on get periodId', () async {
    await sut.loadPeriods();
    sut.validatePeriod(periodId);

    expect(sut.periodId, periodId);
  });

  test('Should return correct value on get isPeriodValid', () async {
    await sut.loadPeriods();
    expect(sut.isPeriodValid, false);

    sut.validatePeriod(periodId);
    expect(sut.isPeriodValid, true);
  });

  test('Should return correct categories on getCategories', () async {
    await sut.loadPeriods();
    await sut.loadPeriodCategories(periodId);

    final categories = sut.getCategories();

    expect(categories.length, greaterThan(0));
    expect(categories, isA<List<Map<String, dynamic>>>());
  });

  test('Should return correct periods on getPeriods', () async {
    await sut.loadPeriods();

    final periods = sut.getPeriods();

    expect(periods.length, greaterThan(0));
    expect(periods, isA<List<Map<String, dynamic>>>());
  });
}
