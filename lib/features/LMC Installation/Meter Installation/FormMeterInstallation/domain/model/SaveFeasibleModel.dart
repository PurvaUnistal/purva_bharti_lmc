// To parse this JSON data, do
//
//     final saveFeasibleModel = saveFeasibleModelFromJson(jsonString);

import 'dart:convert';

SaveFeasibleModel saveFeasibleModelFromJson(String str) => SaveFeasibleModel.fromJson(json.decode(str));

String saveFeasibleModelToJson(SaveFeasibleModel data) => json.encode(data.toJson());

class SaveFeasibleModel {
  int? success;
  bool? error;
  String? data;

  SaveFeasibleModel({
     this.success,
     this.error,
     this.data,
  });

  factory SaveFeasibleModel.fromJson(Map<String, dynamic> json) => SaveFeasibleModel(
    success: json["success"] ?? "",
    error: json["error"] ?? "",
    data: json["data"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error,
    "data": data,
  };
}
