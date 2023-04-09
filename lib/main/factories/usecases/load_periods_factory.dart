import 'package:expensemanagerapp/data/usecases/usecases.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/main/factories/http/http.dart';

LoadPeriods makeRemoteLoadPeriods() => RemoteLoadPeriods(
      url: makeApiUrl('period'),
      httpClient: makeHttpAdapter(),
    );
