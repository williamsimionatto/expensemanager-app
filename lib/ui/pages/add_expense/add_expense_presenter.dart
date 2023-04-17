import 'package:expensemanagerapp/ui/pages/pages.dart';

import 'package:expensemanagerapp/ui/helpers/errors/errors.dart';

abstract class AddExpensePresenter {
  Future<void> loadPeriods();
  Future<void> loadPeriodCategories(String periodId);

  Stream<List<PeriodViewModel>?> get periodsStream;
  Stream<List<PeriodCategoryViewModel>?> get periodCategoriesStream;

  Stream<bool?>? get isFormValidStream;

  Stream<UIError?>? get periodErrorStream;
  Stream<UIError?>? get categoryErrorStream;
  Stream<UIError?>? get descriptionErrorStream;
  Stream<UIError?>? get amountErrorStream;
  Stream<UIError?>? get dateErrorStream;

  void validatePeriod(String periodId);
  void validateCategory(String categoryId);
  void validateDescription(String description);
  void validateAmount(String amount);
  void validateDate(String date);
}
