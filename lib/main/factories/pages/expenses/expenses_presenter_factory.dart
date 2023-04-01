import 'package:expensemanagerapp/main/factories/usecases/usecases.dart';
import 'package:expensemanagerapp/presentation/presenter/presenter.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

ExpensesPresenter makeGetxExpensesPresenter() =>
    GetxExpensesPresenter(loadExpenses: makeRemoteLoadExpenses());
