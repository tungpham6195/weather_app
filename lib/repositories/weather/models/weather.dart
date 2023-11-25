import 'package:weather_app/repositories/weather/models/models.dart';

/// {@template weather}
/// The information of current weather.
/// {@endtemplate}
final class Weather {
  /// {@macro weather}
  Weather({
    required this.time,
    required this.temperature,
    this.forecasts = const [],
  });

  /// Represent value of current time.
  final DateTime time;

  /// Represent value of current temperature.
  final double temperature;

  /// Represent the list of forecast for the next days.
  final List<Forecast> forecasts;
}
