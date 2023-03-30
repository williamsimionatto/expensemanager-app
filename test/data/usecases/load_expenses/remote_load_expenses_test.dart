import 'package:expensemanagerapp/domain/entities/expense_entity.dart';
import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/usecases/usecases.dart';

import '../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteLoadExpenses sut;
  late List<Map> list;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    sut = RemoteLoadExpenses(url: url, httpClient: httpClient);
    list = ApiFactory.makeExpensesList();
    httpClient.mockRequest(list);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();
    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return expenses on 200', () async {
    final expenses = await sut.load();

    expect(expenses.length, 2);
    expect(expenses, [
      ExpenseEntity(
        id: list[0]['id'],
        description: list[0]['description'],
        amount: list[0]['amount'],
        date: list[0]['date'],
      ),
      ExpenseEntity(
        id: list[1]['id'],
        description: list[1]['description'],
        amount: list[1]['amount'],
        date: list[1]['date'],
      ),
    ]);
  });

  test(
      'Should return UnexpectError if HttpClient returns 200 with invalid data',
      () async {
    httpClient.mockRequest(ApiFactory.makeInvalidList());
    final future = sut.load();
    expect(future, throwsA(DomainError.unexpected));
  });
}
