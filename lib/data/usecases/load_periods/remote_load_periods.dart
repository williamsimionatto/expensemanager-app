import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';

class RemoteLoadPeriods {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPeriods({required this.url, required this.httpClient});

  Future<void> load() async {
    try {
      await httpClient.request(url: url, method: 'get');
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
