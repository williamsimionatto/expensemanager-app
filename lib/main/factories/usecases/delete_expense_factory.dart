import 'package:expensemanagerapp/data/usecases/usecases.dart';

import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/main/factories/http/http.dart';

DeleteExpense makeRemoteDeleteExpense() => RemoteDeleteExpense(
      url: makeApiUrl('expense'),
      httpClient: makeHttpAdapter(),
    );
