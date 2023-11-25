import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/datasources/network/apis/apis.dart';
import 'package:weather_app/datasources/network/sources/exceptions/exceptions.dart';
import 'package:weather_app/datasources/network/sources/location/location_datasource.dart';
import 'package:weather_app/datasources/network/sources/location/models/location_model.dart';

/// {@template location_datasource_impl}
/// The implementation of [LocationDatasource].
/// {@endtemplate}
final class LocationDatasourceImpl implements LocationDatasource {
  /// {@macro location_datasource_impl}
  LocationDatasourceImpl(this._api);

  final LocationApi _api;

  @override
  Future<List<LocationModel>> fetchCoordinates({required String query}) async {
    try {
      final response = await _api.fetchCoordinates(query: query);
      return (response.data as List<dynamic>)
          .map((item) => LocationModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        throw UnauthorizedException();
      }
      throw Exception(
        'Error when calling API to fetch location coordinates!',
      );
    }
  }
}
