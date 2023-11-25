// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastModel _$ForecastModelFromJson(Map<String, dynamic> json) =>
    ForecastModel(
      time: _parseDateTime(json['dt'] as int),
      summary: json['summary'] as String,
    );
