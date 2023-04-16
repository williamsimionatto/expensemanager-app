import 'package:expensemanagerapp/ui/pages/pages.dart';

import 'package:expensemanagerapp/ui/helpers/errors/errors.dart';

abstract class AddExpensePresenter {
  Future<void> loadPeriods();

  Stream<List<PeriodViewModel>?> get periodsStream;

  Stream<UIError?>? get periodErrorStream;

  void validatePeriod(String periodId);
}
