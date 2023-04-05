import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteLoadPeriods sut;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadPeriods(url: url, httpClient: httpClient);
    httpClient.mockRequest([]);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();
    verify(() => httpClient.request(url: url, method: 'get'));
  });
}
