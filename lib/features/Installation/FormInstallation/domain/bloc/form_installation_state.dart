import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';

abstract class FormInstallationState extends Equatable {}

class FormInstallationInitialState extends FormInstallationState {
  @override
  List<Object> get props => [];
}

class FormInstallationPageLoadState extends FormInstallationState {
  @override
  List<Object> get props => [];
}

class FormInstallationDataState extends FormInstallationState {
  String schema;
  String userName;
  bool isLoader;
  bool isExtraPipe;
  bool isInstallRegulator;
  bool isCheckMeterMismatch;
  bool isCheckRegulatorMismatch;
  bool isBtnLoader;
  bool isDelayReason;
  bool isRegulator;
  bool isSelected;
  File rfcCardPhoto;
  File pneumaticTestReportPhoto;
  File installationPhoto;
  File meterPhoto;
  File housePhoto;
  ListOfMeterNo? meterNoValue;
  LmcReasonModel? delayReasonValue;
  GetConstantModel? typeOfNrValue;
  LmcReasonModel? regulatorTypeValue;
  List<ListOfMeterNo> listOfMeterNumber;
  List<GetConstantModel> listOfTypeOfNr;
  List<LmcReasonModel> listOfDelayReason;
  List<LmcReasonModel> listOfRegulatorType;
  List<String> listOfMeterNumberSerial;
  List<String> listOfRegulatorSerial;
  List<String> listOfSRSerial;
  List<ListOfMeterNo> listOfRegulator;
  List<String> listOfQtyLMC;
  List<FreeMaterialData> listOfAllMaterial;
  List<GetConstantModel> listOfAllRFC;
  List<MaterialItem> materialList;
  FocusNode meterIniReading1FocusNode;
  FocusNode meterIniReading2FocusNode;
  FocusNode meterIniReading3FocusNode;

  TextEditingController latOfHouseController;
  TextEditingController longOfHouseController;
  TextEditingController srNumberController;
  TextEditingController ngConversionDateController;
  TextEditingController extraPipeController;
  TextEditingController extraPriceController;
  TextEditingController bpNumberController;
  TextEditingController trNumberController;
  TextEditingController proposedDateController;
  TextEditingController rfcDateController;
  TextEditingController feasibilityDateController;
  TextEditingController installationDateController;
  TextEditingController meterIniReading1Controller;
  TextEditingController meterIniReading2Controller;
  TextEditingController meterIniReading3Controller;
  TextEditingController meterInitialReadingController;
  TextEditingController meterNumberSerialController;
  TextEditingController regulatorSerialController;

  FormInstallationDataState({
    required this.userName,
    required this.schema,
    required this.isInstallRegulator,
    required this.isLoader,
    required this.isExtraPipe,
    required this.isCheckRegulatorMismatch,
    required this.isCheckMeterMismatch,
    required this.isBtnLoader,
    required this.isDelayReason,
    required this.isRegulator,
    required this.meterPhoto,
    required this.housePhoto,
    required this.isSelected,
    required this.rfcCardPhoto,
    required this.pneumaticTestReportPhoto,
    required this.installationPhoto,
    required this.meterNoValue,
    required this.typeOfNrValue,
    required this.delayReasonValue,
    required this.regulatorTypeValue,
    required this.listOfMeterNumberSerial,
    required this.listOfTypeOfNr,
    required this.listOfDelayReason,
    required this.listOfMeterNumber,
    required this.listOfRegulatorType,
    required this.listOfRegulatorSerial,
    required this.listOfSRSerial,
    required this.listOfRegulator,
    required this.listOfAllMaterial,
    required this.listOfAllRFC,
    required this.materialList,
    required this.listOfQtyLMC,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,
    required this.bpNumberController,
    required this.trNumberController,
    required this.proposedDateController,
    required this.rfcDateController,
    required this.feasibilityDateController,
    required this.installationDateController,
    required this.meterIniReading1Controller,
    required this.meterIniReading2Controller,
    required this.meterIniReading3Controller,
    required this.meterInitialReadingController,
    required this.latOfHouseController,
    required this.longOfHouseController,
    required this.srNumberController,
    required this.ngConversionDateController,
    required this.extraPipeController,
    required this.extraPriceController,
    required this.meterNumberSerialController,
    required this.regulatorSerialController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        schema,
        userName,
        isLoader,
    isExtraPipe,
    isInstallRegulator,
        isCheckRegulatorMismatch,
        isCheckMeterMismatch,
        isBtnLoader,
        isDelayReason,
        isRegulator,
        meterPhoto,
    housePhoto,
        meterNoValue,
        typeOfNrValue,
        delayReasonValue,
        listOfMeterNumberSerial,
        listOfTypeOfNr,
        listOfDelayReason,
        listOfMeterNumber,
        regulatorTypeValue,
        listOfRegulatorType,
        bpNumberController,
    trNumberController,
        proposedDateController,
    rfcDateController,
    feasibilityDateController,
        installationDateController,
        meterIniReading1Controller,
        meterIniReading2Controller,
        meterIniReading3Controller,
        meterInitialReadingController,
        meterIniReading1FocusNode,
        meterIniReading2FocusNode,
        meterIniReading3FocusNode,
        isSelected,
        listOfQtyLMC,
        rfcCardPhoto,
        pneumaticTestReportPhoto,
        installationPhoto,
        listOfRegulatorSerial,
    listOfSRSerial,
        listOfRegulator,
        listOfAllMaterial,
        listOfAllRFC,
        materialList,
        latOfHouseController,
        longOfHouseController,
        ngConversionDateController,
    srNumberController,
        extraPipeController,
        extraPriceController,
        meterNumberSerialController,
        regulatorSerialController,
      ];
}
