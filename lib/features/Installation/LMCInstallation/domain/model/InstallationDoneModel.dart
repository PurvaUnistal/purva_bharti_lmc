// To parse this JSON data, do
//
//     final InstallationDoneModel = InstallationDoneModelFromJson(jsonString?);

import 'dart:convert';

InstallationDoneModel installationDoneModelFromJson(String? str) => InstallationDoneModel.fromJson(json.decode(str!));

String? installationDoneModelToJson(InstallationDoneModel data) => json.encode(data.toJson());

class InstallationDoneModel {
  final int? success;
  final bool? error;
  final dynamic data;

  InstallationDoneModel({
    this.success,
    this.error,
    this.data,
  });

  factory InstallationDoneModel.fromJson(Map<String?, dynamic> json) => InstallationDoneModel(
      success: json["success"],
      error: json["error"],
      data: json['data'] is String ? json['data'] : List<InstallationDoneRows>.from(json["data"].map((x) => InstallationDoneRows.fromJson(x))));

  Map<String?, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class InstallationDoneRows {
  String? lmcInstallId;
  String? installationProcessStatus;
  String? rfcProcessStatus;
  String? chargeAreaName;
  String? areaName;
  String? feasTpaRemarks;
  String? feasTpaApprovalDate;
  String? feasTpaStatus;
  String? bpNumber;
  String? areaId;
  String? buildingNumber;
  String? mobileNumber;
  String? id;
  String? dmaRegId;
  String? assignLmcId;
  String? proposedDate;
  String? feasibilityVisitDate;
  String? additionalBom;
  String? createdAt;
  String? updatedAt;
  String? isFeasible;
  String? feasReason;
  dynamic followUpDate;
  dynamic deletedAt;
  String? source;
  String? extraPipePayment;
  String? installationStatus;
  dynamic transactionId;
  dynamic transactionTime;
  dynamic modeOfDepositePayment;
  dynamic bounceCharge;
  dynamic bounceChargeTax;
  dynamic paymentCreditStatusLmc;
  dynamic invoiceNumber;
  dynamic invoiceAmount;
  dynamic extraPipe;
  dynamic totPipeLength;
  dynamic msgToCustomer;
  dynamic extraPipeUserId;
  dynamic invoiceDate;
  String? extraPipeStatus;
  dynamic meterNo;
  dynamic regulatorNo;
  dynamic lmcMeterReading;
  dynamic lastMeterReading;
  dynamic prevBalance;
  dynamic paidInstallment;
  dynamic actualLmcWorkStartedDate;
  dynamic tpaInspectionDate;
  dynamic ngcConversionDate;
  String? feasTpaApproval;
  dynamic remarks;
  String? crn;
  String? firstName;
  String? middleName;
  String? lastName;
  String? guardianName;
  String? houseNumber;
  String? locality;
  String? town;
  dynamic district;
  dynamic state;
  String? pinCode;
  String? propertyCategoryId;
  String? propertyClassId;
  String? assignId;
  dynamic isInstall;
  String? lmcFeasId;
  String? dma;
  String? states;
  String? dis;
  String? propName;
  String? propClass;
  String? dmaId;
  String? trNumber;

  InstallationDoneRows(
      {
        this.lmcInstallId,
        this.installationProcessStatus,
        this.rfcProcessStatus,
        this.chargeAreaName,
        this.areaName,
        this.feasTpaRemarks,
        this.feasTpaApprovalDate,
        this.feasTpaStatus,
        this.bpNumber,
        this.areaId,
        this.buildingNumber,
        this.mobileNumber,
        this.id,
        this.dmaRegId,
        this.assignLmcId,
        this.proposedDate,
        this.feasibilityVisitDate,
        this.additionalBom,
        this.createdAt,
        this.updatedAt,
        this.isFeasible,
        this.feasReason,
        this.followUpDate,
        this.deletedAt,
        this.source,
        this.extraPipePayment,
        this.installationStatus,
        this.transactionId,
        this.transactionTime,
        this.modeOfDepositePayment,
        this.bounceCharge,
        this.bounceChargeTax,
        this.paymentCreditStatusLmc,
        this.invoiceNumber,
        this.invoiceAmount,
        this.extraPipe,
        this.totPipeLength,
        this.msgToCustomer,
        this.extraPipeUserId,
        this.invoiceDate,
        this.extraPipeStatus,
        this.meterNo,
        this.regulatorNo,
        this.lmcMeterReading,
        this.lastMeterReading,
        this.prevBalance,
        this.paidInstallment,
        this.actualLmcWorkStartedDate,
        this.tpaInspectionDate,
        this.ngcConversionDate,
        this.feasTpaApproval,
        this.remarks,
        this.crn,
        this.firstName,
        this.middleName,
        this.lastName,
        this.guardianName,
        this.houseNumber,
        this.locality,
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
        this.dmaId,
        this.trNumber,
      });

  InstallationDoneRows.fromJson(Map<String, dynamic> json) {
    installationProcessStatus = json['installation_process_status'] ?? "";
    lmcInstallId = json['lmc_install_id'] ?? "";
    rfcProcessStatus = json['rfc_process_status'] ?? "";
    chargeAreaName = json['charge_area_name'] ?? "";
    areaName = json['area_name'] ?? "";
    feasTpaRemarks = json['feas_tpa_remarks'] ?? "";
    feasTpaApprovalDate = json['feas_tpa_approval_date'] ?? "";
    feasTpaStatus = json['feas_tpa_status'] ?? "";
    bpNumber = json['bp_number'] ?? "";
    areaId = json['area_id'] ?? "";
    buildingNumber = json['building_number'] ?? "";
    mobileNumber = json['mobile_number'] ?? "";
    id = json['id'] ?? "";
    dmaRegId = json['dma_reg_id'] ?? "";
    assignLmcId = json['assign_lmc_id'] ?? "";
    proposedDate = json['proposed_date'] ?? "";
    feasibilityVisitDate = json['feasibility_visit_date'] ?? "";
    additionalBom = json['additional_bom'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    isFeasible = json['is_feasible'] ?? "";
    feasReason = json['feas_reason'] ?? "";
    followUpDate = json['follow_up_date'] ?? "";
    deletedAt = json['deleted_at'] ?? "";
    source = json['source'] ?? "";
    extraPipePayment = json['extra_pipe_payment'] ?? "";
    installationStatus = json['installation_status'] ?? "";
    transactionId = json['transaction_id'] ?? "";
    transactionTime = json['transaction_time'] ?? "";
    modeOfDepositePayment = json['mode_of_deposite_payment'] ?? "";
    bounceCharge = json['bounce_charge'] ?? "";
    bounceChargeTax = json['bounce_charge_tax'] ?? "";
    paymentCreditStatusLmc = json['payment_credit_status_lmc'] ?? "";
    invoiceNumber = json['invoice_number'] ?? "";
    invoiceAmount = json['invoice_amount'] ?? "";
    extraPipe = json['extra_pipe'] ?? "";
    totPipeLength = json['tot_pipe_length'] ?? "";
    msgToCustomer = json['msg_to_customer'] ?? "";
    extraPipeUserId = json['extra_pipe_user_id'] ?? "";
    invoiceDate = json['invoice_date'] ?? "";
    extraPipeStatus = json['extra_pipe_status'] ?? "";
    meterNo = json['meter_no'] ?? "";
    regulatorNo = json['regulator_no'] ?? "";
    lmcMeterReading = json['lmc_meter_reading'] ?? "";
    lastMeterReading = json['last_meter_reading'] ?? "";
    prevBalance = json['prev_balance'] ?? "";
    paidInstallment = json['paid_installment'] ?? "";
    actualLmcWorkStartedDate = json['actual_lmc_work_started_date'] ?? "";
    tpaInspectionDate = json['tpa_inspection_date'] ?? "";
    ngcConversionDate = json['ngc_conversion_date'] ?? "";
    feasTpaApproval = json['feas_tpa_approval'] ?? "";
    remarks = json['remarks'] ?? "";
    crn = json['crn'] ?? "";
    firstName = json['first_name'] ?? "";
    middleName = json['middle_name'] ?? "";
    lastName = json['last_name'] ?? "";
    guardianName = json['guardian_name'] ?? "";
    houseNumber = json['house_number'] ?? "";
    locality = json['locality'] ?? "";
    town = json['town'] ?? "";
    district = json['district'] ?? "";
    state = json['state'] ?? "";
    pinCode = json['pin_code'] ?? "";
    propertyCategoryId = json['property_category_id'] ?? "";
    propertyClassId = json['property_class_id'] ?? "";
    assignId = json['assign_id'] ?? "";
    isInstall = json['is_install'] ?? "";
    lmcFeasId = json['lmc_feas_id'] ?? "";
    dma = json['Dma'] ?? "";
    states = json['States'] ?? "";
    dis = json['Dis'] ?? "";
    propName = json['prop_name'] ?? "";
    propClass = json['prop_class'] ?? "";
    dmaId = json['dma_id'] ?? "";
    trNumber = json['tr_number'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installation_process_status'] = this.installationProcessStatus;
    data['lmc_install_id'] = this.lmcInstallId;
    data['rfc_process_status'] = this.rfcProcessStatus;
    data['charge_area_name'] = this.chargeAreaName;
    data['area_name'] = this.areaName;
    data['feas_tpa_remarks'] = this.feasTpaRemarks;
    data['feas_tpa_approval_date'] = this.feasTpaApprovalDate;
    data['feas_tpa_status'] = this.feasTpaStatus;
    data['bp_number'] = this.bpNumber;
    data['area_id'] = this.areaId;
    data['building_number'] = this.buildingNumber;
    data['mobile_number'] = this.mobileNumber;
    data['id'] = this.id;
    data['dma_reg_id'] = this.dmaRegId;
    data['assign_lmc_id'] = this.assignLmcId;
    data['proposed_date'] = this.proposedDate;
    data['feasibility_visit_date'] = this.feasibilityVisitDate;
    data['additional_bom'] = this.additionalBom;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_feasible'] = this.isFeasible;
    data['feas_reason'] = this.feasReason;
    data['follow_up_date'] = this.followUpDate;
    data['deleted_at'] = this.deletedAt;
    data['source'] = this.source;
    data['extra_pipe_payment'] = this.extraPipePayment;
    data['installation_status'] = this.installationStatus;
    data['transaction_id'] = this.transactionId;
    data['transaction_time'] = this.transactionTime;
    data['mode_of_deposite_payment'] = this.modeOfDepositePayment;
    data['bounce_charge'] = this.bounceCharge;
    data['bounce_charge_tax'] = this.bounceChargeTax;
    data['payment_credit_status_lmc'] = this.paymentCreditStatusLmc;
    data['invoice_number'] = this.invoiceNumber;
    data['invoice_amount'] = this.invoiceAmount;
    data['extra_pipe'] = this.extraPipe;
    data['tot_pipe_length'] = this.totPipeLength;
    data['msg_to_customer'] = this.msgToCustomer;
    data['extra_pipe_user_id'] = this.extraPipeUserId;
    data['invoice_date'] = this.invoiceDate;
    data['extra_pipe_status'] = this.extraPipeStatus;
    data['meter_no'] = this.meterNo;
    data['regulator_no'] = this.regulatorNo;
    data['lmc_meter_reading'] = this.lmcMeterReading;
    data['last_meter_reading'] = this.lastMeterReading;
    data['prev_balance'] = this.prevBalance;
    data['paid_installment'] = this.paidInstallment;
    data['actual_lmc_work_started_date'] = this.actualLmcWorkStartedDate;
    data['tpa_inspection_date'] = this.tpaInspectionDate;
    data['ngc_conversion_date'] = this.ngcConversionDate;
    data['feas_tpa_approval'] = this.feasTpaApproval;
    data['remarks'] = this.remarks;
    data['crn'] = this.crn;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['guardian_name'] = this.guardianName;
    data['house_number'] = this.houseNumber;
    data['locality'] = this.locality;
    data['town'] = this.town;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    data['property_category_id'] = this.propertyCategoryId;
    data['property_class_id'] = this.propertyClassId;
    data['assign_id'] = this.assignId;
    data['is_install'] = this.isInstall;
    data['lmc_feas_id'] = this.lmcFeasId;
    data['Dma'] = this.dma;
    data['States'] = this.states;
    data['Dis'] = this.dis;
    data['prop_name'] = this.propName;
    data['prop_class'] = this.propClass;
    data['dma_id'] = this.dmaId;
    data['tr_number'] = this.trNumber;
    return data;
  }
}