import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import '../json/weather_json.dart';

void main() {
  group(WeatherDataModel, () {
    test('can be deserializable', () {
      final instance = WeatherDataModel.fromJson(weatherDataJson);
      expect(instance.time, DateTime.fromMillisecondsSinceEpoch(time));
      expect(instance.temperature, temperature);
    });
  });
}
