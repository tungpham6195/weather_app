import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_api.g.dart';

const _path = '/data/3.0/onecall';

/// {@template weather_api}
/// The endpoints for weather domain.
/// {@endtemplate}
@RestApi()
abstract interface class WeatherApi {
  /// {@macro weather_api}
  factory WeatherApi(Dio dio) = _WeatherApi;

  /// Return the json response of current weather data.
  ///
  /// Throw [DioException] if calling the endpoint fails for some reasons.
  @GET(_path)
  Future<HttpResponse<dynamic>> fetchWeather({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('units') String? units,
  });
}
