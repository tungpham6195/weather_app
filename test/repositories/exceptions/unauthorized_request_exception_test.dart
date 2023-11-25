import 'package:test/test.dart';
import 'package:weather_app/repositories/repositories.dart';

void main() {
  group(UnauthorizedRequestException, () {
    test('can be instantiated', () {
      expect(UnauthorizedRequestException(), isNotNull);
    });
  });
}
