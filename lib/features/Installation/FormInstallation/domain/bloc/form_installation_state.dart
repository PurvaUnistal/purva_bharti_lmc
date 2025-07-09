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

class FormInstallationPageLoadState extends FormInstallationInitialState {
  @override
  List<Object> get props => [];
}

class FormInstallationDataState extends FormInstallationInitialState {
  final String schema;
  final String userName;
  final bool isLoader;
  final bool isExtraPipe;
  final bool isInstallRegulator;
  final bool isCheckMeterMismatch;
  final bool isCheckRegulatorMismatch;
  final bool isBtnLoader;
  final bool isDelayReason;
  final bool isRegulator;
  final bool isSelected;
  final File rfcCardPhoto;
  final File pneumaticTestReportPhoto;
  final File installationPhoto;
  final File meterPhoto;
  final File housePhoto;
  final ListOfMeterNo meterNoValue;
  final LmcReasonModel delayReasonValue;
  final GetConstantModel typeOfNrValue;
  final LmcReasonModel regulatorTypeValue;
  final List<ListOfMeterNo> listOfMeterNumber;
  final List<GetConstantModel> listOfTypeOfNr;
  final List<LmcReasonModel> listOfDelayReason;
  final List<LmcReasonModel> listOfRegulatorType;
  final List<String> listOfMeterNumberSerial;
  final List<String> listOfRegulatorSerial;
  final List<String> listOfMRSerial;
  final List<ListOfMeterNo> listOfRegulator;
  final List<String> listOfQtyLMC;
  final List<FreeMaterialData> listOfAllMaterial;
  final List<GetConstantModel> listOfAllRFC;
  final List<MaterialItem> materialList;
  final FocusNode meterIniReading1FocusNode;
  final FocusNode meterIniReading2FocusNode;
  final FocusNode meterIniReading3FocusNode;

  final TextEditingController latOfHouseController;
  final TextEditingController longOfHouseController;
  final TextEditingController mrNumberController;
  final TextEditingController ngConversionDateController;
  final TextEditingController extraPipeController;
  final TextEditingController extraPriceController;
  final TextEditingController meterConnectionMeterController;
  final TextEditingController bpNumberController;
  final TextEditingController trNumberController;
  final TextEditingController proposedDateController;
  final TextEditingController rfcDateController;
  final TextEditingController feasibilityDateController;
  final TextEditingController installationDateController;
  final TextEditingController meterIniReading1Controller;
  final TextEditingController meterIniReading2Controller;
  final TextEditingController meterIniReading3Controller;
  final TextEditingController meterInitialReadingController;
  final TextEditingController meterNumberSerialController;
  final TextEditingController regulatorSerialController;

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
    required this.listOfMRSerial,
    required this.listOfRegulator,
    required this.listOfAllMaterial,
    required this.listOfAllRFC,
    required this.materialList,
    required this.listOfQtyLMC,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,
    required this.meterConnectionMeterController,
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
    required this.mrNumberController,
    required this.ngConversionDateController,
    required this.extraPipeController,
    required this.extraPriceController,
    required this.meterNumberSerialController,
    required this.regulatorSerialController,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
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
        meterConnectionMeterController,
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
    listOfMRSerial,
        listOfRegulator,
        listOfAllMaterial,
        listOfAllRFC,
        materialList,
        latOfHouseController,
        longOfHouseController,
        ngConversionDateController,
        mrNumberController,
        extraPipeController,
        extraPriceController,
        meterNumberSerialController,
        regulatorSerialController,
      ];
}
