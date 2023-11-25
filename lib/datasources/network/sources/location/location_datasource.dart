import 'package:weather_app/datasources/network/sources/exceptions/exceptions.dart';
import 'package:weather_app/datasources/network/sources/location/models/models.dart';

/// The network datasource for getting the data which is relevant to
/// location.
abstract interface class LocationDatasource {
  /// Return the list of location coordinates by location name.
  ///
  /// Throw [Exception] if calling the API fails for some reasons.
  ///
  /// Throw [UnauthorizedException] if calling the API returns 401.
  Future<List<LocationModel>> fetchCoordinates({required String query});
}
