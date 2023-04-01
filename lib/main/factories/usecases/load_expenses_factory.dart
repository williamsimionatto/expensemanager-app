import 'package:expensemanagerapp/domain/usecases/usecases.dart';
import 'package:expensemanagerapp/data/usecases/usecases.dart';

import 'package:expensemanagerapp/main/factories/http/http.dart';

LoadExpenses makeRemoteLoadExpenses() => RemoteLoadExpenses(
      url: makeApiUrl('expenses'),
      httpClient: makeHttpAdapter(),
    );
