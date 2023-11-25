import 'package:weather_app/datasources/network/sources/exceptions/exceptions.dart';
import 'package:weather_app/datasources/network/sources/weather/exceptions/exceptions.dart';
import 'package:weather_app/datasources/network/sources/weather/models/models.dart';

/// The network datasource for getting the data which is relevant to
/// weather.
abstract interface class WeatherDatasource {
  /// Return the information of current weather.
  ///
  /// Throw [UnauthorizedException] if calling the API returns 401.
  ///
  /// Throw [NoWeatherDataException] if calling the API returns 404.
  ///
  /// Throw [Exception] if calling the API fails for some reasons.
  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
    String? units,
  });
}
