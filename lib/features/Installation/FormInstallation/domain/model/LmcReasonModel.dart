// To parse this JSON data, do
//
//     final lmcReasonModel = lmcReasonModelFromJson(jsonString);

import 'dart:convert';

List<LmcReasonModel> lmcReasonModelFromJson(String str) => List<LmcReasonModel>.from(json.decode(str).map((x) => LmcReasonModel.fromJson(x)));

String lmcReasonModelToJson(List<LmcReasonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LmcReasonModel {
  final int? id;
  final String? name;

  LmcReasonModel({
     this.id,
     this.name,
  });

  factory LmcReasonModel.fromJson(Map<String, dynamic> json) => LmcReasonModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
