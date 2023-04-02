import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/model.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

class RemoteAddExpense implements AddExpense {
  final String url;
  final HttpClient httpClient;

  RemoteAddExpense({required this.url, required this.httpClient});

  @override
  Future<ExpenseEntity> add(AddExpenseParams params) async {
    try {
      final body = RemoteAddExpenseModel.fromDomain(params).toJson();
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );

      return RemoteExpenseModel.fromJson(httpResponse).toEntity();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
