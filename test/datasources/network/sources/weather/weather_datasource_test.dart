import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import 'json/weather_json.dart';

class _MockWeatherApi extends Mock implements WeatherApi {}

void main() {
  group(WeatherDatasource, () {
    late _MockWeatherApi mockWeatherApi;
    late WeatherDatasource datasource;
    setUp(() {
      mockWeatherApi = _MockWeatherApi();
      datasource = WeatherDatasourceImpl(mockWeatherApi);
    });
    group('.fetchWeather', () {
      const latitude = 30.0;
      const longitude = -90.0;
      test(
          'return weather model when calling '
          'WeatherApi.fetchWeather() successfully', () async {
        when(
          () => mockWeatherApi.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer(
          (_) async => HttpResponse(
            weatherJson,
            Response(requestOptions: RequestOptions()),
          ),
        );
        final weatherModel = await datasource.fetchWeather(
          latitude: latitude,
          longitude: longitude,
        );
        expect(weatherModel, isNotNull);
        verify(
          () => mockWeatherApi.fetchWeather(
            latitude: any(named: 'latitude', that: equals(latitude)),
            longitude: any(named: 'longitude', that: equals(longitude)),
          ),
        ).called(1);
      });
      test(
          'should throws $UnauthorizedException when calling '
          'WeatherApi.fetchWeather() returns error code is 401', () async {
        when(
          () => mockWeatherApi.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: HttpStatus.unauthorized,
            ),
          ),
        );
        expect(
          () =>
              datasource.fetchWeather(latitude: latitude, longitude: longitude),
          throwsA(isA<UnauthorizedException>()),
        );
      });
      test(
          'should throws $NoWeatherDataException when calling '
          'WeatherApi.fetchWeather() returns error code is 404', () async {
        when(
          () => mockWeatherApi.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: HttpStatus.notFound,
            ),
          ),
        );
        expect(
          () =>
              datasource.fetchWeather(latitude: latitude, longitude: longitude),
          throwsA(isA<NoWeatherDataException>()),
        );
      });
      test(
          'should throws an exception when calling '
          'WeatherApi.fetchWeather() throws $DioException', () async {
        when(
          () => mockWeatherApi.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions()));
        expect(
          () =>
              datasource.fetchWeather(latitude: latitude, longitude: longitude),
          throwsA(
            isA<Exception>().having(
              (exception) => exception.toString(),
              'message',
              equals(
                'Exception: Error when calling API to fetch weather data!',
              ),
            ),
          ),
        );
      });
    });
  });
}
