import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Meter/FormMeter/domain/bloc/form_Meter_event.dart';
import 'package:lmc/features/Meter/FormMeter/domain/bloc/form_Meter_state.dart';
import 'package:lmc/features/Meter/FormMeter/domain/model/CheckFeasibleModel.dart';
import 'package:lmc/features/Meter/FormMeter/helper/form_Meter_helper.dart';

class FormMeterBloc extends Bloc<FormMeterEvent, FormMeterState> {
  FormMeterBloc() : super(FormMeterInitialState()) {
    on<FormMeterPageLoadEvent>(_pageLoad);
    on<SelectProposedDateEvent>(_selectProposedDate);
    on<SelectMeterDateEvent>(_selectMeterDate);
    on<SelectCheckMeterValueEvent>(_selectCheckMeterValue);
    on<SubmitFormMeterEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  CheckFeasibleModel? checkFeasibleValue;
  CheckFeasibleModel? lmcReasonValue;
  List<CheckFeasibleModel> listOfCheckFeasible = [];
  List<CheckFeasibleModel> listOfLMCReason = [];
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController MeterDateController = TextEditingController();

  _pageLoad(FormMeterPageLoadEvent event, emit) async {
    emit(FormMeterInitialState());
    isLoader = false;
    isBtnLoader = false;
    checkFeasibleValue = null;
    lmcReasonValue = null;
    listOfCheckFeasible = [];
    listOfLMCReason = [];
    proposedDateController.text = '';
    MeterDateController.text = '';
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    await fetchCheckMeterApi(context: event.context);
    await fetchLMCReasonApi(context: event.context);
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

  _selectMeterDate(SelectMeterDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      MeterDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectCheckMeterValue(SelectCheckMeterValueEvent event, emit) {
    checkFeasibleValue = event.checkMeter;
    _eventCompleted(emit);
  }

  _submit(SubmitFormMeterEvent event, emit) async {
    try {
      var validationCheck = await FormMeterHelper.validationSubmit(
        context: event.context,
        MeterDate: MeterDateController.text.trim().toString(),
        isFeasible: checkFeasibleValue,
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormMeterHelper.saveLmcMeter(context: event.context, MeterDate: MeterDateController.text.toString(), isFeasible: checkFeasibleValue!);
        if (res != null) {
          isBtnLoader = false;
          _eventCompleted(emit);
          Utils.successSnackBar(msg: res.data!, context: event.context);
          Navigator.pushReplacementNamed(
            event.context,
            RoutesName.lmcMeter,
          );
        } else {
          isBtnLoader = false;
          _eventCompleted(emit);
        }
      }
    } catch (e) {
      print(e.toString());
      isBtnLoader = false;
      _eventCompleted(emit);
    }
  }

  fetchCheckMeterApi({required BuildContext context}) async {
    var res = await FormMeterHelper.getCheckMeterApi(context: context);
    if (res != null) {
      listOfCheckFeasible = res;
      return res;
    }
  }

  fetchLMCReasonApi({required BuildContext context}) async {
    var res = await FormMeterHelper.getLMCReasonApi(context: context);
    if (res != null) {
      listOfLMCReason = res;
      return res;
    }
  }

  _eventCompleted(emit) {
    emit(FormMeterDataState(
        isLoader: isLoader,
        isBtnLoader: isBtnLoader,
        checkFeasibleValue: checkFeasibleValue,
        lmcReasonValue: lmcReasonValue,
        listOfCheckFeasible: listOfCheckFeasible,
        listOfLMCReason: listOfLMCReason,
        bpNumberController: bpNumberController,
        proposedDateController: proposedDateController,
        MeterDateController: MeterDateController));
  }
}
