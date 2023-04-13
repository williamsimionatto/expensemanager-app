import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

class LoadPeriodsSpy extends Mock implements LoadPeriods {
  When mockLoadPeriodsCall() => when(() => load());

  void mockLoadPeriods(List<PeriodEntity> periods) {
    mockLoadPeriodsCall().thenAnswer((_) async => periods);
  }

  void mockLoadPeriodsError(DomainError error) {
    mockLoadPeriodsCall().thenThrow(error);
  }
}
