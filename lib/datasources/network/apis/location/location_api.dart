import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'location_api.g.dart';

const _path = '/geo/1.0';

/// {@template location_api}
/// The endpoints for location domain.
/// {@endtemplate}
@RestApi()
abstract interface class LocationApi {
  /// {@macro location_api}
  factory LocationApi(Dio dio) = _LocationApi;

  /// Return the json response of coordinates by location name.
  ///
  /// Throw [DioException] if calling the endpoint fails for some reasons.
  @GET('$_path/direct')
  Future<HttpResponse<dynamic>> fetchCoordinates({
    @Query('q') required String query,
  });
}
