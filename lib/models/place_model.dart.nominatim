// To parse this JSON data, do
//
//     final place = placeFromJson(jsonString);

import 'dart:convert';

List<Place> placeFromJson(String str) =>
    List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));

String placeToJson(List<Place> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Place {
  int placeId;
  String licence;
  String osmType;
  int osmId;
  String lat;
  String lon;
  String placeClass;
  String type;
  int placeRank;
  double importance;
  String addresstype;
  String name;
  String displayName;
  List<String> boundingbox;

  Place({
    required this.placeId,
    required this.licence,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.placeClass,
    required this.type,
    required this.placeRank,
    required this.importance,
    required this.addresstype,
    required this.name,
    required this.displayName,
    required this.boundingbox,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        placeId: json["place_id"],
        licence: json["licence"],
        osmType: json["osm_type"],
        osmId: json["osm_id"],
        lat: json["lat"],
        lon: json["lon"],
        placeClass: json["class"],
        type: json["type"],
        placeRank: json["place_rank"],
        importance: json["importance"]?.toDouble(),
        addresstype: json["addresstype"],
        name: json["name"],
        displayName: json["display_name"],
        boundingbox: List<String>.from(json["boundingbox"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "place_id": placeId,
        "licence": licence,
        "osm_type": osmType,
        "osm_id": osmId,
        "lat": lat,
        "lon": lon,
        "class": placeClass,
        "type": type,
        "place_rank": placeRank,
        "importance": importance,
        "addresstype": addresstype,
        "name": name,
        "display_name": displayName,
        "boundingbox": List<dynamic>.from(boundingbox.map((x) => x)),
      };
}
