import 'package:expensemanagerapp/data/http/http.dart';

class RemoteDeleteExpense {
  final String url;
  final HttpClient httpClient;

  RemoteDeleteExpense({required this.url, required this.httpClient});

  Future<void> delete({required String id}) async {
    await httpClient.request(url: '$url/$id', method: 'delete');
  }
}
