// To parse this JSON data, do
//
//     final feasibilityModel = feasibilityModelFromJson(jsonString?);

import 'dart:convert';

FeasibilityModel feasibilityModelFromJson(String? str) => FeasibilityModel.fromJson(json.decode(str!));

String? feasibilityModelToJson(FeasibilityModel data) => json.encode(data.toJson());

class FeasibilityModel {
  final int? success;
  final bool? error;
  final dynamic data;

  FeasibilityModel({
    this.success,
    this.error,
    this.data,
  });

  factory FeasibilityModel.fromJson(Map<String?, dynamic> json) => FeasibilityModel(
      success: json["success"],
      error: json["error"],
      data: json['data'] is String ? json['data'] : List<FeasibilityData>.from(json["data"].map((x) => FeasibilityData.fromJson(x))));

  Map<String?, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FeasibilityData {
  final dynamic buildingNumber;
  final String? areaId;
  final String? areaName;
  final String? mobileNumber;
  final String? id;
  final String? hplcprojectId;
  final DateTime? createdOn;
  final String? status;
  final String? lmcId;
  final String? dmaId;
  final String? isReassigned;
  final String? crn;
  final String? firstName;
  final dynamic middleName;
  final String? lastName;
  final dynamic guardianName;
  final dynamic houseNumber;
  final dynamic locality;
  final dynamic address2;
  final dynamic town;
  final String? district;
  final String? state;
  final dynamic pinCode;
  final String? propertyCategoryId;
  final String? propertyClassId;
  final String? assignId;
  final dynamic isInstall;
  final dynamic lmcFeasId;
  final String? dma;
  final String? states;
  final String? dis;
  final String? propName;
  final String? propClass;
  final String? bpNumber;

  FeasibilityData({
    this.buildingNumber,
    this.areaId,
    this.areaName,
    this.mobileNumber,
    this.id,
    this.hplcprojectId,
    this.createdOn,
    this.status,
    this.lmcId,
    this.dmaId,
    this.isReassigned,
    this.crn,
    this.firstName,
    this.middleName,
    this.lastName,
    this.guardianName,
    this.houseNumber,
    this.locality,
    this.address2,
    this.town,
    this.district,
    this.state,
    this.pinCode,
    this.propertyCategoryId,
    this.propertyClassId,
    this.assignId,
    this.isInstall,
    this.lmcFeasId,
    this.dma,
    this.states,
    this.dis,
    this.propName,
    this.propClass,
    this.bpNumber,
  });

  factory FeasibilityData.fromJson(Map<String?, dynamic> json) => FeasibilityData(
        buildingNumber: json["building_number"] ?? "",
        areaId: json["area_id"] ?? "",
        areaName: json["area_name"] ?? "",
        mobileNumber: json["mobile_number"] ?? "",
        id: json["id"] ?? "",
        hplcprojectId: json["hplcproject_id"] ?? "",
        createdOn: DateTime.parse(json["created_on"]),
        status: json["status"] ?? "",
        lmcId: json["lmc_id"] ?? "",
        dmaId: json["dma_id"] ?? "",
        isReassigned: json["is_reassigned"] ?? "",
        crn: json["crn"] ?? "",
        firstName: json["first_name"] ?? "",
        middleName: json["middle_name"] ?? "",
        lastName: json["last_name"] ?? "",
        guardianName: json["guardian_name"] ?? "",
        houseNumber: json["house_number"] ?? "",
        locality: json["locality"] ?? "",
    address2: json["address2"] ?? "",
        town: json["town"] ?? "",
        district: json["district"] ?? "",
        state: json["state"] ?? "",
        pinCode: json["pin_code"] ?? "",
        propertyCategoryId: json["property_category_id"] ?? "",
        propertyClassId: json["property_class_id"] ?? "",
        assignId: json["assign_id"] ?? "",
        isInstall: json["is_install"] ?? "",
        lmcFeasId: json["lmc_feas_id"] ?? "",
        dma: json["Dma"] ?? "",
        states: json["States"] ?? "",
        dis: json["Dis"] ?? "",
        propName: json["prop_name"] ?? "",
        propClass: json["prop_class"] ?? "",
        bpNumber: json["bp_number"] ?? "",
      );

  Map<String?, dynamic> toJson() => {
        "building_number": buildingNumber,
        "area_id": areaId,
        "area_name": areaName,
        "mobile_number": mobileNumber,
        "id": id,
        "hplcproject_id": hplcprojectId,
        "created_on": createdOn?.toIso8601String(),
        "status": status,
        "lmc_id": lmcId,
        "dma_id": dmaId,
        "is_reassigned": isReassigned,
        "crn": crn,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "guardian_name": guardianName,
        "house_number": houseNumber,
        "locality": locality,
        "address2": address2,
        "town": town,
        "district": district,
        "state": state,
        "pin_code": pinCode,
        "property_category_id": propertyCategoryId,
        "property_class_id": propertyClassId,
        "assign_id": assignId,
        "is_install": isInstall,
        "lmc_feas_id": lmcFeasId,
        "Dma": dma,
        "States": states,
        "Dis": dis,
        "prop_name": propName,
        "prop_class": propClass,
        "bp_number": bpNumber,
      };
}
