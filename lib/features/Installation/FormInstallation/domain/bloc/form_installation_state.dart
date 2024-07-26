import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/DelayReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MaterialItem.dart';
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
  final bool isLoader;
  final bool isBtnLoader;
  final File meterImg;
  final ListOfMeterNo? meterNoValue;
  final GetConstantModel? typeOfNrValue;
  final DelayReasonModel? delayReasonValue;
  final List<ListOfMeterNo> listOfMeterNo;
  final List<GetConstantModel> listOfTypeOfNr;
  final List<DelayReasonModel> listOfDelayReason;
  final List<String> listOfMeterNumber;
  final TextEditingController bpNumberController;
  final TextEditingController proposedDateController;
  final TextEditingController actualWorkDateController;
  final TextEditingController meterIniReading1Controller;
  final TextEditingController meterIniReading2Controller;
  final TextEditingController meterIniReading3Controller;
  final TextEditingController meterInitialReadingController;
  final TextEditingController meterReadingDateController;
  final FocusNode meterIniReading1FocusNode;
  final FocusNode meterIniReading2FocusNode;
  final FocusNode meterIniReading3FocusNode;
  bool isSelected;
  File rfcCardImg;
  File pneumaticTestReportImg;
  File installationImg;
  List<ListOfMeterNo> listOfRegulatorNo;
  List<String> listOfRegulator;
  List<String> listOfQtyLMC;
  List<FreeMaterialData> listOfAllMaterial;
  List<GetConstantModel> listOfAllRFC;
  List<MaterialItem> materialList;
  TextEditingController srNumberController;
  TextEditingController latOfSRController;
  TextEditingController longOfSRController;
  TextEditingController latOfHouseController;
  TextEditingController longOfHouseController;
  TextEditingController rfcConDateController;
  TextEditingController proConDateController;
  TextEditingController extraPipeController;
  TextEditingController extraPriceController;


  FormInstallationDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.meterImg,
    required this.meterNoValue,
    required this.typeOfNrValue,
    required this.delayReasonValue,
    required this.listOfMeterNo,
    required this.listOfTypeOfNr,
    required this.listOfDelayReason,
    required this.listOfMeterNumber,
    required this.bpNumberController,
    required this.proposedDateController,
    required this.actualWorkDateController,
    required this.meterIniReading1Controller,
    required this.meterIniReading2Controller,
    required this.meterIniReading3Controller,
    required this.meterInitialReadingController,
    required this.meterReadingDateController,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,
    required this.isSelected,
    required this.rfcCardImg,
    required this.listOfQtyLMC,
    required this.pneumaticTestReportImg,
    required this.installationImg,
    required this.listOfRegulatorNo,
    required this.listOfRegulator,
    required this.listOfAllMaterial,
    required this.listOfAllRFC,
    required this.materialList,
    required this.srNumberController,
    required this.latOfSRController,
    required this.longOfSRController,
    required this.latOfHouseController,
    required this.longOfHouseController,
    required this.rfcConDateController,
    required this.proConDateController,
    required this.extraPipeController,
    required this.extraPriceController,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    isBtnLoader,
    meterImg,
    meterNoValue,
    typeOfNrValue,
    delayReasonValue,
    listOfMeterNo,
    listOfTypeOfNr,
    listOfDelayReason,
    listOfMeterNumber,
    bpNumberController,
    proposedDateController,
    actualWorkDateController,
    meterIniReading1Controller,
    meterIniReading2Controller,
    meterIniReading3Controller,
    meterInitialReadingController,
    meterReadingDateController,
    meterIniReading1FocusNode,
    meterIniReading2FocusNode,
    meterIniReading3FocusNode,
    isSelected,
    listOfQtyLMC,
    rfcCardImg,
    pneumaticTestReportImg,
    installationImg,
    listOfRegulatorNo,
    listOfRegulator,
    listOfAllMaterial,
    listOfAllRFC,
    materialList,
    srNumberController,
    latOfSRController,
    longOfSRController,
    latOfHouseController,
    longOfHouseController,
    rfcConDateController,
    proConDateController,
    extraPipeController,
    extraPriceController,
  ];
}
