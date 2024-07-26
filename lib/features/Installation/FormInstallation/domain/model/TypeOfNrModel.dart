// To parse this JSON data, do
//
//     final typeOfNrModel = typeOfNrModelFromJson(jsonString);

import 'dart:convert';

TypeOfNrModel typeOfNrModelFromJson(String str) => TypeOfNrModel.fromJson(json.decode(str));

String typeOfNrModelToJson(TypeOfNrModel data) => json.encode(data.toJson());

class TypeOfNrModel {
  final String? normal;
  final String? reverse;

  TypeOfNrModel({
    this.normal,
    this.reverse,
  });

  factory TypeOfNrModel.fromJson(Map<String, dynamic> json) => TypeOfNrModel(
        normal: json["normal"] ?? "",
        reverse: json["reverse"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "normal": normal,
        "reverse": reverse,
      };
}
