import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';

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
  bool isDelayReason;
  String userName;
  String schema;
  String lmcPath;
  String baseUrl;
  File meterPhoto;
  File ngcReportPhoto;
  File mrPhoto;
  File srPhoto;
  bool isRegulator;
  List<GetConstantModel> listOfTypeOfNr;
  GetConstantModel? typeOfNrValue;
  LmcReasonModel? regulatorTypeValue;
  LmcReasonModel? meterTypeValue;
  List<ListOfMeterNo> listOfMeterNumber;
  List<String> listOfMeterNumberSerial;
  List<String> listOfMeterNumberId;
  List<ListOfMeterNo> listOfRegulator;
  List<String> listOfRegulatorSerial;
  List<String> listOfSRSerial;
  List<String> listOfRegulatorId;
  List<LmcReasonModel> listOfRegulatorType;
  List<LmcReasonModel> listOfMeterType;
  FocusNode meterIniReading1FocusNode;
  FocusNode meterIniReading2FocusNode;
  FocusNode meterIniReading3FocusNode;
  TextEditingController meterIniReading1Controller;
  TextEditingController meterIniReading2Controller;
  TextEditingController meterIniReading3Controller;
  TextEditingController meterInitialReadingController;
  TextEditingController regulatorSerialController;
  TextEditingController meterConnectionMeterController;
  TextEditingController proposedNgcDateController;
  TextEditingController noOfFamilyMembersController;
  TextEditingController ngConversionDateController;
  TextEditingController latOfSRController;
  TextEditingController longOfSRController;
  TextEditingController nameContractorController;
  TextEditingController srNumberController;
  TextEditingController meterNumberSerialController;
  TextEditingController bpNumberController;
  TextEditingController delayReasonController;
  TextEditingController reasonMeterChangeController;
  TextEditingController noOfBurnersController;
  TextEditingController meterSerialController;
  TextEditingController mobileNumberController;
  TextEditingController altMobileNumberController;
  TextEditingController emailIdController;
  TextEditingController ngChargeDateController;
  TextEditingController typeOfNrController;
  TextEditingController dateInstallationController;
  LmcReasonModel? delayReasonValue;
  List<LmcReasonModel> listOfDelayReason;
  TextEditingController latOfMRController;
  TextEditingController longOfMRController;
  NGCFormDataState({
    required this.isPageLoader,
    required this.isBtnLoader,
    required this.isDelayReason,
    required this.isCheckMeterMismatch,
    required this.isMeterReplace,
    required this.meterPhoto,
    required this.ngcReportPhoto,
    required this.isRegulator,
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
    required this.regulatorTypeValue,
    required this.meterTypeValue,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,
    required this.meterIniReading1Controller,
    required this.meterIniReading2Controller,
    required this.meterIniReading3Controller,
    required this.meterInitialReadingController,
    required this.regulatorSerialController,
    required this.meterConnectionMeterController,
    required this.proposedNgcDateController,
    required this.noOfFamilyMembersController,
    required this.ngConversionDateController,
    required this.latOfSRController,
    required this.longOfSRController,
    required this.nameContractorController,
    required this.srNumberController,
    required this.meterNumberSerialController,
    required this.bpNumberController,
    required this.delayReasonController,
    required this.reasonMeterChangeController,
    required this.noOfBurnersController,
    required this.meterSerialController,
    required this.mobileNumberController,
    required this.altMobileNumberController,
    required this.emailIdController,
    required this.ngChargeDateController,
    required this.typeOfNrController,
    required this.dateInstallationController,
    required this.delayReasonValue,
    required this.listOfDelayReason,
    required this.longOfMRController,
    required this.latOfMRController,
    required this.srPhoto,
    required this.mrPhoto,
  });
  @override
  List<Object?> get props => [
        isPageLoader,
        isMeterReplace,
        isBtnLoader,
        isDelayReason,
        isCheckMeterMismatch,
        meterPhoto,
        ngcReportPhoto,
        isRegulator,
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
        regulatorTypeValue,
        meterTypeValue,
        meterIniReading1FocusNode,
        meterIniReading2FocusNode,
        meterIniReading3FocusNode,
        meterIniReading1Controller,
        meterIniReading2Controller,
        meterIniReading3Controller,
        meterInitialReadingController,
        regulatorSerialController,
        proposedNgcDateController,
        ngConversionDateController,
        latOfSRController,
        longOfSRController,
        meterConnectionMeterController,
        nameContractorController,
        noOfFamilyMembersController,
        meterNumberSerialController,
        srNumberController,
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
        delayReasonValue,
        listOfDelayReason,
        longOfMRController,
        latOfMRController,
        srPhoto,
        mrPhoto,
      ];
}
