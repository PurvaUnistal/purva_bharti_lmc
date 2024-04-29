import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/model/MaterialItem.dart';

abstract class FormRFCState extends Equatable {}

class FormRFCInitialState extends FormRFCState {
  @override
  List<Object> get props => [];
}

class FormRFCPageLoadState extends FormRFCState {
  @override
  List<Object> get props => [];
}

class FormRFCDataState extends FormRFCState {
  bool isLoader;
  bool isBtnLoader;
  bool isSelected;
  File rfcCardImg;
  File pneumaticTestReportImg;
  File installationImg;
  List<ListOfMeterNo> listOfRegulatorNo;
  List<String> listOfRegulator;
  List<FreeMaterialData> listOfAllMaterial;
  List<GetConstantModel> listOfAllRFC;
  List<MaterialItem> materialList;
  TextEditingController srNumberController;
  TextEditingController regulatorController;
  TextEditingController latOfSRController;
  TextEditingController longOfSRController;
  TextEditingController latOfHouseController;
  TextEditingController longOfHouseController;
  TextEditingController rfcConDateController;
  TextEditingController proConDateController;
  TextEditingController extraPipeController;
  TextEditingController extraPriceController;

  FormRFCDataState({
  required this.isLoader,
  required this.isBtnLoader,
  required this.isSelected,
  required this.rfcCardImg,
  required this.pneumaticTestReportImg,
  required this.installationImg,
  required this.listOfRegulatorNo,
  required this.listOfRegulator,
  required this.listOfAllMaterial,
  required this.listOfAllRFC,
  required this.materialList,
  required this.srNumberController,
  required this.regulatorController,
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
    isSelected,
    rfcCardImg,
    pneumaticTestReportImg,
    installationImg,
    listOfRegulatorNo,
    listOfRegulator,
    listOfAllMaterial,
    listOfAllRFC,
    materialList,
    srNumberController,
    regulatorController,
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
