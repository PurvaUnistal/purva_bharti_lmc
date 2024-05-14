// To parse this JSON data, do
//
//     final allFreeMaterialModel = allFreeMaterialModelFromJson(jsonString);

import 'dart:convert';

AllFreeMaterialModel allFreeMaterialModelFromJson(String str) => AllFreeMaterialModel.fromJson(json.decode(str));

String allFreeMaterialModelToJson(AllFreeMaterialModel data) => json.encode(data.toJson());

class AllFreeMaterialModel {
  int? success;
  bool? error;
  List<FreeMaterialData>? data;

  AllFreeMaterialModel({
     this.success,
     this.error,
     this.data,
  });

  factory AllFreeMaterialModel.fromJson(Map<String, dynamic> json) => AllFreeMaterialModel(
    success: json["success"] ?? "",
    error: json["error"] ?? "",
    data: List<FreeMaterialData>.from(json["data"].map((x) => FreeMaterialData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FreeMaterialData {
  String? id;
  String? materialUnit;
  String? status;
  DateTime? createdOn;
  String? make;
  String? materialCategory;
  String? materialName;
  String? warrantyMonth;
  String? sortBy;
  String? materialType;
  String? materialCost;

  FreeMaterialData({
     this.id,
     this.materialUnit,
     this.status,
     this.createdOn,
     this.make,
     this.materialCategory,
     this.materialName,
     this.warrantyMonth,
     this.sortBy,
     this.materialType,
     this.materialCost,
  });

  factory FreeMaterialData.fromJson(Map<String, dynamic> json) => FreeMaterialData(
    id: json["id"] ?? "",
    materialUnit: json["material_unit"]?? "",
    status: json["status"] ?? "",
    createdOn: DateTime.parse(json["created_on"]),
    make: json["make"] ?? "",
    materialCategory:json["material_category"] ?? "",
    materialName: json["material_name"] ?? "",
    warrantyMonth: json["warranty_month"] ?? "",
    sortBy: json["sort_by"] ?? "",
    materialType: json["material_type"] ?? "",
    materialCost: json["material_cost"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "material_unit": materialUnit,
    "status": status,
    "created_on": createdOn!.toIso8601String(),
    "make": make,
    "material_category":materialCategory,
    "material_name": materialName,
    "warranty_month": warrantyMonth,
    "sort_by": sortBy,
    "material_type": materialType,
    "material_cost": materialCost,
  };
}
