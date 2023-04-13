import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class LoadPeriodsSpy extends Mock implements LoadPeriods {
  When mockLoadPeriodsCall() => when(() => load());

  void mockLoadPeriods(List<PeriodEntity> periods) {
    mockLoadPeriodsCall().thenAnswer((_) async => periods);
  }
}
