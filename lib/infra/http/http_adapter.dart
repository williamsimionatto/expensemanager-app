import 'dart:convert';

import 'package:http/http.dart';

import 'package:expensemanagerapp/data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
      });

    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response>? futureResponse;

    try {
      final uri = Uri.parse(url);
      if (method == 'get') {
        futureResponse = client.get(uri, headers: defaultHeaders);
      } else if (method == 'post') {
        futureResponse = client.post(
          uri,
          headers: defaultHeaders,
          body: jsonBody,
        );
      }

      if (futureResponse != null) {
        response = await futureResponse;
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
