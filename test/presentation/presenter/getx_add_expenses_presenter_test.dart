import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';

import 'package:expensemanagerapp/presentation/presenter/presenter.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../domain/mocks/mocks.dart';

void main() {
  late AddExpensePresenter sut;
  late LoadPeriodsSpy loadPeriods;
  late List<PeriodEntity> periods;

  setUp(() {
    loadPeriods = LoadPeriodsSpy();
    periods = EntityFactory.makePeriods();
    loadPeriods.mockLoadPeriods(periods);

    sut = GetXAddExpensePresenter(loadPeriod: loadPeriods);
  });

  test('Should call LoadPeriods on load periods', () async {
    await sut.loadPeriods();
    verify(() => loadPeriods.load()).called(1);
  });
}
