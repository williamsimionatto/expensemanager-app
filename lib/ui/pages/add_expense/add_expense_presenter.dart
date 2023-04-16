import 'package:expensemanagerapp/ui/pages/pages.dart';

abstract class AddExpensePresenter {
  Future<void> loadPeriods();

  Stream<List<PeriodViewModel>?> get periodsStream;

  void validatePeriod(String periodId);
}
