import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

class LoadPeriodCategoriesSpy extends Mock implements LoadPeriodCategories {
  When mockLoadPeriodCategoriesCall() => when(() => load(any()));

  void mockLoadPeriodCategories(List<PeriodCategoryEntity> periodCategories) {
    mockLoadPeriodCategoriesCall().thenAnswer((_) async => periodCategories);
  }

  void mockLoadPeriodCategoriesError(DomainError error) {
    mockLoadPeriodCategoriesCall().thenThrow(error);
  }
}
