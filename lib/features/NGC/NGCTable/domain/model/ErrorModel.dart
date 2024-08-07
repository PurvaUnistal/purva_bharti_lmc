// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  int? success;
  bool? error;
  String? data;

  ErrorModel({
    this.success,
    this.error,
    this.data,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
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
