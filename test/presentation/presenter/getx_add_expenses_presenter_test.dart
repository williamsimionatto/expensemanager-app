import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';

import 'package:expensemanagerapp/presentation/presenter/presenter.dart';

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

  group('Period', () {
    test('Shoul call Validation with correct period id', () {
      final formDate = {
        'periodId': periodId,
      };

      sut.validatePeriod(periodId);

      verify(() => validation.validate(field: 'periodId', input: formDate))
          .called(1);
    });
  });
}
