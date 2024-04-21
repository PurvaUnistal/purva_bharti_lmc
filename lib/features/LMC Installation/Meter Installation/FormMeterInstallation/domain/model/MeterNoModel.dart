// To parse this JSON data, do
//
//     final meterNoModel = meterNoModelFromJson(jsonString);

import 'dart:convert';

MeterNoModel meterNoModelFromJson(String str) => MeterNoModel.fromJson(json.decode(str));

String meterNoModelToJson(MeterNoModel data) => json.encode(data.toJson());

class MeterNoModel {
  final int success;
  final bool error;
  final List<ListOfMeterNo> data;

  MeterNoModel({
    required this.success,
    required this.error,
    required this.data,
  });

  factory MeterNoModel.fromJson(Map<String, dynamic> json) => MeterNoModel(
        success: json["success"],
        error: json["error"],
        data: List<ListOfMeterNo>.from(json["data"].map((x) => ListOfMeterNo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ListOfMeterNo {
  final String serialNumber;
  final String id;

  ListOfMeterNo({
    required this.serialNumber,
    required this.id,
  });

  factory ListOfMeterNo.fromJson(Map<String, dynamic> json) => ListOfMeterNo(
        serialNumber: json["serial_number"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "serial_number": serialNumber,
        "id": id,
      };
}
