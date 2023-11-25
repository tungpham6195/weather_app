import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import '../json/weather_json.dart';

void main() {
  group(WeatherModel, () {
    test('can be deserializable', () {
      expect(WeatherModel.fromJson(weatherJson), isNotNull);
    });
  });
}
