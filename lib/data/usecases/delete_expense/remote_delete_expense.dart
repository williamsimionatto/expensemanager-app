import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

class RemoteDeleteExpense implements DeleteExpense {
  final String url;
  final HttpClient httpClient;

  RemoteDeleteExpense({required this.url, required this.httpClient});

  @override
  Future<void> delete({required String id}) async {
    try {
      await httpClient.request(url: '$url/$id', method: 'delete');
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
