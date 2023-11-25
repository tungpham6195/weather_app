import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

void main() {
  group(NoWeatherDataException, () {
    test('can be instantiated', () {
      expect(NoWeatherDataException(), isNotNull);
    });
  });
}
