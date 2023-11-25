import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/datasources/network/apis/apis.dart';
import 'package:weather_app/datasources/network/sources/exceptions/exceptions.dart';
import 'package:weather_app/datasources/network/sources/weather/source.dart';

/// {@template weather_datasource_impl}
/// The implementation of [WeatherDatasource].
/// {@endtemplate}
final class WeatherDatasourceImpl implements WeatherDatasource {
  /// {@macro weather_datasource_impl}
  WeatherDatasourceImpl(this._api);

  final WeatherApi _api;

  @override
  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
    String? units,
  }) async {
    try {
      final response = await _api.fetchWeather(
        latitude: latitude,
        longitude: longitude,
        units: units,
      );

      return WeatherModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == HttpStatus.notFound) {
        throw NoWeatherDataException();
      }
      throw Exception('Error when calling API to fetch weather data!');
    }
  }
}
