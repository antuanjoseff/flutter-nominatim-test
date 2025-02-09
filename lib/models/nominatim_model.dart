import 'dart:convert';
import './place_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NominatimModel {
  static String host = 'https://nominatim.openstreetmap.org/';
  static String search = host + 'search';

  static String southEast = '1.250, 41.067';
  static String northWest = '5.359, 43.113';
  static int limit = 15;
  static String viewbox = '$southEast, $northWest';

  static setLimit(newlimit) {
    limit = newlimit;
  }

  static setViewBox(northEast, southWest) {
    viewbox = '$southEast, $northWest';
  }

  Future<List<Place>> fetchPlaces(name) async {
    debugPrint('viewbox $viewbox');
    String url = search + '?q=$name&limit=$limit&format=json&viewbox=$viewbox';

    final response = await http.get(Uri.parse(url));
    debugPrint('${response.body}');
    if (response.statusCode == 200) {
      return placeFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
