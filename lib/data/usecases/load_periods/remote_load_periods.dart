import 'package:expensemanagerapp/data/http/http_client.dart';

class RemoteLoadPeriods {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPeriods({required this.url, required this.httpClient});

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}
