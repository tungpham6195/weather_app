import 'package:weather_app/datasources/datasources.dart';
import 'package:weather_app/repositories/repositories.dart';

/// The published locator instance.
final locator = _AppLocator();

final class _AppLocator {
  LocationApi get _locationApi => LocationApi(ApiConfig.client);

  WeatherApi get _weatherApi => WeatherApi(ApiConfig.client);

  LocationDatasource get _locationDatasource =>
      LocationDatasourceImpl(_locationApi);

  WeatherDatasource get _weatherDatasource =>
      WeatherDatasourceImpl(_weatherApi);

  LocationRepository get locationRepository =>
      LocationRepositoryImpl(locationDatasource: _locationDatasource);

  WeatherRepository get weatherRepository =>
      WeatherRepositoryImpl(weatherDatasource: _weatherDatasource);
}
