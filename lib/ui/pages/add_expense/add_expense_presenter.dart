import 'package:expensemanagerapp/ui/pages/pages.dart';

import 'package:expensemanagerapp/ui/helpers/errors/errors.dart';

abstract class AddExpensePresenter {
  Future<void> loadPeriods();
  Future<void> loadPeriodCategories(String periodId);
  Future<void> add();

  Stream<List<PeriodViewModel>?> get periodsStream;
  Stream<List<PeriodCategoryViewModel>?> get periodCategoriesStream;

  Stream<bool?>? get isFormValidStream;
  Stream<UIError?>? get mainErrorStream;
  Stream<bool?>? get isLoadingStream;

  Stream<UIError?>? get periodErrorStream;
  Stream<UIError?>? get categoryErrorStream;
  Stream<UIError?>? get descriptionErrorStream;
  Stream<UIError?>? get amountErrorStream;
  Stream<UIError?>? get dateErrorStream;

  Stream<String?>? get successMessageStream;

  void validatePeriod(String periodId);
  void validateCategory(String categoryId);
  void validateDescription(String description);
  void validateAmount(String amount);
  void validateDate(String date);
}
