import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/datasources/network/sources/weather/models/models.dart';

part 'weather_model.g.dart';

/// {@template weather_model}
/// The model that is used to deserialize the response of weather.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
final class WeatherModel {
  /// {@macro weather_model}
  WeatherModel({required this.current, this.daily = const []});

  /// Convert the Map<String, dynamic> to an instance of [WeatherModel].
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  /// Represent the information of current weather data.
  final WeatherDataModel current;

  /// Represent list of forecasts for the next few days.
  final List<ForecastModel> daily;
}
