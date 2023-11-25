import 'package:json_annotation/json_annotation.dart';

part 'weather_data_model.g.dart';

/// {@template weather_data_model}
/// The model that is used to deserialize the response of weather data.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
final class WeatherDataModel {
  /// {@macro weather_data_model}
  WeatherDataModel({required this.time, required this.temperature});

  /// Convert the Map<String, dynamic> to an instance of [WeatherDataModel].
  factory WeatherDataModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataModelFromJson(json);

  /// Represent the value of current time.
  @JsonKey(name: 'dt', fromJson: _parseDateTime)
  final DateTime time;

  /// Represent the value of temperature.
  @JsonKey(name: 'feels_like')
  final double temperature;
}

DateTime _parseDateTime(int json) => DateTime.fromMillisecondsSinceEpoch(json);
