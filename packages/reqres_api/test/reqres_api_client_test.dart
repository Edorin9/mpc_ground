import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:reqres_api/reqres_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('ReqresApiClient', () {
    late http.Client httpClient;
    late ReqresApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = ReqresApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ReqresApiClient(), isNotNull);
      });
    });
  });
}
