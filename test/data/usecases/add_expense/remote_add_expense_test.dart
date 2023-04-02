import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/usecases/usecases.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late RemoteAddExpense sut;
  late HttpClientSpy httpClient;
  late String url;
  late AddExpenseParams params;
  late Map apiResult;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAddExpense(url: url, httpClient: httpClient);
    params = ParamsFactory.makeAddExpenseParams();
    apiResult = ApiFactory.makeExpense();
    httpClient.mockRequest(apiResult);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(
      () => httpClient.request(url: url, method: 'post', body: {
        'description': params.description,
        'amount': params.amount,
        'date': params.date,
        'category_id': params.categoryId,
        'period_id': params.periodId,
      }),
    );
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);
    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});

    final future = sut.add(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return an Expense if HttpClient returns 200', () async {
    final expense = await sut.add(params);
    expect(expense.id, apiResult['id']);
    expect(expense.description, apiResult['description']);
    expect(expense.amount, apiResult['amount']);
    expect(expense.date, apiResult['date']);
  });
}
