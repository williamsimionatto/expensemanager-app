import 'package:get/get.dart';

import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetXAddExpensePresenter implements AddExpensePresenter {
  final LoadPeriods loadPeriod;

  GetXAddExpensePresenter({required this.loadPeriod});

  final _periods = Rx<List<PeriodViewModel>>([]);

  @override
  Stream<List<PeriodViewModel>> get periodsStream =>
      _periods.stream.map((periods) => periods.toList());

  @override
  Future<void> loadPeriods() async {
    try {
      await loadPeriod.load();
    } catch (error) {
      _periods.subject.addError(
        DomainError.unexpected.description,
        StackTrace.empty,
      );
    }
  }
}
