import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import '../json/location_json.dart';

void main() {
  group(LocationModel, () {
    test('can be deserializable', () {
      final instance = LocationModel.fromJson(locationJson);
      expect(instance.name, 'London');
      expect(instance.latitude, latitude);
      expect(instance.longitude, longitude);
    });
  });
}
