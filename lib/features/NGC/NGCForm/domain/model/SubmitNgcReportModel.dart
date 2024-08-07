// To parse this JSON data, do
//
//     final submitNgcReportModel = submitNgcReportModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SubmitNgcReportModel submitNgcReportModelFromJson(String str) => SubmitNgcReportModel.fromJson(json.decode(str));

String submitNgcReportModelToJson(SubmitNgcReportModel data) => json.encode(data.toJson());

class SubmitNgcReportModel {
  SubmitNgcReportModel({
     this.success,
     this.error,
     this.data,
  });

  final int? success;
  final bool? error;
  final String? data;

  SubmitNgcReportModel copyWith({
    int? success,
    bool? error,
    String? data,
  }) =>
      SubmitNgcReportModel(
        success: success ?? this.success,
        error: error ?? this.error,
        data: data ?? this.data,
      );

  factory SubmitNgcReportModel.fromJson(Map<String, dynamic> json) => SubmitNgcReportModel(
    success: json["success"],
    error: json["error"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error,
    "data": data,
  };
}

class ResponseSubmitReportModel{
  final String? schema;
  final String? name_of_contractor;
  final String? meter_reading;
  final String? jmr_no;
  final String? no_of_burners;
  final String? mismatch_meter_no;
  final String? contact_person;
  final String? reason_of_delay;
  final String? alternate_mobile;
  final String? email;
  final String? meter_image;
  final String? contractorSignature;
  final String? representative_signature;
  final String? ngc_report_file;
  final String? delayStatus;
  final String? conversion_date;
  final String? workCompletedDate;
  final String? dma_user_id;
  final String? lmcInstallationId;
  final String? is_install;
  final String? comment;

  const ResponseSubmitReportModel( {
    this.schema,
    this.name_of_contractor,
    this.meter_reading,
    this.jmr_no,
    this.no_of_burners,
    this.mismatch_meter_no,
    this.contact_person,
    this.reason_of_delay,
    this.alternate_mobile,
    this.email,
    this.meter_image,
    this.contractorSignature,
    this.representative_signature,
    this.ngc_report_file,
    this.delayStatus,
    this.conversion_date,
    this.workCompletedDate,
    this.dma_user_id,
    this.lmcInstallationId,
    this.is_install,
    this.comment,});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "schema": schema!.trim().toString() ?? "",
      "name_of_contractor": name_of_contractor.toString().trim() ?? "",
      "meter_reading": meter_reading.toString().trim() ?? "",
      "jmr_no": jmr_no.toString().trim() ?? "",
      "no_of_burners": no_of_burners.toString().trim() ?? "",
      "mismatch_meter_no": mismatch_meter_no.toString().trim() ?? "",
      "contact_person": contact_person.toString().trim() ?? "",
      "reason_of_delay": reason_of_delay.toString().trim() ?? "",
      "alternate_mobile": alternate_mobile.toString().trim() ?? "",
      "email": email.toString().trim() ?? "",
      "meter_image": meter_image.toString().trim() ?? "",
      "contractor_signature": contractorSignature.toString().trim() ?? "",
      "representative_signature": representative_signature.toString().trim() ?? "",
      "ngc_report_file": ngc_report_file.toString().trim() ?? "",
      "delay_status": delayStatus.toString().trim() ?? "",
      "conversion_date": conversion_date.toString().trim() ?? "",
      "work_completed_date": workCompletedDate.toString().trim() ?? "",
      "dma_user_id": dma_user_id.toString().trim() ?? "",
      "lmc_installation_id": lmcInstallationId.toString().trim() ?? "",
      "is_install": is_install.toString().trim() ?? "",
      "comment": comment.toString().trim() ?? "",
    };
    return map ;
  }
}
