import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_event.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_state.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/helper/form_feasibility_helper.dart';

class FormFeasibilityBloc extends Bloc<FormFeasibilityEvent, FormFeasibilityState> {
  FormFeasibilityBloc() : super(FormFeasibilityInitialState()) {
    on<FormFeasibilityPageLoadEvent>(_pageLoad);
    on<SelectProposedDateEvent>(_selectProposedDate);
    on<SelectFeasibilityDateEvent>(_selectFeasibilityDate);
    on<SelectFollowUpDateEvent>(_selectFollowUpDate);
    on<SelectCheckFeasibilityValueEvent>(_selectCheckFeasibilityValue);
    on<SelectLMCReasonValueEvent>(_selectLMCReasonValue);
    on<SubmitFormFeasibilityEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  GetConstantModel? checkFeasibleValue;
  GetConstantModel? lmcReasonValue;
  List<GetConstantModel> listOfCheckFeasible = [];
  List<GetConstantModel> listOfLMCReason = [];
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController followUpDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  _pageLoad(FormFeasibilityPageLoadEvent event, emit) async {
    emit(FormFeasibilityInitialState());
    isLoader = false;
    isBtnLoader = false;
    checkFeasibleValue = null;
    lmcReasonValue = null;
    listOfCheckFeasible = [];
    listOfLMCReason = [];
    proposedDateController.text = '';
    reasonController.text = '';
    followUpDateController.text = '';
    feasibilityDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    await fetchCheckFeasibilityApi(context: event.context);
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

  _selectFeasibilityDate(SelectFeasibilityDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      feasibilityDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }
  _selectFollowUpDate(SelectFollowUpDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      followUpDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }
  _selectCheckFeasibilityValue(SelectCheckFeasibilityValueEvent event, emit) {
    checkFeasibleValue = event.checkFeasibility;
    print(checkFeasibleValue!.key);
    _eventCompleted(emit);
  }

  _selectLMCReasonValue(SelectLMCReasonValueEvent event, emit) {
    lmcReasonValue = event.lmcReasonValue;
    print(lmcReasonValue);
    _eventCompleted(emit);
  }

  _submit(SubmitFormFeasibilityEvent event, emit) async {
    try {
      var validationCheck = await FormFeasibilityHelper.validationSubmit(
        context: event.context,
        feasibilityDate: feasibilityDateController.text.trim().toString(),
        isFeasible: checkFeasibleValue,
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res =
        await FormFeasibilityHelper.saveLmcFeasibility(
            context: event.context,
            feasibilityDate: feasibilityDateController.text..trim().toString(),
            isFeasible: checkFeasibleValue!,
            comment: reasonController.text..trim().toString(),
          followUpDate: followUpDateController.text..trim().toString(),
        );
        if (res != null && res.error == false) {
          isBtnLoader = false;
          _eventCompleted(emit);
        await Utils.successSnackBar(msg: res.data!, context: event.context);
          await FormFeasibilityHelper.clearCache();
          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomeView()),
                //  InstallationView()),
                  (Route<dynamic> route) => false);
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


  fetchCheckFeasibilityApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getCheckFeasibilityApi(context: context);
    if (res != null) {
      listOfCheckFeasible = res;
      checkFeasibleValue = listOfCheckFeasible.first;
      return res;
    }
  }

  fetchLMCReasonApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getLMCReasonApi(context: context);
    if (res != null) {
      listOfLMCReason = res;
      return res;
    }
  }

  _eventCompleted(emit) {
    emit(FormFeasibilityDataState(
        isLoader: isLoader,
        isBtnLoader: isBtnLoader,
        checkFeasibleValue: checkFeasibleValue,
        lmcReasonValue: lmcReasonValue,
        listOfCheckFeasible: listOfCheckFeasible,
        listOfLMCReason: listOfLMCReason,
        bpNumberController: bpNumberController,
        proposedDateController: proposedDateController,
        feasibilityDateController: feasibilityDateController,
        reasonController: reasonController,
        followUpDateController: followUpDateController,
    ));
  }

}
