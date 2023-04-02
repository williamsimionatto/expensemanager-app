import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/model.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

class RemoteAddExpense {
  final String url;
  final HttpClient httpClient;

  RemoteAddExpense({required this.url, required this.httpClient});

  Future<void> add(AddExpenseParams params) async {
    final body = RemoteAddExpenseModel.fromDomain(params).toJson();
    await httpClient.request(
      url: url,
      method: 'post',
      body: body,
    );
  }
}
