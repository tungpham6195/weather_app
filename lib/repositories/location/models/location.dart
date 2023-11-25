/// {@template location}
/// The information of location coordinate.
/// {@endtemplate}
final class Location {
  /// {@macro location}
  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  /// Represent value of location name.
  final String name;

  /// Represent the latitude of this [Location].
  final double latitude;

  /// Represent the longitude of this [Location].
  final double longitude;
}
