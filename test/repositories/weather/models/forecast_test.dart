import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(Forecast, () {
    final time = DateTime.now();
    const summary = 'summary';
    test('can be instantiated', () {
      expect(Forecast(time: time, summary: summary), isNotNull);
    });
  });
}
