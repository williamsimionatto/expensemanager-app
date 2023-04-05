import 'package:expensemanagerapp/data/http/http.dart';

class RemoteLoadPeriodCategories {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPeriodCategories({required this.url, required this.httpClient});

  Future<void> load(String periodId) async {
    final uri = '$url/$periodId/category';
    await httpClient.request(url: uri, method: 'get');
  }
}
