import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/NGC/NGCForm/domain/model/delay_status_model.dart';

abstract class NGCFormState extends Equatable {}

class NGCFormInitialState extends NGCFormState {
  @override
  List<Object> get props => [];
}

class NGCFormPageLoadState extends NGCFormInitialState {
  @override
  List<Object> get props => [];
}

class NGCFormDataState extends NGCFormState {
  bool isPageLoader;
  bool isBtnLoader;
  bool isMeterReplace;
  File meterPhoto;
  File ngcReportPhoto;
  bool isRegulator;
  LmcReasonModel? regulatorTypeValue;
  List<ListOfMeterNo> listOfMeterNumber;
  List<String> listOfMeterNumberSerial;
  List<String> listOfMeterNumberId;
  List<ListOfMeterNo> listOfRegulator;
  List<String> listOfRegulatorSerial;
  List<String> listOfRegulatorId;
  List<LmcReasonModel> listOfRegulatorType;
  TextEditingController rfcDecDateController;
  TextEditingController ngcChargeDateController;
  TextEditingController proposedNgcConversionDateController;
  TextEditingController latOfSRController;
  TextEditingController longOfSRController;
  TextEditingController latOfHouseController;
  TextEditingController longOfHouseController;
  TextEditingController nameContractorController;
  TextEditingController bpNumberController;
  TextEditingController meterReaderController;
  TextEditingController noOfBurnersController;
  TextEditingController meterNoMismatchController;
  TextEditingController mobileNumberController;
  TextEditingController altMobileNumberController;
  TextEditingController emailIdController;
  TextEditingController ngChargeDateController;
  TextEditingController delayReasonController;
  TextEditingController typeOfNrController;
  LmcReasonModel? delayReasonValue;
  List<LmcReasonModel> listOfDelayReason;
  NGCFormDataState({
    required this.isPageLoader,
    required this.isBtnLoader,
    required this.isMeterReplace,
    required this.meterPhoto,
    required this.ngcReportPhoto,
    required this.isRegulator,

    required this.listOfMeterNumber,
    required this.listOfMeterNumberSerial,
    required this.listOfMeterNumberId,


    required this.listOfRegulator,
    required this.listOfRegulatorSerial,
    required this.listOfRegulatorId,
    required this.listOfRegulatorType,
    required this.regulatorTypeValue,

    required this.rfcDecDateController,
    required this.ngcChargeDateController,
    required this.proposedNgcConversionDateController,
    required this.latOfSRController,
    required this.longOfSRController,
    required this.latOfHouseController,
    required this.longOfHouseController,
    required this.nameContractorController,
    required this.bpNumberController,
    required this.meterReaderController,
    required this.noOfBurnersController,
    required this.meterNoMismatchController,
    required this.mobileNumberController,
    required this.altMobileNumberController,
    required this.emailIdController,
    required this.ngChargeDateController,
    required this.delayReasonController,
    required this.typeOfNrController,
    required this.delayReasonValue,
    required this.listOfDelayReason,
      });
  @override
  List<Object?> get props => [
    isPageLoader,
    isMeterReplace,
    isBtnLoader,
    meterPhoto,
    ngcReportPhoto,
    isRegulator,

    listOfMeterNumber,
    listOfMeterNumberSerial,
    listOfMeterNumberId,

    listOfRegulator,
    listOfRegulatorSerial,
    listOfRegulatorId,
    listOfRegulatorType,
    regulatorTypeValue,
    rfcDecDateController,
    ngcChargeDateController,
    proposedNgcConversionDateController,
    latOfSRController,
    longOfSRController,
    latOfHouseController,
    longOfHouseController,

    nameContractorController,
    bpNumberController,
    meterReaderController,
    noOfBurnersController,
    meterNoMismatchController,
    mobileNumberController,
    altMobileNumberController,
    emailIdController,
    ngChargeDateController,
    delayReasonController,
    typeOfNrController,
    delayReasonValue,
    listOfDelayReason,
      ];
}
