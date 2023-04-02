import 'package:expensemanagerapp/domain/entities/entities.dart';

abstract class LoadPeriodCategories {
  Future<List<PeriodCategoryEntity>> load();
}
