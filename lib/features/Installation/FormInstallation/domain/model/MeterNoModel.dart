// To parse this JSON data, do
//
//     final meterNoModel = meterNoModelFromJson(jsonString);

import 'dart:convert';

MeterNoModel meterNoModelFromJson(String str) => MeterNoModel.fromJson(json.decode(str));

String meterNoModelToJson(MeterNoModel data) => json.encode(data.toJson());

class MeterNoModel {
  final int? success;
  final bool? error;
  final List<ListOfMeterNo>? data;

  MeterNoModel({
     this.success,
     this.error,
     this.data,
  });

  factory MeterNoModel.fromJson(Map<String, dynamic> json) => MeterNoModel(
        success: json["success"] ?? "",
        error: json["error"] ?? "",
        data: json["data"] == null ? [] :List<ListOfMeterNo>.from(json["data"].map((x) => ListOfMeterNo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListOfMeterNo {
  final String? meterConnection;
  final String? serialNumber;
  final String? id;

  ListOfMeterNo({
     this.meterConnection,
     this.serialNumber,
     this.id,
  });

  factory ListOfMeterNo.fromJson(Map<String, dynamic> json) => ListOfMeterNo(
        meterConnection: json["meter_connection"] ?? "",
        serialNumber: json["serial_number"] ?? "",
        id: json["id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "meter_connection": meterConnection,
        "serial_number": serialNumber,
        "id": id,
      };
}
