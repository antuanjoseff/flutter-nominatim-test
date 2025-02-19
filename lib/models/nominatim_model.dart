import 'dart:convert';
import './place_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;

class NominatimModel {
  // static String host = 'https://nominatim.openstreetmap.org/';
  // static String search = host + 'search';
  static String host = 'https://sigserver4.udg.edu/apps/carpool/';
  static String search = host + 'api/search/municipality/';

  static String southEast = '1.250, 41.067';
  static String northWest = '5.359, 43.113';
  static int limit = 5;
  static String viewbox = '$southEast, $northWest';

  static setLimit(newlimit) {
    limit = newlimit;
  }

  static setViewBox(northEast, southWest) {
    viewbox = '$southEast, $northWest';
  }

  Future<List<Place>> fetchPlaces(name) async {
    // String url = search + '?q=$name&limit=$limit&format=json&viewbox=$viewbox';
    if (name == '') return [];
    String url = search + '$name/5?format=json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String utf8Response = Utf8Decoder().convert(response.bodyBytes);
      return placeFromJson(utf8Response);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
