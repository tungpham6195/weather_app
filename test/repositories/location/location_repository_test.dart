import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';
import 'package:weather_app/repositories/repositories.dart';

class _MockLocationDatasource extends Mock implements LocationDatasource {}

void main() {
  group(LocationRepository, () {
    late _MockLocationDatasource mockLocationDatasource;
    late LocationRepository repository;
    const locationName = 'locationName';
    final locationModels = [
      LocationModel(name: 'name', latitude: 80, longitude: -90),
    ];
    setUp(() {
      mockLocationDatasource = _MockLocationDatasource();
      repository =
          LocationRepositoryImpl(locationDatasource: mockLocationDatasource);
      when(
        () => mockLocationDatasource.fetchCoordinates(
          query: any(named: 'query'),
        ),
      ).thenAnswer((_) async => locationModels);
    });
    group('.findLocation', () {
      test(
          'should return list of locations when calling '
          'LocationDatasource.fetchCoordinates() successfully', () async {
        final locations = await repository.findLocation(name: locationName);
        expect(locations.first.name, locationModels.first.name);
        expect(locations.first.latitude, locationModels.first.latitude);
        expect(locations.first.longitude, locationModels.first.longitude);
        verify(
          () => mockLocationDatasource.fetchCoordinates(
            query: any(named: 'query', that: equals(locationName)),
          ),
        ).called(1);
      });
      test(
          'should throw $UnauthorizedRequestException when calling '
          'LocationDatasource.fetchCoordinates() throws $UnauthorizedException',
          () async {
        when(
          () => mockLocationDatasource.fetchCoordinates(
            query: any(named: 'query'),
          ),
        ).thenThrow(UnauthorizedException());
        expect(
          () => repository.findLocation(name: locationName),
          throwsA(isA<UnauthorizedRequestException>()),
        );
      });
      test(
          'should throw $GetCoordinatesException when calling '
          'LocationDatasource.fetchCoordinates() throws an exception',
          () async {
        when(
          () => mockLocationDatasource.fetchCoordinates(
            query: any(named: 'query'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.findLocation(name: locationName),
          throwsA(isA<GetCoordinatesException>()),
        );
      });
    });
  });
}
