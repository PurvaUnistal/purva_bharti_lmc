// To parse this JSON data, do
//
//     final installationImagesModel = installationImagesModelFromJson(jsonString);

import 'dart:convert';

InstallationImagesModel installationImagesModelFromJson(String str) => InstallationImagesModel.fromJson(json.decode(str));

String installationImagesModelToJson(InstallationImagesModel data) => json.encode(data.toJson());

class InstallationImagesModel {
  InstallationImagesModel({
    this.success,
    this.error,
    this.data,
  });

  int success;
  bool error;
  String data;

  factory InstallationImagesModel.fromJson(Map<String, dynamic> json) => InstallationImagesModel(
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

class InstallationImagesReqModel{
  final String schema;
  final String bpNumber;
  final String lmcId;
  final String dmaId;
  final String rfcForm;
  final String workCompletedImage;
  final String isometricImage;
  final String pneumaticImage;

  InstallationImagesReqModel({
    this.schema,this.bpNumber,
    this.lmcId,
    this.dmaId,
    this.rfcForm,
    this.workCompletedImage,
    this.isometricImage,
    this.pneumaticImage,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "schema": schema.trim().toString(),
      "bp_number": bpNumber.trim().toString(),
      "lmc_id": lmcId.trim().toString(),
      "dma_id": dmaId.trim().toString(),
      "rfc_form": rfcForm.trim().toString(),
      "work_completed_image": workCompletedImage.trim().toString(),
      "isometric_image": isometricImage.trim().toString(),
      "pneumatic_image": pneumaticImage.trim().toString(),
    };
    return map ;
  }
}
