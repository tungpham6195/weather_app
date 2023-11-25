import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test/test.dart';
import 'package:weather_app/datasources/datasources.dart';

import 'json/location_json.dart';

class _MockLocationApi extends Mock implements LocationApi {}

void main() {
  group(LocationDatasource, () {
    late _MockLocationApi mockLocationApi;
    late LocationDatasource datasource;
    setUp(() {
      mockLocationApi = _MockLocationApi();
      datasource = LocationDatasourceImpl(mockLocationApi);
    });
    group('.fetchCoordinates', () {
      const query = 'London';
      test(
          'should return list of location model when calling '
          'LocationApi.fetchCoordinates() successfully', () async {
        when(() => mockLocationApi.fetchCoordinates(query: any(named: 'query')))
            .thenAnswer(
          (_) async => HttpResponse(
            locationsJson,
            Response(requestOptions: RequestOptions()),
          ),
        );
        final response = await datasource.fetchCoordinates(query: query);
        expect(response, hasLength(1));
        verify(
          () => mockLocationApi.fetchCoordinates(
            query: any(named: 'query', that: equals(query)),
          ),
        ).called(1);
      });
      test(
          'should throws $UnauthorizedException when calling '
          'LocationApi.fetchCoordinates() returns error code is 401', () async {
        when(() => mockLocationApi.fetchCoordinates(query: any(named: 'query')))
            .thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              statusCode: HttpStatus.unauthorized,
            ),
          ),
        );
        expect(
          () => datasource.fetchCoordinates(query: query),
          throwsA(isA<UnauthorizedException>()),
        );
      });
      test(
          'should throws an exception when calling '
          'LocationApi.fetchCoordinates() throws an error', () async {
        when(() => mockLocationApi.fetchCoordinates(query: any(named: 'query')))
            .thenThrow(DioException(requestOptions: RequestOptions()));
        expect(
          () => datasource.fetchCoordinates(query: query),
          throwsA(
            isA<Exception>().having(
              (exception) => exception.toString(),
              'message',
              equals('Exception: '
                  'Error when calling API to fetch location coordinates!'),
            ),
          ),
        );
      });
    });
  });
}
