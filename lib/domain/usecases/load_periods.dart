import 'package:expensemanagerapp/domain/entities/entities.dart';

abstract class LoadPeriods {
  Future<List<PeriodEntity>> load();
}
