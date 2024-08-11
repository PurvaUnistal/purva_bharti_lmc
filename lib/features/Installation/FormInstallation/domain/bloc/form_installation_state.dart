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
  bool isCheckMeterMismatch;
  bool isCheckRegulatorMismatch;
  bool isBtnLoader;
  bool isDelayReason;
  bool isRegulator;
  bool isSelected;
  File rfcCardImg;
  File pneumaticTestReportImg;
  File installationImg;
  File meterImg;
  ListOfMeterNo? meterNoValue;
  LmcReasonModel? delayReasonValue;
  GetConstantModel? typeOfNrValue;
  LmcReasonModel? regulatorTypeValue;
  List<ListOfMeterNo> listOfMeterNo;
  List<GetConstantModel> listOfTypeOfNr;
  List<LmcReasonModel> listOfDelayReason;
  List<LmcReasonModel> listOfRegulatorType;
  List<String> listOfMeterNumber;
  List<String> listOfRegulatorSerial;
  List<ListOfMeterNo> listOfRegulator;
  List<String> listOfQtyLMC;
  List<FreeMaterialData> listOfAllMaterial;
  List<GetConstantModel> listOfAllRFC;
  List<MaterialItem> materialList;
  FocusNode meterIniReading1FocusNode;
  FocusNode meterIniReading2FocusNode;
  FocusNode meterIniReading3FocusNode;
  TextEditingController latOfSRController;
  TextEditingController longOfSRController;
  TextEditingController latOfHouseController;
  TextEditingController longOfHouseController;
  TextEditingController rfcConDateController;
  TextEditingController proConDateController;
  TextEditingController extraPipeController;
  TextEditingController extraPriceController;
  TextEditingController bpNumberController;
  TextEditingController proposedDateController;
  TextEditingController installationDateController;
  TextEditingController meterIniReading1Controller;
  TextEditingController meterIniReading2Controller;
  TextEditingController meterIniReading3Controller;
  TextEditingController meterInitialReadingController;
  TextEditingController materialSerialController;
  TextEditingController regulatorSerialController;

  FormInstallationDataState({
    required this.userName,
    required this.schema,
    required this.isLoader,
    required this.isCheckRegulatorMismatch,
    required this.isCheckMeterMismatch,
    required this.isBtnLoader,
    required this.isDelayReason,
    required this.isRegulator,
    required this.meterImg,
    required this.isSelected,
    required this.rfcCardImg,
    required this.pneumaticTestReportImg,
    required this.installationImg,
    required this.meterNoValue,
    required this.typeOfNrValue,
    required this.delayReasonValue,
    required this.regulatorTypeValue,
    required this.listOfMeterNo,
    required this.listOfTypeOfNr,
    required this.listOfDelayReason,
    required this.listOfMeterNumber,
    required this.listOfRegulatorType,
    required this.listOfRegulatorSerial,
    required this.listOfRegulator,
    required this.listOfAllMaterial,
    required this.listOfAllRFC,
    required this.materialList,
    required this.listOfQtyLMC,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,
    required this.bpNumberController,
    required this.proposedDateController,
    required this.installationDateController,
    required this.meterIniReading1Controller,
    required this.meterIniReading2Controller,
    required this.meterIniReading3Controller,
    required this.meterInitialReadingController,
    required this.latOfSRController,
    required this.longOfSRController,
    required this.latOfHouseController,
    required this.longOfHouseController,
    required this.rfcConDateController,
    required this.proConDateController,
    required this.extraPipeController,
    required this.extraPriceController,
    required this.materialSerialController,
    required this.regulatorSerialController,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        schema,
        userName,
        isLoader,
        isCheckRegulatorMismatch,
        isCheckMeterMismatch,
        isBtnLoader,
        isDelayReason,
        isRegulator,
        meterImg,
        meterNoValue,
        typeOfNrValue,
        delayReasonValue,
        listOfMeterNo,
        listOfTypeOfNr,
        listOfDelayReason,
        listOfMeterNumber,
        regulatorTypeValue,
        listOfRegulatorType,
        bpNumberController,
        proposedDateController,
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
        rfcCardImg,
        pneumaticTestReportImg,
        installationImg,
        listOfRegulatorSerial,
        listOfRegulator,
        listOfAllMaterial,
        listOfAllRFC,
        materialList,
        latOfSRController,
        longOfSRController,
        latOfHouseController,
        longOfHouseController,
        rfcConDateController,
        proConDateController,
        extraPipeController,
        extraPriceController,
        materialSerialController,
        regulatorSerialController,
      ];
}
