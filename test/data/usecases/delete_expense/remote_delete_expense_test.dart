import 'package:expensemanagerapp/data/http/http_error.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/usecases/usecases.dart';
import '../../mocks/mocks.dart';

void main() {
  late RemoteDeleteExpense sut;
  late HttpClientSpy httpClient;
  late String url;
  late String id;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteDeleteExpense(url: url, httpClient: httpClient);
    id = faker.randomGenerator.string(24);
    httpClient.mockRequest(null);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.delete(id: id);

    verify(
      () => httpClient.request(url: '$url/$id', method: 'delete'),
    );
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.delete(id: id);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.delete(id: id);
    expect(future, throwsA(DomainError.unexpected));
  });
}
