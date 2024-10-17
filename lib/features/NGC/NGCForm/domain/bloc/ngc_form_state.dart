import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:new_lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:new_lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';

abstract class NGCFormState extends Equatable {}

class NGCFormInitialState extends NGCFormState {
  @override
  List<Object> get props => [];
}

class NGCFormPageLoadState extends NGCFormInitialState {
  @override
  List<Object> get props => [];
}

class NGCFormDataState extends NGCFormState {
  bool isPageLoader;
  bool isBtnLoader;
  bool isCheckMeterMismatch;
  bool isMeterReplace;
  bool isRegularReplace;
  bool isDelayReason;
  bool isLatLongOfSRLoader;
  bool isLatLongOfMRLoader;
  String userName;
  String schema;
  String lmcPath;
  String baseUrl;
  File meterPhoto;
  File rfcPhoto;
  File pneumaticPhoto;
  File ngcReportPhoto;
  File mrPhoto;
  File srPhoto;
  bool isRegulatorLoader;
  String regulatorCheck;
  List<GetConstantModel> listOfTypeOfNr;
  GetConstantModel? typeOfNrValue;
  LmcReasonModel? regulatorTypeValue;
  LmcReasonModel? meterTypeValue;
  LmcReasonModel? regulatorTypeReasonValue;
  List<ListOfMeterNo> listOfMeterNumber;
  List<String> listOfMeterNumberSerial;
  List<String> listOfMeterNumberId;
  List<ListOfMeterNo> listOfRegulator;
  List<String> listOfRegulatorSerial;
  List<String> listOfSRSerial;
  List<String> listOfRegulatorId;
  List<LmcReasonModel> listOfRegulatorType;
  List<LmcReasonModel> listOfMeterType;
  List<LmcReasonModel> listOfRegulatorTypeReason;
  FocusNode meterIniReading1FocusNode;
  FocusNode meterIniReading2FocusNode;
  FocusNode meterIniReading3FocusNode;
  TextEditingController meterIniReading1Controller;
  TextEditingController meterIniReading2Controller;
  TextEditingController meterIniReading3Controller;
  TextEditingController meterInitialReadingController;
  TextEditingController regulatorSerialSearchController;
  TextEditingController regulatorSerialController;
  TextEditingController meterConnectionMeterController;
  TextEditingController proposedNgcDateController;
  TextEditingController noOfFamilyMembersController;
  TextEditingController ngConversionDateController;
  TextEditingController latOfSRController;
  TextEditingController longOfSRController;
  TextEditingController nameContractorController;
  TextEditingController srNumberSearchController;
  TextEditingController srSerialNumberController;
  TextEditingController meterNumberSerialController;
  TextEditingController bpNumberController;
  TextEditingController delayReasonController;
  TextEditingController reasonMeterChangeController;
  TextEditingController reasonRegulatorChangeController;
  TextEditingController noOfBurnersController;
  TextEditingController meterSerialController;
  TextEditingController mobileNumberController;
  TextEditingController altMobileNumberController;
  TextEditingController emailIdController;
  TextEditingController ngChargeDateController;
  TextEditingController typeOfNrController;
  TextEditingController dateInstallationController;
  TextEditingController regulatorTypeController;
  LmcReasonModel? delayReasonValue;
  List<LmcReasonModel> listOfDelayReason;
  TextEditingController latOfMRController;
  TextEditingController longOfMRController;
  TextEditingController extraPipeController;
  TextEditingController extraPriceController;
  TextEditingController rfcDateController;
  NGCFormDataState({
    required this.isPageLoader,
    required this.regulatorCheck,
    required this.rfcPhoto,
    required this.pneumaticPhoto,
    required this.isBtnLoader,
    required this.isDelayReason,
    required this.isLatLongOfSRLoader,
    required this.isLatLongOfMRLoader,
    required this.isCheckMeterMismatch,
    required this.isMeterReplace,
    required this.isRegularReplace,
    required this.meterPhoto,
    required this.ngcReportPhoto,
    required this.isRegulatorLoader,
    required this.userName,
    required this.schema,
    required this.lmcPath,
    required this.baseUrl,
    required this.listOfTypeOfNr,
    required this.typeOfNrValue,
    required this.listOfMeterNumber,
    required this.listOfMeterNumberSerial,
    required this.listOfMeterNumberId,
    required this.listOfRegulator,
    required this.listOfRegulatorSerial,
    required this.listOfSRSerial,
    required this.listOfRegulatorId,
    required this.listOfRegulatorType,
    required this.listOfMeterType,
    required this.listOfRegulatorTypeReason,
    required this.regulatorTypeValue,
    required this.meterTypeValue,
    required this.regulatorTypeReasonValue,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,
    required this.meterIniReading1Controller,
    required this.meterIniReading2Controller,
    required this.meterIniReading3Controller,
    required this.meterInitialReadingController,
    required this.regulatorSerialSearchController,
    required this.regulatorSerialController,
    required this.meterConnectionMeterController,
    required this.proposedNgcDateController,
    required this.noOfFamilyMembersController,
    required this.ngConversionDateController,
    required this.latOfSRController,
    required this.longOfSRController,
    required this.nameContractorController,
    required this.srNumberSearchController,
    required this.srSerialNumberController,
    required this.meterNumberSerialController,
    required this.bpNumberController,
    required this.delayReasonController,
    required this.reasonMeterChangeController,
    required this.reasonRegulatorChangeController,
    required this.noOfBurnersController,
    required this.meterSerialController,
    required this.mobileNumberController,
    required this.altMobileNumberController,
    required this.emailIdController,
    required this.ngChargeDateController,
    required this.typeOfNrController,
    required this.dateInstallationController,
    required this.regulatorTypeController,
    required this.delayReasonValue,
    required this.listOfDelayReason,
    required this.longOfMRController,
    required this.latOfMRController,
    required this.srPhoto,
    required this.mrPhoto,
    required this.extraPipeController,
    required this.extraPriceController,
    required this.rfcDateController,
  });
  @override
  List<Object?> get props => [
    isPageLoader,
    regulatorCheck,
    rfcPhoto,
    pneumaticPhoto,
    isMeterReplace,
    isRegularReplace,
    isBtnLoader,
    isDelayReason,
    isLatLongOfSRLoader,
    isLatLongOfMRLoader,
    isCheckMeterMismatch,
    meterPhoto,
    ngcReportPhoto,
    isRegulatorLoader,
    schema,
    lmcPath,
    baseUrl,
    userName,
    listOfTypeOfNr,
    typeOfNrValue,
    listOfMeterNumber,
    listOfMeterNumberSerial,
    listOfMeterNumberId,
    listOfRegulator,
    listOfRegulatorSerial,
    listOfSRSerial,
    listOfRegulatorId,
    listOfRegulatorType,
    listOfMeterType,
    listOfRegulatorTypeReason,
    regulatorTypeValue,
    meterTypeValue,
    regulatorTypeReasonValue,
    meterIniReading1FocusNode,
    meterIniReading2FocusNode,
    meterIniReading3FocusNode,
    meterIniReading1Controller,
    meterIniReading2Controller,
    meterIniReading3Controller,
    meterInitialReadingController,
    regulatorSerialSearchController,
    reasonMeterChangeController,
    reasonRegulatorChangeController,
    regulatorSerialController,
    proposedNgcDateController,
    ngConversionDateController,
    latOfSRController,
    longOfSRController,
    meterConnectionMeterController,
    nameContractorController,
    noOfFamilyMembersController,
    meterNumberSerialController,
    srNumberSearchController,
    srSerialNumberController,
    bpNumberController,
    delayReasonController,
    noOfBurnersController,
    meterSerialController,
    mobileNumberController,
    altMobileNumberController,
    emailIdController,
    ngChargeDateController,
    typeOfNrController,
    dateInstallationController,
    regulatorTypeController,
    delayReasonValue,
    listOfDelayReason,
    longOfMRController,
    latOfMRController,
    srPhoto,
    mrPhoto,
   extraPipeController,
    extraPriceController,
    rfcDateController,
  ];
}
