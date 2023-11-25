import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';
import 'package:weather_app/repositories/repositories.dart';

class _MockWeatherDatasource extends Mock implements WeatherDatasource {}

void main() {
  group(WeatherRepository, () {
    late _MockWeatherDatasource mockWeatherDatasource;
    late WeatherRepository repository;

    setUp(() {
      mockWeatherDatasource = _MockWeatherDatasource();
      repository =
          WeatherRepositoryImpl(weatherDatasource: mockWeatherDatasource);
    });
    group('.getCurrentWeather', () {
      const latitude = 70.0;
      const longitude = -70.0;
      final weatherModel = WeatherModel(
        current: WeatherDataModel(time: DateTime.now(), temperature: 129.1),
        daily: [ForecastModel(time: DateTime.now(), summary: 'summary')],
      );
      test(
          'should return current weather when calling '
          'WeatherDatasource.fetchWeather() successfully', () async {
        when(
          () => mockWeatherDatasource.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weatherModel);
        final weather = await repository.getCurrentWeather(
          latitude: latitude,
          longitude: longitude,
        );
        expect(weather.time, weatherModel.current.time);
        expect(weather.temperature, weatherModel.current.temperature);
        expect(weather.forecasts.first.time, weatherModel.daily.first.time);
        expect(
          weather.forecasts.first.summary,
          weatherModel.daily.first.summary,
        );
        verify(
          () => mockWeatherDatasource.fetchWeather(
            latitude: any(named: 'latitude', that: equals(latitude)),
            longitude: any(named: 'longitude', that: equals(longitude)),
          ),
        ).called(1);
      });
      test(
          'should throw $UnauthorizedRequestException when calling '
          'WeatherDatasource.fetchWeather() throws $UnauthorizedException',
          () async {
        when(
          () => mockWeatherDatasource.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(UnauthorizedException());
        expect(
          () => repository.getCurrentWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<UnauthorizedRequestException>()),
        );
      });
      test(
          'should throw $NoCurrentWeatherException when calling '
          'WeatherDatasource.fetchWeather() throws $NoWeatherDataException',
          () async {
        when(
          () => mockWeatherDatasource.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(NoWeatherDataException());
        expect(
          () => repository.getCurrentWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<NoCurrentWeatherException>()),
        );
      });
      test(
          'should throw $GetCurrentWeatherException when calling '
          'WeatherDatasource.fetchWeather() throws an exception', () async {
        when(
          () => mockWeatherDatasource.fetchWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.getCurrentWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<GetCurrentWeatherException>()),
        );
      });
    });
  });
}
