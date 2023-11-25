import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/cores/cores.dart';
import 'package:weather_app/repositories/repositories.dart';

part 'home_state.dart';

/// {@template home_cubit}
/// The state management for home screen.
/// {@endtemplate}
class HomeCubit extends Cubit<HomeState> {
  /// {@macro home_cubit}
  HomeCubit({
    required WeatherRepository weatherRepository,
    required LocationRepository locationRepository,
  })  : _weatherRepository = weatherRepository,
        _locationRepository = locationRepository,
        super(HomeState());
  final WeatherRepository _weatherRepository;
  final LocationRepository _locationRepository;

  Future<Weather> _loadWeather({
    required double latitude,
    required double longitude,
  }) async {
    return _weatherRepository.getCurrentWeather(
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Load information for default location.
  void loadCurrentWeather() => searchLocation(locationName: 'Ho Chi Minh');

  /// Search location and load corresponding weather.
  Future<void> searchLocation({required String locationName}) async {
    try {
      emit(state.copyWith(status: DataLoadStatus.loading, errorMessage: ''));
      final location =
          (await _locationRepository.findLocation(name: locationName)).first;
      final weather = await _loadWeather(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      emit(state.copyWith(status: DataLoadStatus.success, weather: weather));
    } on UnauthorizedRequestException {
      emit(
        state.copyWith(
          status: DataLoadStatus.failure,
          errorMessage: 'Unauthorized',
        ),
      );
    } on NoCurrentWeatherException {
      emit(
        state.copyWith(
          status: DataLoadStatus.failure,
          errorMessage: 'No data',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DataLoadStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      );
    }
  }
}
