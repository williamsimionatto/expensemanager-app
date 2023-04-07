import 'package:expensemanagerapp/domain/entities/entities.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/usecases/usecases.dart';

import 'package:expensemanagerapp/domain/helpers/helpers.dart';

import '../../../infra/mocks/api_factory.dart';
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
    list = ApiFactory.makePeriodCategories();
    httpClient.mockRequest(list);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load(periodId);
    verify(
      () => httpClient.request(url: '$url/$periodId/category', method: 'get'),
    );
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.load(periodId);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.load(periodId);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return a list of period categories on 200', () async {
    final categories = await sut.load(periodId);
    expect(categories.length, 2);
    expect(categories, [
      PeriodCategoryEntity(
        id: list[0]['id'],
        category: CategoryEntity(
          id: list[0]['category']['id'],
          name: list[0]['category']['name'],
          description: list[0]['category']['description'],
        ),
        budget: list[0]['budget'],
      ),
      PeriodCategoryEntity(
        id: list[1]['id'],
        category: CategoryEntity(
          id: list[1]['category']['id'],
          name: list[1]['category']['name'],
          description: list[1]['category']['description'],
        ),
        budget: list[1]['budget'],
      ),
    ]);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest([
      {'invalid_key': 'invalid_value'}
    ]);
    final future = sut.load(periodId);
    expect(future, throwsA(DomainError.unexpected));
  });
}
