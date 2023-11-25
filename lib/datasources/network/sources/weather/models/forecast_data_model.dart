import 'package:json_annotation/json_annotation.dart';

part 'forecast_data_model.g.dart';

/// {@template forecast_model}
/// The model that is used to deserialize the response of forecast data.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
final class ForecastModel {
  /// {@macro forecast_model}
  ForecastModel({required this.time, required this.summary});

  /// Convert the Map<String, dynamic> to an instance of [ForecastModel].
  factory ForecastModel.fromJson(Map<String, dynamic> json) =>
      _$ForecastModelFromJson(json);

  /// Represent the value of current time.
  @JsonKey(name: 'dt', fromJson: _parseDateTime)
  final DateTime time;

  /// Represent the value of summary for forecast.
  final String summary;
}

DateTime _parseDateTime(int json) => DateTime.fromMillisecondsSinceEpoch(json);
