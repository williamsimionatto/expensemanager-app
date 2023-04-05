import 'package:expensemanagerapp/data/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/mocks.dart';

void main() {
  late String url;
  late String periodId;
  late HttpClientSpy httpClient;
  late RemoteLoadPeriodCategories sut;
  late List<Map> list;

  setUp(() {
    url = faker.internet.httpUrl();
    periodId = faker.randomGenerator.integer(10, min: 1).toString();
    httpClient = HttpClientSpy();
    sut = RemoteLoadPeriodCategories(url: url, httpClient: httpClient);
    list = [];
    httpClient.mockRequest(list);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load(periodId);
    verify(
      () => httpClient.request(url: '$url/$periodId/category', method: 'get'),
    );
  });
}
