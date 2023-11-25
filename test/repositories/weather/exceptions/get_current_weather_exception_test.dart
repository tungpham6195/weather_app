import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(GetCurrentWeatherException, () {
    test('can be instantiated', () {
      expect(GetCurrentWeatherException(), isNotNull);
    });
  });
}
