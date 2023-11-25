import 'package:weather_app/datasources/datasources.dart';
import 'package:weather_app/repositories/exceptions/exceptions.dart';
import 'package:weather_app/repositories/location/exceptions/exceptions.dart';
import 'package:weather_app/repositories/location/location_repository.dart';
import 'package:weather_app/repositories/location/models/models.dart';

/// {@template location_repository_impl}
/// The implementation of [LocationRepository].
/// {@endtemplate}
final class LocationRepositoryImpl implements LocationRepository {
  /// {@macro location_repository_impl}
  const LocationRepositoryImpl({
    required LocationDatasource locationDatasource,
  }) : _locationDatasource = locationDatasource;
  final LocationDatasource _locationDatasource;

  @override
  Future<List<Location>> findLocation({required String name}) async {
    try {
      final locationModels =
          await _locationDatasource.fetchCoordinates(query: name);
      return locationModels
          .map(
            (item) => Location(
              name: item.name,
              latitude: item.latitude,
              longitude: item.longitude,
            ),
          )
          .toList();
    } on UnauthorizedException {
      throw UnauthorizedRequestException();
    } catch (e) {
      throw GetCoordinatesException();
    }
  }
}
