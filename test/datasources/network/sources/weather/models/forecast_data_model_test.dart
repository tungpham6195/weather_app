import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import '../json/weather_json.dart';

void main() {
  group(ForecastModel, () {
    test('can be deserializable', () {
      final instance = ForecastModel.fromJson(forecastJson);
      expect(instance.time, DateTime.fromMillisecondsSinceEpoch(forecastTime));
      expect(instance.summary, forecastSummary);
    });
  });
}
