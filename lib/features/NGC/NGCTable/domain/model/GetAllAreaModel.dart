// To parse this JSON data, do
//
//     final getAllAreaModel = getAllAreaModelFromJson(jsonString);

import 'dart:convert';

List<GetAllAreaModel> getAllAreaModelFromJson(String str) =>
    List<GetAllAreaModel>.from(
        json.decode(str).map((x) => GetAllAreaModel.fromJson(x)));

String getAllAreaModelToJson(List<GetAllAreaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllAreaModel {
  final String? gid;
  final dynamic objectid;
  final String? areaName;
  final dynamic shapeLeng;
  final String? areacode;
  final dynamic cityId;
  final String? chargeAreaId;
  final dynamic subareacod;
  final dynamic shapeLe1;
  final dynamic shapeArea;
  final String? readyForConnection;

  GetAllAreaModel({
    this.gid,
    this.objectid,
    this.areaName,
    this.shapeLeng,
    this.areacode,
    this.cityId,
    this.chargeAreaId,
    this.subareacod,
    this.shapeLe1,
    this.shapeArea,
    this.readyForConnection,
  });

  factory GetAllAreaModel.fromJson(Map<String, dynamic> json) =>
      GetAllAreaModel(
        gid: json["gid"] ?? "",
        objectid: json["objectid"] ?? "",
        areaName: json["area_name"] ?? "",
        shapeLeng: json["shape_leng"] ?? "",
        areacode: json["areacode"] ?? "",
        cityId: json["city_id"] ?? "",
        chargeAreaId: json["charge_area_id"] ?? "",
        subareacod: json["subareacod"] ?? "",
        shapeLe1: json["shape_le_1"] ?? "",
        shapeArea: json["shape_area"] ?? "",
        readyForConnection: json["ready_for_connection"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "gid": gid,
        "objectid": objectid,
        "area_name": areaName,
        "shape_leng": shapeLeng,
        "areacode": areacode,
        "city_id": cityId,
        "charge_area_id": chargeAreaId,
        "subareacod": subareacod,
        "shape_le_1": shapeLe1,
        "shape_area": shapeArea,
        "ready_for_connection": readyForConnection,
      };
  @override
  String toString() {
    return areaName!.toString();
  }
}
