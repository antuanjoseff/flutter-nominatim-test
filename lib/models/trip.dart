import 'dart:convert';

Trip routeFromJson(String str) => Trip.fromJson(json.decode(str));

String routeToJson(Trip data) => json.encode(data.toJson());

class Trip {
  bool targetIsUdg;
  int udgId;
  int municipalityId;
  DateTime startDate;
  DateTime endDate;
  String arrivalTime;
  List<int> daysOfWeek;

  Trip({
    required this.targetIsUdg,
    required this.udgId,
    required this.municipalityId,
    required this.startDate,
    required this.endDate,
    required this.arrivalTime,
    required this.daysOfWeek,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        targetIsUdg: json["target_is_udg"],
        udgId: json["udg_id"],
        municipalityId: json["municipality_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        arrivalTime: json["arrival_time"],
        daysOfWeek: List<int>.from(json["days_of_week"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "target_is_udg": targetIsUdg,
        "udg_id": udgId,
        "municipality_id": municipalityId,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "arrival_time": arrivalTime,
        "days_of_week": List<dynamic>.from(daysOfWeek.map((x) => x)),
      };
}
