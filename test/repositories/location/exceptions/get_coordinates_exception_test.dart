import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(GetCoordinatesException, () {
    test('can be instantiated', () {
      expect(GetCoordinatesException(), isNotNull);
    });
  });
}
