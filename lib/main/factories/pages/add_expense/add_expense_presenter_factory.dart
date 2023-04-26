import 'package:expensemanagerapp/main/factories/pages/pages.dart';
import 'package:expensemanagerapp/main/factories/usecases/usecases.dart';
import 'package:expensemanagerapp/presentation/presenter/presenter.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

AddExpensePresenter makeGetxAddExpensePresenter() => GetXAddExpensePresenter(
      addExpense: makeRemoteAddExpense(),
      validation: makeAddExpenseValidation(),
      loadPeriod: makeRemoteLoadPeriods(),
      loadPeriodCategory: makeRemoteLoadPeriodCategories(),
    );
