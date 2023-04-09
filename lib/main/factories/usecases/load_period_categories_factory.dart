import 'package:expensemanagerapp/data/usecases/usecases.dart';

import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/main/factories/http/http.dart';

LoadPeriodCategories makeRemoteLoadPeriodCategories() =>
    RemoteLoadPeriodCategories(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('period'),
    );
