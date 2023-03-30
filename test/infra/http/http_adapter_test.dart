import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/infra/http/http.dart';
import '../mocks/mocks.dart';

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  group('GET', () {
    test('Should call get with correct values', () async {
      await sut.request(url: url, method: 'get');

      verify(
        () => client.get(Uri.parse(url), headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        }),
      );
    });

    test('Should return data if get returns 200', () async {
      final httpResponse = await sut.request(url: url, method: 'get');
      expect(httpResponse, {'any_key': 'any_value'});
    });
  });
}
