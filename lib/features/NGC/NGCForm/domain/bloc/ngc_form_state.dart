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
  final String userName;
  final String schema;
  final String lmcPath;
  final String baseUrl;
  final File meterPhoto;
  final File rfcPhoto;
  final File pneumaticPhoto;
  final File ngcReportPhoto;
  final File mrPhoto;
  final File srPhoto;
  final bool isRegulator;
  final String regulatorCheck;
  final List<GetConstantModel> listOfTypeOfNr;
  final GetConstantModel typeOfNrValue;
  final LmcReasonModel regulatorTypeValue;
  final LmcReasonModel meterTypeValue;
  final LmcReasonModel regulatorTypeReasonValue;
  final List<ListOfMeterNo> listOfMeterNumber;
  final List<String> listOfMeterNumberSerial;
  final List<String> listOfMeterNumberId;
  final List<ListOfMeterNo> listOfRegulator;
  final List<String> listOfRegulatorSerial;
  final List<String> listOfSRSerial;
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
  final TextEditingController srNumberSearchController;
  final TextEditingController srSerialNumberController;
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
