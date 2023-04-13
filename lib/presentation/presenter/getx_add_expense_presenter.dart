import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetXAddExpensePresenter implements AddExpensePresenter {
  final LoadPeriods loadPeriod;

  GetXAddExpensePresenter({required this.loadPeriod});

  @override
  Future<void> loadPeriods() async {
    await loadPeriod.load();
  }
}
