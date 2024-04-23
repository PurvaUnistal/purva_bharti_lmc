import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/DelayReasonModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';

abstract class FormMeterState extends Equatable {}

class FormMeterInitialState extends FormMeterState {
  @override
  List<Object> get props => [];
}

class FormMeterPageLoadState extends FormMeterState {
  @override
  List<Object> get props => [];
}

class FormMeterDataState extends FormMeterState {
  final bool isLoader;
  final bool isBtnLoader;
  final File meterImg;
  final String materialId;
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
  final TextEditingController meterNoController;
  final TextEditingController meterIniReading1Controller;
  final TextEditingController meterIniReading2Controller;
  final TextEditingController meterIniReading3Controller;
  final TextEditingController meterInitialReadingController;
  final TextEditingController meterReadingDateController;
  final FocusNode meterIniReading1FocusNode;
  final FocusNode meterIniReading2FocusNode;
  final FocusNode meterIniReading3FocusNode;


  FormMeterDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.meterImg,
    required this.materialId,
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
    required this.meterNoController,
    required this.meterIniReading1Controller,
    required this.meterIniReading2Controller,
    required this.meterIniReading3Controller,
    required this.meterInitialReadingController,
    required this.meterReadingDateController,
    required this.meterIniReading1FocusNode,
    required this.meterIniReading2FocusNode,
    required this.meterIniReading3FocusNode,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoader,
    isBtnLoader,
    meterImg,
    materialId,
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
    meterNoController,
    meterIniReading1Controller,
    meterIniReading2Controller,
    meterIniReading3Controller,
    meterInitialReadingController,
    meterReadingDateController,
    meterIniReading1FocusNode,
   meterIniReading2FocusNode,
    meterIniReading3FocusNode,
  ];
}
