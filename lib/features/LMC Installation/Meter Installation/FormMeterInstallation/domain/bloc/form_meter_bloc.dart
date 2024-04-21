import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_state.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/DelayReasonModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/helper/form_meter_helper.dart';

class FormMeterBloc extends Bloc<FormMeterEvent, FormMeterState> {
  FormMeterBloc() : super(FormMeterInitialState()) {
    on<FormMeterPageLoadEvent>(_pageLoad);
    on<SelectProposedDateEvent>(_selectProposedDate);
    on<SelectActualWorkDateEvent>(_selectActualWorkDate);
    on<SelectMeterReadingDateEvent>(_selectMeterReadingDate);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SubmitFormMeterEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  File meterImg = File("");

  ListOfMeterNo? meterNoValue;
  GetConstantModel? typeOfNrValue;
  DelayReasonModel? delayReasonValue;

  List<ListOfMeterNo> listOfMeterNo = [];
  List<GetConstantModel> listOfTypeOfNr = [];
  List<DelayReasonModel> listOfDelayReason = [];

  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController actualWorkDateController = TextEditingController();
  TextEditingController meterNoController = TextEditingController();
  TextEditingController meterIniReadingController = TextEditingController();
  TextEditingController meterReadingDateController = TextEditingController();

  _pageLoad(FormMeterPageLoadEvent event, emit) async {
    emit(FormMeterInitialState());
    isLoader = false;
    isBtnLoader = false;
    meterImg = File("");
    meterNoValue = null;
    typeOfNrValue = null;
    delayReasonValue = null;
    listOfMeterNo = [];
    listOfTypeOfNr = [];
    listOfDelayReason = [];
    bpNumberController.text = "";
    proposedDateController.text = "";
    actualWorkDateController.text = "";
    meterNoController.text = "";
    meterIniReadingController.text = "";
    meterReadingDateController.text = "";
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    await fetchTypeOfNrApi(context: event.context);
    listOfDelayReason = await DelayReasonModel.getCheckData();
    _eventCompleted(emit);
  }

  _selectProposedDate(SelectProposedDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      proposedDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectActualWorkDate(SelectActualWorkDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      actualWorkDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectMeterReadingDate(SelectMeterReadingDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      meterReadingDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectDelayReasonValue(SelectDelayReasonValueEvent event, emit) {
    delayReasonValue = event.delayReasonValue;
    _eventCompleted(emit);
  }

  _submit(SubmitFormMeterEvent event, emit) async {
    try {} catch (e) {
      print(e.toString());
      isBtnLoader = false;
      _eventCompleted(emit);
    }
  }

  fetchTypeOfNrApi({required BuildContext context}) async {
    var res = await FormMeterHelper.getTypeOfNrApi(context: context);
    if (res != null) {
      listOfTypeOfNr = res;
      return res;
    }
  }

  _eventCompleted(emit) {
    emit(FormMeterDataState(
        isLoader: isLoader,
        isBtnLoader: isBtnLoader,
        meterImg: meterImg,
        meterNoValue: meterNoValue,
        typeOfNrValue: typeOfNrValue,
        delayReasonValue: delayReasonValue,
        listOfMeterNo: listOfMeterNo,
        listOfTypeOfNr: listOfTypeOfNr,
        listOfDelayReason: listOfDelayReason,
        bpNumberController: bpNumberController,
        proposedDateController: proposedDateController,
        actualWorkDateController: actualWorkDateController,
        meterNoController: meterNoController,
        meterIniReadingController: meterIniReadingController,
        meterReadingDateController: meterReadingDateController));
  }
}
