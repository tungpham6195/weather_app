import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

/// {@template location_model}
/// The model that is used to deserialize the response of location.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
final class LocationModel {
  /// {@macro location_model}
  LocationModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  /// Convert the Map<String, dynamic> to an instance of [LocationModel].
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  /// Represent the value of location name.
  final String name;

  /// Represent the latitude of location.
  @JsonKey(name: 'lat')
  final double latitude;

  /// Represent the longitude of location.
  @JsonKey(name: 'lon')
  final double longitude;
}
