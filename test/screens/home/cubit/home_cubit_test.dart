import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_app/cores/cores.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:weather_app/screens/home/cubit/home_cubit.dart';

class _MockWeatherRepository extends Mock implements WeatherRepository {}

class _MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  group(HomeCubit, () {
    late _MockWeatherRepository mockWeatherRepository;
    late _MockLocationRepository mockLocationRepository;
    late HomeCubit cubit;
    final location = Location(name: 'name', latitude: 90, longitude: -70);
    final weather = Weather(time: DateTime.now(), temperature: 129);
    const locationName = 'locationName';
    setUp(() {
      mockWeatherRepository = _MockWeatherRepository();
      mockLocationRepository = _MockLocationRepository();
      cubit = HomeCubit(
        weatherRepository: mockWeatherRepository,
        locationRepository: mockLocationRepository,
      );
      when(() => mockLocationRepository.findLocation(name: any(named: 'name')))
          .thenAnswer((_) async => [location]);
      when(
        () => mockWeatherRepository.getCurrentWeather(
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        ),
      ).thenAnswer((_) async => weather);
    });
    group('.searchLocation', () {
      blocTest<HomeCubit, HomeState>(
        'should emit ${DataLoadStatus.success} when calling '
        'WeatherRepository.getCurrentWeather() successfully',
        build: () => cubit,
        seed: () => HomeState(status: DataLoadStatus.success),
        act: (cubit) => cubit.searchLocation(locationName: locationName),
        expect: () => [
          HomeState(),
          HomeState(status: DataLoadStatus.success, weather: weather),
        ],
        verify: (cubit) {
          verify(
            () => mockWeatherRepository.getCurrentWeather(
              latitude: any(named: 'latitude', that: equals(location.latitude)),
              longitude:
                  any(named: 'longitude', that: equals(location.longitude)),
            ),
          ).called(1);
          verify(
            () => mockLocationRepository.findLocation(
              name: any(named: 'name', that: equals(locationName)),
            ),
          ).called(1);
        },
      );
      blocTest<HomeCubit, HomeState>(
        'should emit ${DataLoadStatus.failure} when calling '
        'WeatherRepository.getCurrentWeather() throws '
        '$UnauthorizedRequestException',
        build: () => cubit,
        setUp: () {
          when(
            () => mockWeatherRepository.getCurrentWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
            ),
          ).thenThrow(UnauthorizedRequestException());
        },
        act: (cubit) => cubit.searchLocation(locationName: locationName),
        expect: () => [
          HomeState(),
          HomeState(
            status: DataLoadStatus.failure,
            errorMessage: 'Unauthorized',
          ),
        ],
      );
      blocTest<HomeCubit, HomeState>(
        'should emit ${DataLoadStatus.failure} when calling '
        'WeatherRepository.getCurrentWeather() throws '
        '$NoCurrentWeatherException',
        build: () => cubit,
        setUp: () {
          when(
            () => mockWeatherRepository.getCurrentWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
            ),
          ).thenThrow(NoCurrentWeatherException());
        },
        act: (cubit) => cubit.searchLocation(locationName: locationName),
        expect: () => [
          HomeState(),
          HomeState(
            status: DataLoadStatus.failure,
            errorMessage: 'No data',
          ),
        ],
      );
      blocTest<HomeCubit, HomeState>(
        'should emit ${DataLoadStatus.failure} when calling '
        'WeatherRepository.getCurrentWeather() throws '
        '$GetCurrentWeatherException',
        build: () => cubit,
        setUp: () {
          when(
            () => mockWeatherRepository.getCurrentWeather(
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
            ),
          ).thenThrow(GetCurrentWeatherException());
        },
        act: (cubit) => cubit.searchLocation(locationName: locationName),
        expect: () => [
          HomeState(),
          HomeState(
            status: DataLoadStatus.failure,
            errorMessage: 'Something went wrong',
          ),
        ],
      );
    });

    group('.loadCurrentWeather', () {
      blocTest<HomeCubit, HomeState>(
        'should emit ${DataLoadStatus.success} when calling '
        'WeatherRepository.getCurrentWeather() successfully',
        build: () => cubit,
        seed: () => HomeState(status: DataLoadStatus.success),
        act: (cubit) => cubit.loadCurrentWeather(),
        expect: () => [
          HomeState(),
          HomeState(status: DataLoadStatus.success, weather: weather),
        ],
        verify: (cubit) {
          verify(
            () => mockLocationRepository.findLocation(
              name: any(named: 'name', that: equals('Ho Chi Minh')),
            ),
          ).called(1);
        },
      );
    });
  });
}
