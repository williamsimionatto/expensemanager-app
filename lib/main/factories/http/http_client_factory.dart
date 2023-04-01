import 'package:http/http.dart';

import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/infra/http/http.dart';

HttpClient makeHttpAdapter() {
  return HttpAdapter(Client());
}
