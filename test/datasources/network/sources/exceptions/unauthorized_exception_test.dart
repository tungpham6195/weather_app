import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

void main() {
  group(UnauthorizedException, () {
    test('can be instantiated', () {
      expect(UnauthorizedException(), isNotNull);
    });
  });
}
