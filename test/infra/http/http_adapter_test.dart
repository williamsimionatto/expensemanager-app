import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:expensemanagerapp/data/http/http.dart';
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

  group('shared', () {
    test('Should throw ServerError if invalid http method is provided',
        () async {
      final future = sut.request(url: url, method: 'invalid_method');
      expect(future, throwsA(HttpError.serverError));
    });
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

    test('Should return null if get returns 200 without data', () async {
      client.mockGet(200, body: '');

      final response = await sut.request(url: url, method: 'get');
      expect(response, null);
    });

    test('Should return null if get returns 204', () async {
      client.mockGet(204, body: '');

      final response = await sut.request(url: url, method: 'get');
      expect(response, null);
    });

    test('Should return BadRequestError if get returns 400', () async {
      client.mockGet(400);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if get returns 400 with body',
        () async {
      client.mockGet(400, body: '');

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return NotFoundError if get returns 404', () async {
      client.mockGet(404);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if get returns 500', () async {
      client.mockGet(500);

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if get throws', () async {
      client.mockGetError();

      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('POST', () {
    test('Should call post with correct values', () async {
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(
        () => client.post(Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json'
            },
            body: '{"any_key":"any_value"}'),
      );

      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
        headers: {'any_header': 'any_value'},
      );

      verify(
        () => client.post(Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
              'any_header': 'any_value'
            },
            body: '{"any_key":"any_value"}'),
      );
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url), headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          }));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');
      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 without data', () async {
      client.mockPost(200, body: '');

      final response = await sut.request(url: url, method: 'post');
      expect(response, null);
    });

    test('Should return null if post returns 204', () async {
      client.mockPost(204, body: '');

      final response = await sut.request(url: url, method: 'post');
      expect(response, null);
    });

    test('Should return null if post returns 204 with data', () async {
      client.mockPost(204);

      final response = await sut.request(url: url, method: 'post');
      expect(response, null);
    });

    test('Should return BadRequestError if post returns 400', () async {
      client.mockPost(400);

      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post returns 400 with body',
        () async {
      client.mockPost(400, body: '');

      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return NotFoundError if post returns 404', () async {
      client.mockPost(404);

      final future = sut.request(url: url, method: 'post');
      expect(future, throwsA(HttpError.notFound));
    });
  });
}
