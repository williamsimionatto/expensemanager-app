import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/domain/helpers/domain_error.dart';

class RemoteLoadPeriodCategories {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPeriodCategories({required this.url, required this.httpClient});

  Future<void> load(String periodId) async {
    try {
      final uri = '$url/$periodId/category';
      await httpClient.request(url: uri, method: 'get');
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
