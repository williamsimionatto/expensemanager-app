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

    try {
      final uri = Uri.parse(url);
      if (method == 'get') {
        await client.get(uri, headers: defaultHeaders);
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return null;
  }
}
