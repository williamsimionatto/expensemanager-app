import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';

import 'package:expensemanagerapp/presentation/presenter/presenter.dart';
import 'package:expensemanagerapp/presentation/protocols/validation.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../domain/mocks/mocks.dart';
import '../mocks/mocks.dart';

void main() {
  late AddExpensePresenter sut;
  late ValidationSpy validation;
  late LoadPeriodsSpy loadPeriods;
  late LoadPeriodCategoriesSpy loadPeriodCategories;
  late List<PeriodEntity> periods;
  late List<PeriodCategoryEntity> periodCategories;
  late String periodId;
  late String categoryId;
  late String description;

  setUp(() {
    periodId = faker.guid.guid();
    categoryId = faker.guid.guid();
    description = faker.lorem.sentence();

    loadPeriods = LoadPeriodsSpy();
    loadPeriodCategories = LoadPeriodCategoriesSpy();
    validation = ValidationSpy();

    periods = EntityFactory.makePeriods();
    loadPeriods.mockLoadPeriods(periods);

    periodCategories = EntityFactory.makePeriodCategories();
    loadPeriodCategories.mockLoadPeriodCategories(periodCategories);

    sut = GetXAddExpensePresenter(
      validation: validation,
      loadPeriod: loadPeriods,
      loadPeriodCategory: loadPeriodCategories,
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
    test('Shoul call Validation with correct period id', () {
      final formDate = {
        'periodId': periodId,
        'categoryId': null,
      };

      sut.validatePeriod(periodId);

      verify(() => validation.validate(field: 'periodId', input: formDate))
          .called(1);
    });

    test('Should emit invalidFieldError if period value is invalid', () async {
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
  });

  group('Category', () {
    test('Should call Validation with correct category id', () {
      final formDate = {
        'periodId': null,
        'categoryId': categoryId,
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
  });
}
