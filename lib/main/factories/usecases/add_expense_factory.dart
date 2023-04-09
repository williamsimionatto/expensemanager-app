import 'package:expensemanagerapp/data/usecases/usecases.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/main/factories/http/http.dart';

AddExpense makeRemoteAddExpense() => RemoteAddExpense(
      url: makeApiUrl('expense'),
      httpClient: makeHttpAdapter(),
    );
