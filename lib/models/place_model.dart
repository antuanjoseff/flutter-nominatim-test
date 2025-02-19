import 'dart:convert';

import 'package:flutter/material.dart';

List<Place> placeFromJson(String str) {
  return List<Place>.from(json.decode(str).map((x) => Place.fromJson(x)));
}

String placeToJson(List<Place> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Place {
  int pk;
  String name;
  int codi;

  Place({
    required this.pk,
    required this.name,
    required this.codi,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        pk: json["pk"],
        // name: jsonDecode(utf8.decode(json["name"])).toString(),
        name: json["name"],
        codi: json["codi"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "name": name,
        "codi": codi,
      };
}
