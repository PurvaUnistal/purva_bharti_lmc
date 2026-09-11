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

class NGCFormDataState extends NGCFormInitialState {
  final bool isPageLoader;
  final bool isBtnLoader;
  final bool isCheckMeterMismatch;
  final bool isMeterReplace;
  final bool isRegularReplace;
  final bool isDelayReason;
  final String lmcPath;
  final String baseUrl;
  final File meterPhoto;
  final File rfcPhoto;
  final File pneumaticPhoto;
  final File ngcReportPhoto;
  final File mrPhoto;
  final File srPhoto;
  final bool isRegulator;
  final bool isSRLatLong;
  final bool isMRLatLong;
  final String regulatorCheck;
  final List<GetConstantModel> listOfTypeOfNr;
  final GetConstantModel typeOfNrValue;
  final LmcReasonModel regulatorTypeValue;
  final LmcReasonModel meterTypeValue;
  final LmcReasonModel regulatorTypeReasonValue;
  final List<ListOfMeterNo> listOfMeterNumber;
  final List<String> listOfMeterNumberSerial;
  final List<String> listOfMeterNumberId;
  final List<String> listOfRegulatorSerial;
  final List<String> listOfMRSerial;
  final List<String> listOfRegulatorId;
  final List<LmcReasonModel> listOfRegulatorType;
  final List<LmcReasonModel> listOfMeterType;
  final List<LmcReasonModel> listOfRegulatorTypeReason;
  final FocusNode meterIniReading1FocusNode;
  final FocusNode meterIniReading2FocusNode;
  final FocusNode meterIniReading3FocusNode;
  final TextEditingController meterIniReading1Controller;
  final TextEditingController meterIniReading2Controller;
  final TextEditingController meterIniReading3Controller;
  final TextEditingController meterInitialReadingController;
  final TextEditingController regulatorSerialSearchController;
  final TextEditingController regulatorSerialController;
  final TextEditingController meterConnectionMeterController;
  final TextEditingController proposedNgcDateController;
  final TextEditingController noOfFamilyMembersController;
  final TextEditingController ngConversionDateController;
  final TextEditingController latOfSRController;
  final TextEditingController longOfSRController;
  final TextEditingController nameContractorController;
  final TextEditingController mrNumberSearchController;
  final TextEditingController mrSerialNumberController;
  final TextEditingController meterNumberSerialController;
  final TextEditingController bpNumberController;
  final TextEditingController delayReasonController;
  final TextEditingController reasonMeterChangeController;
  final TextEditingController reasonRegulatorChangeController;
  final TextEditingController noOfBurnersController;
  final TextEditingController meterSerialController;
  final TextEditingController mobileNumberController;
  final TextEditingController altMobileNumberController;
  final TextEditingController emailIdController;
  final TextEditingController correctionFactorController;
  final TextEditingController ngChargeDateController;
  final TextEditingController typeOfNrController;
  final TextEditingController dateInstallationController;
  final TextEditingController regulatorTypeController;
  final LmcReasonModel delayReasonValue;
  final List<LmcReasonModel> listOfDelayReason;
  final TextEditingController latOfMRController;
  final TextEditingController longOfMRController;
  final TextEditingController extraPipeController;
  final TextEditingController extraPriceController;
  final TextEditingController rfcDateController;

  NGCFormDataState({
    required this.isPageLoader,
    required this.regulatorCheck,
    required this.rfcPhoto,
    required this.pneumaticPhoto,
    required this.isBtnLoader,
    required this.isDelayReason,
    required this.isCheckMeterMismatch,
    required this.isMeterReplace,
    required this.isRegularReplace,
    required this.isSRLatLong,
    required this.isMRLatLong,
    required this.meterPhoto,
    required this.ngcReportPhoto,
    required this.isRegulator,
    required this.lmcPath,
    required this.baseUrl,
    required this.listOfTypeOfNr,
    required this.typeOfNrValue,
    required this.listOfMeterNumber,
    required this.listOfMeterNumberSerial,
    required this.listOfMeterNumberId,
    required this.listOfRegulatorSerial,
    required this.listOfMRSerial,
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
    required this.mrNumberSearchController,
    required this.mrSerialNumberController,
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
    required this.correctionFactorController,
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
  List<Object> get props => [
        isPageLoader,
        regulatorCheck,
        rfcPhoto,
        pneumaticPhoto,
        isMeterReplace,
        isRegularReplace,
        isBtnLoader,
        isDelayReason,
        isCheckMeterMismatch,
    isSRLatLong,
    isMRLatLong,
        meterPhoto,
        ngcReportPhoto,
        isRegulator,
        lmcPath,
        baseUrl,
        listOfTypeOfNr,
        typeOfNrValue,
        listOfMeterNumber,
        listOfMeterNumberSerial,
        listOfMeterNumberId,
        listOfRegulatorSerial,
        listOfMRSerial,
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
        mrNumberSearchController,
        mrSerialNumberController,
        bpNumberController,
        delayReasonController,
        noOfBurnersController,
        meterSerialController,
        mobileNumberController,
        altMobileNumberController,
        emailIdController,
    correctionFactorController,
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
