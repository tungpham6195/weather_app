import 'package:weather_app/datasources/datasources.dart';
import 'package:weather_app/repositories/exceptions/exceptions.dart';
import 'package:weather_app/repositories/weather/exceptions/exceptions.dart';
import 'package:weather_app/repositories/weather/models/models.dart';
import 'package:weather_app/repositories/weather/weather_repository.dart';

/// {@template weather_repository_impl}
/// The implementation of [WeatherRepository].
/// {@endtemplate}
final class WeatherRepositoryImpl implements WeatherRepository {
  /// {@macro weather_repository_impl}
  const WeatherRepositoryImpl({
    required WeatherDatasource weatherDatasource,
  }) : _weatherDatasource = weatherDatasource;
  final WeatherDatasource _weatherDatasource;

  @override
  Future<Weather> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final weatherModel = await _weatherDatasource.fetchWeather(
        latitude: latitude,
        longitude: longitude,
      );
      return Weather(
        time: weatherModel.current.time,
        temperature: weatherModel.current.temperature,
        forecasts: weatherModel.daily
            .map((item) => Forecast(time: item.time, summary: item.summary))
            .toList(),
      );
    } on UnauthorizedException {
      throw UnauthorizedRequestException();
    } on NoWeatherDataException {
      throw NoCurrentWeatherException();
    } catch (e) {
      throw GetCurrentWeatherException();
    }
  }
}
