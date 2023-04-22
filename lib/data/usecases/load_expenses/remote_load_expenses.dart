import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/model.dart';

class RemoteLoadExpenses implements LoadExpenses {
  final String url;
  final HttpClient httpClient;

  RemoteLoadExpenses({required this.url, required this.httpClient});

  @override
  Future<List<ExpenseEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');

      return httpResponse
          .map<ExpenseEntity>(
              (json) => RemoteExpenseModel.fromJson(json).toEntity())
          .toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
