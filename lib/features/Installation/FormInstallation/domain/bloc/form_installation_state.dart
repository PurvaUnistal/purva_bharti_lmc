import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';

abstract class FormInstallationState extends Equatable {

}

class FormInstallationInitialState extends FormInstallationState {
  @override
  List<Object> get props => [];
}

class FormInstallationPageLoadState extends FormInstallationInitialState {
  @override
  List<Object> get props => [];
}

class FormInstallationDataState extends FormInstallationInitialState {
  final bool isLoader;
  final bool isExtraPipe;
  final bool isInstallRegulator;
  final bool isCheckMeterMismatch;
  final bool isCheckRegulatorMismatch;
  final bool isBtnLoader;
  final bool isDelayReason;
  final bool isRegulator;
  final bool isSelected;
  final String tapOffValue;
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
  final TextEditingController tapOffLengthController;
  final List<String> selectedCoatTap;
  final List<String> coatTapList;
  final String selectedGasified;
  final List<String> gasifiedList;

  FormInstallationDataState({
    required this.tapOffValue,
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
    required this.tapOffLengthController,
    required this.selectedCoatTap,
    required this.coatTapList,
    required this.selectedGasified,
    required this.gasifiedList,

  });

  FormInstallationDataState copyWith({
    String? tapOffValue,
    bool? isLoader,
    bool? isExtraPipe,
    bool? isInstallRegulator,
    bool? isCheckMeterMismatch,
    bool? isCheckRegulatorMismatch,
    bool? isBtnLoader,
    bool? isDelayReason,
    bool? isRegulator,
    bool? isSelected,
    File? rfcCardPhoto,
    File? pneumaticTestReportPhoto,
    File? installationPhoto,
    File? meterPhoto,
    File? housePhoto,
    ListOfMeterNo? meterNoValue,
    LmcReasonModel? delayReasonValue,
    GetConstantModel? typeOfNrValue,
    LmcReasonModel? regulatorTypeValue,
    List<ListOfMeterNo>? listOfMeterNumber,
    List<GetConstantModel>? listOfTypeOfNr,
    List<LmcReasonModel>? listOfDelayReason,
    List<LmcReasonModel>? listOfRegulatorType,
    List<String>? listOfMeterNumberSerial,
    List<String>? listOfRegulatorSerial,
    List<String>? listOfMRSerial,
    List<String>? listOfQtyLMC,
    List<FreeMaterialData>? listOfAllMaterial,
    List<GetConstantModel>? listOfAllRFC,
    List<MaterialItem>? materialList,
    List<String>? selectedCoatTap,
    List<String>? coatTapList,
    String? selectedGasified,
    List<String>? gasifiedList,
  }) {
    return FormInstallationDataState(
      isLoader: isLoader ?? this.isLoader,
      tapOffValue: tapOffValue ?? this.tapOffValue,
      isExtraPipe: isExtraPipe ?? this.isExtraPipe,
      isInstallRegulator: isInstallRegulator ?? this.isInstallRegulator,
      isCheckMeterMismatch: isCheckMeterMismatch ?? this.isCheckMeterMismatch,
      isCheckRegulatorMismatch: isCheckRegulatorMismatch ?? this.isCheckRegulatorMismatch,
      isBtnLoader: isBtnLoader ?? this.isBtnLoader,
      isDelayReason: isDelayReason ?? this.isDelayReason,
      isRegulator: isRegulator ?? this.isRegulator,
      isSelected: isSelected ?? this.isSelected,
      rfcCardPhoto: rfcCardPhoto ?? this.rfcCardPhoto,
      pneumaticTestReportPhoto: pneumaticTestReportPhoto ?? this.pneumaticTestReportPhoto,
      installationPhoto: installationPhoto ?? this.installationPhoto,
      meterPhoto: meterPhoto ?? this.meterPhoto,
      housePhoto: housePhoto ?? this.housePhoto,
      meterNoValue: meterNoValue ?? this.meterNoValue,
      delayReasonValue: delayReasonValue ?? this.delayReasonValue,
      typeOfNrValue: typeOfNrValue ?? this.typeOfNrValue,
      regulatorTypeValue: regulatorTypeValue ?? this.regulatorTypeValue,
      listOfMeterNumber: listOfMeterNumber ?? this.listOfMeterNumber,
      listOfTypeOfNr: listOfTypeOfNr ?? this.listOfTypeOfNr,
      listOfDelayReason: listOfDelayReason ?? this.listOfDelayReason,
      listOfRegulatorType: listOfRegulatorType ?? this.listOfRegulatorType,
      listOfMeterNumberSerial: listOfMeterNumberSerial ?? this.listOfMeterNumberSerial,
      listOfRegulatorSerial: listOfRegulatorSerial ?? this.listOfRegulatorSerial,
      listOfMRSerial: listOfMRSerial ?? this.listOfMRSerial,
      listOfQtyLMC: listOfQtyLMC ?? this.listOfQtyLMC,
      listOfAllMaterial: listOfAllMaterial ?? this.listOfAllMaterial,
      listOfAllRFC: listOfAllRFC ?? this.listOfAllRFC,
      materialList: materialList ?? this.materialList,
      selectedCoatTap: selectedCoatTap ?? this.selectedCoatTap,
      gasifiedList: gasifiedList ?? this.gasifiedList,
      coatTapList: coatTapList ?? this.coatTapList,
      selectedGasified: selectedGasified ?? this.selectedGasified,
      meterIniReading1FocusNode: meterIniReading1FocusNode,
      meterIniReading2FocusNode: meterIniReading2FocusNode,
      meterIniReading3FocusNode: meterIniReading3FocusNode,
      meterConnectionMeterController: meterConnectionMeterController,
      bpNumberController: bpNumberController,
      trNumberController: trNumberController,
      proposedDateController: proposedDateController,
      rfcDateController: rfcDateController,
      feasibilityDateController: feasibilityDateController,
      installationDateController: installationDateController,
      meterIniReading1Controller: meterIniReading1Controller,
      meterIniReading2Controller: meterIniReading2Controller,
      meterIniReading3Controller: meterIniReading3Controller,
      meterInitialReadingController: meterInitialReadingController,
      latOfHouseController: latOfHouseController,
      longOfHouseController: longOfHouseController,
      mrNumberController: mrNumberController,
      ngConversionDateController: ngConversionDateController,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
      meterNumberSerialController: meterNumberSerialController,
      regulatorSerialController: regulatorSerialController,
      tapOffLengthController: tapOffLengthController,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
    tapOffValue,
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
    tapOffLengthController,
    selectedCoatTap,
    coatTapList,
    selectedGasified,
      ];
}
