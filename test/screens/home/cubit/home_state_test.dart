import 'package:test/test.dart';
import 'package:weather_app/cores/cores.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:weather_app/screens/home/cubit/home_cubit.dart';

void main() {
  group(HomeState, () {
    late HomeState instance;
    setUp(() {
      instance = HomeState();
    });
    test('can be instantiated', () {
      expect(instance.status, DataLoadStatus.loading);
      expect(instance.weather, isNull);
    });
    test('can be comparable', () {
      expect(
        instance.props,
        orderedEquals(
          [instance.status, instance.weather, instance.errorMessage],
        ),
      );
    });
    test('can be modifiable', () {
      final weather = Weather(time: DateTime.now(), temperature: 129);
      const errorMessage = 'errorMessage';
      expect(
        instance.copyWith(
          status: DataLoadStatus.failure,
          weather: weather,
          errorMessage: errorMessage,
        ),
        HomeState(
          status: DataLoadStatus.failure,
          weather: weather,
          errorMessage: errorMessage,
        ),
      );
      expect(instance.copyWith(), instance);
    });
  });
}
