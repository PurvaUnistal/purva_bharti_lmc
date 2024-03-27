// To parse this JSON data, do
//
//     final regulatorsModel = regulatorsModelFromJson(jsonString);

import 'dart:convert';

RegulatorsModel regulatorsModelFromJson(String str) => RegulatorsModel.fromJson(json.decode(str));

String regulatorsModelToJson(RegulatorsModel data) => json.encode(data.toJson());

class RegulatorsModel {
  int success;
  bool error;
  List<RegulatorsData> data;

  RegulatorsModel({
     this.success,
     this.error,
     this.data,
  });

  factory RegulatorsModel.fromJson(Map<String, dynamic> json) => RegulatorsModel(
    success: json["success"],
    error: json["error"],
    data:json["data"] == null ? [] : List<RegulatorsData>.from(json["data"].map((x) => RegulatorsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RegulatorsData {
  String serialNumber;
  String id;

  RegulatorsData({
     this.serialNumber,
     this.id,
  });

  factory RegulatorsData.fromJson(Map<String, dynamic> json) => RegulatorsData(
    serialNumber: json["serial_number"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "serial_number": serialNumber,
    "id": id,
  };
}
