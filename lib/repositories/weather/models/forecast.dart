/// {@template forecast}
/// The information of forecast.
/// {@endtemplate}
final class Forecast {
  /// {@macro forecast}
  Forecast({
    required this.time,
    required this.summary,
  });

  /// Represent value of current time.
  final DateTime time;

  /// Represent the summary of this [Forecast].
  final String summary;
}
