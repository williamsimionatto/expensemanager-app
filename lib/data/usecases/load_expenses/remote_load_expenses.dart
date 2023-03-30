import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/remote_expense_model.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/usecases/usecase.dart';

class RemoteLoadExpenses implements LoadExpenses {
  final String url;
  final HttpClient httpClient;

  RemoteLoadExpenses({required this.url, required this.httpClient});

  @override
  Future<List<ExpenseEntity>> load() async {
    final httpResponse = await httpClient.request(url: url, method: 'get');

    return httpResponse
        .map<ExpenseEntity>(
            (json) => RemoteExpenseModel.fromJson(json).toEntity())
        .toList();
  }
}
