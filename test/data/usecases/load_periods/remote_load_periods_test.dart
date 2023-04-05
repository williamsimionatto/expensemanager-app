import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/usecases/usecases.dart';

import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteLoadPeriods sut;
  late List<Map> list;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadPeriods(url: url, httpClient: httpClient);
    list = ApiFactory.makePeriodsList();
    httpClient.mockRequest(list);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();
    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return periods on 200', () async {
    final periods = await sut.load();
    expect(periods.length, 2);

    expect(periods, [
      PeriodEntity(
        id: list[0]['id'],
        name: list[0]['name'],
        startDate: list[0]['startDate'],
        endDate: list[0]['endDate'],
        budget: list[0]['budget'],
      ),
      PeriodEntity(
        id: list[1]['id'],
        name: list[1]['name'],
        startDate: list[1]['startDate'],
        endDate: list[1]['endDate'],
        budget: list[1]['budget'],
      ),
    ]);
  });
}
