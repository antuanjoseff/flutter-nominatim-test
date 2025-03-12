import 'dart:convert';

Route routeFromJson(String str) => Route.fromJson(json.decode(str));

String routeToJson(Route data) => json.encode(data.toJson());

class Route {
  bool targetIsUdg;
  int municipalityId;
  int udgId;

  Route({
    required this.targetIsUdg,
    required this.municipalityId,
    required this.udgId,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        targetIsUdg: json["target_is_udg"],
        municipalityId: json["municipality_id"],
        udgId: json["udg_id"],
      );

  Map<String, dynamic> toJson() => {
        "target_is_udg": targetIsUdg,
        "municipality_id": municipalityId,
        "udg_id": udgId,
      };
}
