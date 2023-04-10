import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';

class RemoteDeleteExpense {
  final String url;
  final HttpClient httpClient;

  RemoteDeleteExpense({required this.url, required this.httpClient});

  Future<void> delete({required String id}) async {
    try {
      await httpClient.request(url: '$url/$id', method: 'delete');
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
