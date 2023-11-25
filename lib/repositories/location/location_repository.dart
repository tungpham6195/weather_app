import 'package:weather_app/repositories/exceptions/exceptions.dart';
import 'package:weather_app/repositories/location/exceptions/exceptions.dart';
import 'package:weather_app/repositories/location/models/models.dart';

/// The repository that handles location domain.
abstract interface class LocationRepository {
  /// Return list of location coordinates by location name.
  ///
  /// Throw [GetCoordinatesException] when getting the list of location
  /// coordinates fails.
  ///
  /// Throw [UnauthorizedRequestException] when sending the request is
  /// unauthorized.
  Future<List<Location>> findLocation({required String name});
}
