import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

/// The configuration of API client.
// coverage:ignore-file
final class ApiConfig {
  static const _domain = 'https://api.openweathermap.org';

  static const _apiKey = 'ad535c3cbcb8ee3d01928d3a38baccab';

  /// The instance of API client
  static Dio client = Dio(
    BaseOptions(
      baseUrl: _domain,
    ),
  )..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          handler.next(
            options.copyWith(
              queryParameters: {
                ...options.queryParameters,
                'appid': _apiKey,
              },
            ),
          );
        },
      ),
      PrettyDioLogger(
        showCUrl: true,
        requestHeader: true,
        queryParameters: true,
        canShowLog: true,
      ),
    ]);
}
