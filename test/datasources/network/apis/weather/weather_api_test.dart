import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import '../mocks/dio_mock.dart';

void main() {
  group(WeatherApi, () {
    late MockDio mockDio;
    late WeatherApi api;
    setUpAll(() {
      registerFallbackValue(RequestOptions());
    });
    setUp(() {
      mockDio = MockDio();
      when(() => mockDio.options).thenReturn(BaseOptions());
      api = WeatherApi(mockDio);
    });

    test('can be instantiated', () {
      expect(api, isNotNull);
    });

    group('.fetchWeather', () {
      const latitude = 90.0;
      const longitude = 80.0;
      final response =
          Response(requestOptions: RequestOptions(), data: <String, dynamic>{});
      test(
          'should return the response when calling the endpoint '
          '"/data/3.0/onecall" successfully', () async {
        when(() => mockDio.fetch<dynamic>(any()))
            .thenAnswer((_) async => response);
        final httpResponse = await api.fetchWeather(
          latitude: latitude,
          longitude: longitude,
        );
        expect(httpResponse.data, response.data);
        verify(
          () => mockDio.fetch<dynamic>(
            any(
              that: isA<RequestOptions>().having(
                (options) => options.path,
                'path',
                equals('/data/3.0/onecall'),
              ),
            ),
          ),
        ).called(1);
      });
      test('should throw exception when calling the point fails', () {
        when(() => mockDio.fetch<dynamic>(any()))
            .thenThrow(DioException(requestOptions: RequestOptions()));
        expect(
          () => api.fetchWeather(latitude: latitude, longitude: longitude),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
