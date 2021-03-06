// @dart=2.9
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyAM4wvYJHLXvLJgPJqP5Nw7a5O_JergRL0',
        //AIzaSyAM4wvYJHLXvLJgPJqP5Nw7a5O_JergRL0 other key,
        // my key AIzaSyBk109khDx6olukwmQaYXf-b9I3Sf3vP-4
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
