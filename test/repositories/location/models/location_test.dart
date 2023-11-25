import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(Location, () {
    const name = 'London';
    const latitude = 51.5073219;
    const longitude = -0.1276474;
    test('can be instantiated', () {
      expect(
        Location(name: name, latitude: latitude, longitude: longitude),
        isNotNull,
      );
    });
  });
}
