// To parse this JSON data, do
//
//     final RFCInstallationModel = RFCInstallationModelFromJson(jsonString?);

import 'dart:convert';

RFCInstallationModel rFCInstallationModelFromJson(String? str) => RFCInstallationModel.fromJson(json.decode(str!));

String? rFCInstallationModelToJson(RFCInstallationModel data) => json.encode(data.toJson());

class RFCInstallationModel {
  final int? success;
  final bool? error;
  final dynamic data;

  RFCInstallationModel({
    this.success,
    this.error,
    this.data,
  });

  factory RFCInstallationModel.fromJson(Map<String?, dynamic> json) => RFCInstallationModel(
      success: json["success"],
      error: json["error"],
      data: json['data'] is String ? json['data'] : List<RFCInstallationRows>.from(json["data"].map((x) => RFCInstallationRows.fromJson(x))));

  Map<String?, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RFCInstallationRows {
  String? areaId;
  String? bpNumber;
  String? buildingNumber;
  String? areaName;
  String? mobileNumber;
  String? id;
  String? dmaId;
  String? actualWorkStart;
  String? delayReason;
  dynamic meterType;
  dynamic meterMake;
  String? meterNumber;
  dynamic pipe;
  dynamic fittings;
  String? meterReading;
  String? meterReadingDate;
  String? meterPhoto;
  String? tfNumber;
  String? latitudeTf;
  String? longitudeTf;
  String? latitudeHg;
  String? longitudeHg;
  String? workCompletedDate;
  String? workCompletedImage;
  dynamic custAckImage;
  String? createdAt;
  String? updatedAt;
  dynamic custAckDate;
  String? feasibilityId;
  String? extraPipe;
  String? extraPrice;
  String? cementingOfHoles;
  dynamic clampingPvc;
  String? claminngCopper;
  String? meterTesting;
  String? paintaingofGIpipe;
  dynamic conversionDate;
  String? typeOfNr;
  String? ngc;
  String? regulators;
  String? extraPipeId;
  String? isometricImage;
  String? isometricDate;
  String? pneumaticDate;
  dynamic pneumaticImage;
  String? rfcForm;
  String? source;
  String? tpaStatus;
  String? tpaRejectReason;
  String? tpaUserId;
  String? insExtraPipe;
  String? insExtraPrice;
  dynamic pipePaymentType;
  dynamic oldMeterNumber;
  dynamic meterReplacementDate;
  dynamic previousInstalledStatus;
  String? instDirPath;
  String? installationProcessStatus;
  dynamic rfcProcessStatus;
  String? crn;
  String? firstName;
  String? middleName;
  String? lastName;
  String? guardianName;
  String? houseNumber;
  String? locality;
  String? address2;
  String? town;
  String? district;
  String? state;
  String? pinCode;
  String? propertyCategoryId;
  String? propertyClassId;
  String? assignId;
  String? isInstall;
  String? proposedDate;
  String? lmcFeasId;
  String? dma;
  String? states;
  String? dis;
  String? propName;
  String? propClass;
  String? installationId;

  RFCInstallationRows(
      {this.areaId,
      this.bpNumber,
      this.buildingNumber,
      this.areaName,
      this.mobileNumber,
      this.id,
      this.dmaId,
      this.actualWorkStart,
      this.delayReason,
      this.meterType,
      this.meterMake,
      this.meterNumber,
      this.pipe,
      this.fittings,
      this.meterReading,
      this.meterReadingDate,
      this.meterPhoto,
      this.tfNumber,
      this.latitudeTf,
      this.longitudeTf,
      this.latitudeHg,
      this.longitudeHg,
      this.workCompletedDate,
      this.workCompletedImage,
      this.custAckImage,
      this.createdAt,
      this.updatedAt,
      this.custAckDate,
      this.feasibilityId,
      this.extraPipe,
      this.extraPrice,
      this.cementingOfHoles,
      this.clampingPvc,
      this.claminngCopper,
      this.meterTesting,
      this.paintaingofGIpipe,
      this.conversionDate,
      this.typeOfNr,
      this.ngc,
      this.regulators,
      this.extraPipeId,
      this.isometricImage,
      this.isometricDate,
      this.pneumaticDate,
      this.pneumaticImage,
      this.rfcForm,
      this.source,
      this.tpaStatus,
      this.tpaRejectReason,
      this.tpaUserId,
      this.insExtraPipe,
      this.insExtraPrice,
      this.pipePaymentType,
      this.oldMeterNumber,
      this.meterReplacementDate,
      this.previousInstalledStatus,
      this.instDirPath,
      this.installationProcessStatus,
      this.rfcProcessStatus,
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
      this.proposedDate,
      this.lmcFeasId,
      this.dma,
      this.states,
      this.dis,
      this.propName,
      this.propClass,
      this.installationId});

  RFCInstallationRows.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'] ?? "";
    bpNumber = json['bp_number'] ?? "";
    buildingNumber = json['building_number'] ?? "";
    areaName = json['area_name'] ?? "";
    mobileNumber = json['mobile_number'] ?? "";
    id = json['id'] ?? "";
    dmaId = json['dma_id'] ?? "";
    actualWorkStart = json['actual_work_start'] ?? "";
    delayReason = json['delay_reason'] ?? "";
    meterType = json['meter_type'] ?? "";
    meterMake = json['meter_make'] ?? "";
    meterNumber = json['meter_number'] ?? "";
    pipe = json['pipe'] ?? "";
    fittings = json['fittings'] ?? "";
    meterReading = json['meter_reading'] ?? "";
    meterReadingDate = json['meter_reading_date'] ?? "";
    meterPhoto = json['meter_photo'] ?? "";
    tfNumber = json['tf_number'] ?? "";
    latitudeTf = json['latitude_tf'] ?? "";
    longitudeTf = json['longitude_tf'] ?? "";
    latitudeHg = json['latitude_hg'] ?? "";
    longitudeHg = json['longitude_hg'] ?? "";
    workCompletedDate = json['work_completed_date'] ?? "";
    workCompletedImage = json['work_completed_image'] ?? "";
    custAckImage = json['cust_ack_image'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    custAckDate = json['cust_ack_date'] ?? "";
    feasibilityId = json['feasibility_id'] ?? "";
    extraPipe = json['extra_pipe'] ?? "";
    extraPrice = json['extra_price'] ?? "";
    cementingOfHoles = json['cementing_of_holes'] ?? "";
    clampingPvc = json['clamping_pvc'] ?? "";
    claminngCopper = json['claminng_copper'] ?? "";
    meterTesting = json['meter_testing'] ?? "";
    paintaingofGIpipe = json['paintaingofGIpipe'] ?? "";
    conversionDate = json['conversion_date'] ?? "";
    typeOfNr = json['type_of_nr'] ?? "";
    ngc = json['ngc'] ?? "";
    regulators = json['regulators'] ?? "";
    extraPipeId = json['extra_pipe_id'] ?? "";
    isometricImage = json['isometric_image'] ?? "";
    isometricDate = json['isometric_date'] ?? "";
    pneumaticDate = json['pneumatic_date'] ?? "";
    pneumaticImage = json['pneumatic_image'] ?? "";
    rfcForm = json['rfc_form'] ?? "";
    source = json['source'] ?? "";
    tpaStatus = json['tpa_status'] ?? "";
    tpaRejectReason = json['tpa_reject_reason'] ?? "";
    tpaUserId = json['tpa_user_id'] ?? "";
    insExtraPipe = json['ins_extra_pipe'] ?? "";
    insExtraPrice = json['ins_extra_price'] ?? "";
    pipePaymentType = json['pipe_payment_type'] ?? "";
    oldMeterNumber = json['old_meter_number'] ?? "";
    meterReplacementDate = json['meter_replacement_date'] ?? "";
    previousInstalledStatus = json['previous_installed_status'] ?? "";
    instDirPath = json['inst_dir_path'] ?? "";
    installationProcessStatus = json['installation_process_status'] ?? "";
    rfcProcessStatus = json['rfc_process_status'] ?? "";
    crn = json['crn'] ?? "";
    firstName = json['first_name'] ?? "";
    middleName = json['middle_name'] ?? "";
    lastName = json['last_name'] ?? "";
    guardianName = json['guardian_name'] ?? "";
    houseNumber = json['house_number'] ?? "";
    locality = json['locality'] ?? "";
    address2 = json['address2'] ?? "";
    town = json['town'] ?? "";
    district = json['district'] ?? "";
    state = json['state'] ?? "";
    pinCode = json['pin_code'] ?? "";
    propertyCategoryId = json['property_category_id'] ?? "";
    propertyClassId = json['property_class_id'] ?? "";
    assignId = json['assign_id'] ?? "";
    isInstall = json['is_install'] ?? "";
    proposedDate = json['proposed_date'] ?? "";
    lmcFeasId = json['lmc_feas_id'] ?? "";
    dma = json['Dma'] ?? "";
    states = json['States'] ?? "";
    dis = json['Dis'] ?? "";
    propName = json['prop_name'] ?? "";
    propClass = json['prop_class'] ?? "";
    installationId = json['installation_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bp_number'] = this.bpNumber;
    data['area_id'] = this.areaId;
    data['building_number'] = this.buildingNumber;
    data['area_name'] = this.areaName;
    data['mobile_number'] = this.mobileNumber;
    data['id'] = this.id;
    data['dma_id'] = this.dmaId;
    data['actual_work_start'] = this.actualWorkStart;
    data['delay_reason'] = this.delayReason;
    data['meter_type'] = this.meterType;
    data['meter_make'] = this.meterMake;
    data['meter_number'] = this.meterNumber;
    data['pipe'] = this.pipe;
    data['fittings'] = this.fittings;
    data['meter_reading'] = this.meterReading;
    data['meter_reading_date'] = this.meterReadingDate;
    data['meter_photo'] = this.meterPhoto;
    data['tf_number'] = this.tfNumber;
    data['latitude_tf'] = this.latitudeTf;
    data['longitude_tf'] = this.longitudeTf;
    data['latitude_hg'] = this.latitudeHg;
    data['longitude_hg'] = this.longitudeHg;
    data['work_completed_date'] = this.workCompletedDate;
    data['work_completed_image'] = this.workCompletedImage;
    data['cust_ack_image'] = this.custAckImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cust_ack_date'] = this.custAckDate;
    data['feasibility_id'] = this.feasibilityId;
    data['extra_pipe'] = this.extraPipe;
    data['extra_price'] = this.extraPrice;
    data['cementing_of_holes'] = this.cementingOfHoles;
    data['clamping_pvc'] = this.clampingPvc;
    data['claminng_copper'] = this.claminngCopper;
    data['meter_testing'] = this.meterTesting;
    data['paintaingofGIpipe'] = this.paintaingofGIpipe;
    data['conversion_date'] = this.conversionDate;
    data['type_of_nr'] = this.typeOfNr;
    data['ngc'] = this.ngc;
    data['regulators'] = this.regulators;
    data['extra_pipe_id'] = this.extraPipeId;
    data['isometric_image'] = this.isometricImage;
    data['isometric_date'] = this.isometricDate;
    data['pneumatic_date'] = this.pneumaticDate;
    data['pneumatic_image'] = this.pneumaticImage;
    data['rfc_form'] = this.rfcForm;
    data['source'] = this.source;
    data['tpa_status'] = this.tpaStatus;
    data['tpa_reject_reason'] = this.tpaRejectReason;
    data['tpa_user_id'] = this.tpaUserId;
    data['ins_extra_pipe'] = this.insExtraPipe;
    data['ins_extra_price'] = this.insExtraPrice;
    data['pipe_payment_type'] = this.pipePaymentType;
    data['old_meter_number'] = this.oldMeterNumber;
    data['meter_replacement_date'] = this.meterReplacementDate;
    data['previous_installed_status'] = this.previousInstalledStatus;
    data['inst_dir_path'] = this.instDirPath;
    data['installation_process_status'] = this.installationProcessStatus;
    data['rfc_process_status'] = this.rfcProcessStatus;
    data['crn'] = this.crn;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['guardian_name'] = this.guardianName;
    data['house_number'] = this.houseNumber;
    data['locality'] = this.locality;
    data['address2'] = this.address2;
    data['town'] = this.town;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['property_category_id'] = this.propertyCategoryId;
    data['property_class_id'] = this.propertyClassId;
    data['assign_id'] = this.assignId;
    data['is_install'] = this.isInstall;
    data['proposed_date'] = this.proposedDate;
    data['lmc_feas_id'] = this.lmcFeasId;
    data['Dma'] = this.dma;
    data['States'] = this.states;
    data['Dis'] = this.dis;
    data['prop_name'] = this.propName;
    data['prop_class'] = this.propClass;
    data['installation_id'] = this.installationId;
    return data;
  }
}
