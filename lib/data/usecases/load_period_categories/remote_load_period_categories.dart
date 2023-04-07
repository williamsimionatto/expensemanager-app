import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/model.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

class RemoteLoadPeriodCategories implements LoadPeriodCategories {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPeriodCategories({required this.url, required this.httpClient});

  @override
  Future<List<PeriodCategoryEntity>> load(String periodId) async {
    try {
      final uri = '$url/$periodId/category';
      final httpResponse = await httpClient.request(url: uri, method: 'get');

      final List<PeriodCategoryEntity> periodCategories = httpResponse
          .map<PeriodCategoryEntity>(
            (json) => RemotePeriodCategoryModel.fromJson(json).toEntity(),
          )
          .toList();

      return periodCategories;
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
