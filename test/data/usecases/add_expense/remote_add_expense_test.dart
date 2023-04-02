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
}