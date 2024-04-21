import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/DelayReason.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/TypeOfNrModel.dart';

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
  final ListOfMeterNo? meterNoValue;
  final TypeOfNrModel? typeOfNrValue;
  final DelayReason? delayReasonValue;
  final List<ListOfMeterNo> listOfMeterNo;
  final List<TypeOfNrModel> listOfTypeOfNr;
  final List<DelayReason> listOfDelayReason;
  final TextEditingController bpNumberController;
  final TextEditingController proposedDateController;
  final TextEditingController actualWorkDateController;
  final TextEditingController meterNoController;
  final TextEditingController meterIniReadingController;
  final TextEditingController meterReadingDateController;

  FormMeterDataState({
    required this.isLoader,
    required this.isBtnLoader,
    required this.meterImg,
    required this.meterNoValue,
    required this.typeOfNrValue,
    required this.delayReasonValue,
    required this.listOfMeterNo,
    required this.listOfTypeOfNr,
    required this.listOfDelayReason,
    required this.bpNumberController,
    required this.proposedDateController,
    required this.actualWorkDateController,
    required this.meterNoController,
    required this.meterIniReadingController,
    required this.meterReadingDateController,
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
        bpNumberController,
        proposedDateController,
        actualWorkDateController,
        meterNoController,
        meterIniReadingController,
        meterReadingDateController,
      ];
}
