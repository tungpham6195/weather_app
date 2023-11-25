import 'package:weather_app/repositories/exceptions/exceptions.dart';
import 'package:weather_app/repositories/weather/exceptions/exceptions.dart';
import 'package:weather_app/repositories/weather/models/models.dart';

/// The repository that handles weather domain.
abstract interface class WeatherRepository {
  /// Return the information of current weather.
  ///
  /// Throw [GetCurrentWeatherException] when getting the current weather fails.
  ///
  /// Throw [UnauthorizedRequestException] when sending the request is
  /// unauthorized.
  ///
  /// Throw [NoCurrentWeatherException] when there is no information for current
  /// weather.
  Future<Weather> getCurrentWeather({
    required double latitude,
    required double longitude,
  });
}
