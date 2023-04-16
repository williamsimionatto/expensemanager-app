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
  late List<PeriodEntity> periods;
  late String periodId;

  setUp(() {
    periodId = faker.guid.guid();
    loadPeriods = LoadPeriodsSpy();
    validation = ValidationSpy();

    periods = EntityFactory.makePeriods();
    loadPeriods.mockLoadPeriods(periods);

    sut = GetXAddExpensePresenter(
      validation: validation,
      loadPeriod: loadPeriods,
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

  group('Period', () {
    test('Shoul call Validation with correct period id', () {
      final formDate = {
        'periodId': periodId,
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
}
