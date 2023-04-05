import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/model.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';

class RemoteLoadPeriods {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPeriods({required this.url, required this.httpClient});

  Future<List<PeriodEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');

      return httpResponse
          .map<PeriodEntity>(
              (json) => RemotePeriodModel.fromJson(json).toEntity())
          .toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
