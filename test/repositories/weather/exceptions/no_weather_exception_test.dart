import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(NoCurrentWeatherException, () {
    test('can be instantiated', () {
      expect(NoCurrentWeatherException(), isNotNull);
    });
  });
}
