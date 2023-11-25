part of 'home_cubit.dart';

/// {@template home_state}
/// The state of changes for home screen.
/// {@endtemplate}
final class HomeState with EquatableMixin {
  /// {@macro home_state}
  HomeState({
    this.status = DataLoadStatus.loading,
    this.weather,
    this.errorMessage = '',
  });

  /// The current status of loading progress.
  final DataLoadStatus status;

  /// The information of current weather.
  final Weather? weather;

  /// The error message while loading the data.
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        weather,
        errorMessage,
      ];

  /// Clones the instance of this [HomeState] as new instance
  HomeState copyWith({
    DataLoadStatus? status,
    Weather? weather,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
