import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(Forecast, () {
    final time = DateTime.now();
    const temperature = 292.87;
    test('can be instantiated', () {
      expect(Weather(time: time, temperature: temperature), isNotNull);
    });
  });
}
