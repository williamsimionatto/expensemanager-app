import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expensemanagerapp/data/usecases/delete_expense/delete_expense.dart';
import 'package:mocktail/mocktail.dart';
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
}
