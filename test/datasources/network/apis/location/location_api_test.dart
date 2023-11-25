import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import '../mocks/dio_mock.dart';

void main() {
  group(LocationApi, () {
    late MockDio mockDio;
    late LocationApi api;
    setUpAll(() {
      registerFallbackValue(RequestOptions());
    });

    setUp(() {
      mockDio = MockDio();
      when(() => mockDio.options).thenReturn(BaseOptions());
      api = LocationApi(mockDio);
    });

    test('can be instantiated', () {
      expect(api, isNotNull);
    });

    group('.fetchCoordinates', () {
      final response =
          Response(requestOptions: RequestOptions(), data: <dynamic>[]);
      const query = 'London';
      test(
          'should return the response when calling the endpoint '
          '"/geo/1.0/direct" successfully', () async {
        when(() => mockDio.fetch<dynamic>(any()))
            .thenAnswer((_) async => response);
        final httpResponse = await api.fetchCoordinates(query: query);
        expect(httpResponse.data, response.data);
        verify(
          () => mockDio.fetch<dynamic>(
            any(
              that: isA<RequestOptions>().having(
                (options) => options.path,
                'path',
                equals('/geo/1.0/direct'),
              ),
            ),
          ),
        ).called(1);
      });
      test('should throw exception when calling the point fails', () {
        when(() => mockDio.fetch<dynamic>(any()))
            .thenThrow(DioException(requestOptions: RequestOptions()));
        expect(
          () => api.fetchCoordinates(query: query),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
