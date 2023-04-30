import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientSpy extends Mock implements Client {
  ClientSpy() {
    mockGet(200);
    mockPost(200);
    mockDelete(200);
  }

  When mockGetCall() =>
      when(() => this.get(any(), headers: any(named: 'headers')));
  void mockGet(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockGetCall().thenAnswer((_) async => Response(body, statusCode));
  void mockGetError() => mockGetCall().thenThrow(Exception());

  When mockPostCall() => when(() => this
      .post(any(), body: any(named: 'body'), headers: any(named: 'headers')));
  void mockPost(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockPostCall().thenAnswer((_) async => Response(body, statusCode));
  void mockPostError() => mockPostCall().thenThrow(Exception());

  When mockDeleteCall() =>
      when(() => this.delete(any(), headers: any(named: 'headers')));
  void mockDelete(int statusCode, {String body = '{"any_key":"any_value"}'}) =>
      mockDeleteCall().thenAnswer((_) async => Response(body, statusCode));

  void mockDeleteError() => mockDeleteCall().thenThrow(Exception());
}
