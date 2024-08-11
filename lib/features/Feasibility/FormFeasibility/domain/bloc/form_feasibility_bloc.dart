import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_event.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/bloc/form_feasibility_state.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/helper/form_feasibility_helper.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';

class FormFeasibilityBloc extends Bloc<FormFeasibilityEvent, FormFeasibilityState> {
  FormFeasibilityBloc() : super(FormFeasibilityInitialState()) {
    on<FormFeasibilityPageLoadEvent>(_pageLoad);
    on<SelectProposedDateEvent>(_selectProposedDate);
    on<SelectFeasibilityDateEvent>(_selectFeasibilityDate);
    on<SelectFollowUpDateEvent>(_selectFollowUpDate);
    on<SelectCheckFeasibilityValueEvent>(_selectCheckFeasibilityValue);
    on<SelectLMCReasonValueEvent>(_selectLMCReasonValue);
    on<SelectQTYLMCEvent>(_selectQTYLMC);
    on<SubmitFormFeasibilityEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  bool isSelected = false;

  String schema = "";
  String userName = "";

  GetConstantModel checkFeasibleValue = GetConstantModel();
  GetConstantModel lmcReasonValue = GetConstantModel();

  List<GetConstantModel> listOfCheckFeasible = [];
  List<GetConstantModel> listOfLMCReason = [];

  List<FreeMaterialData> listOfAllMaterial = [];
  List<String> listOfAllMaterialId = [];
  List<MaterialItem> materialList = [];
  List<String> listOfQtyLMC = [];

  List<GetConstantModel> listOfAllRFC = [];

  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController assignedDateController = TextEditingController();
  TextEditingController followUpDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  _pageLoad(FormFeasibilityPageLoadEvent event, emit) async {
    emit(FormFeasibilityInitialState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    checkFeasibleValue = GetConstantModel();
    lmcReasonValue = GetConstantModel();
    listOfCheckFeasible = [];
    listOfLMCReason = [];
    listOfAllMaterial = [];
    listOfAllMaterialId = [];
    materialList = [];
    listOfQtyLMC = [];
    listOfAllRFC = [];
    proposedDateController.text = '';
    reasonController.text = '';
    remarksController.text = '';
    followUpDateController.text = '';
    schema = await SharedPref.getString(
      key: PrefsValue.schema,
    );
    userName = await SharedPref.getString(
      key: PrefsValue.userName,
    );
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    assignedDateController.text = await SharedPref.getString(key: PrefsValue.assignLmcDate);
    feasibilityDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    proposedDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    await fetchCheckFeasibilityApi(context: event.context);
    await fetchLMCReasonApi(context: event.context);
    await fetchFreeMaterialApi(
      context: event.context,
    );
    _eventCompleted(emit);
  }

  _selectFeasibilityDate(SelectFeasibilityDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(assignedDateController.text);
    DateTime? dateTime = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: assignDate,
      lastDate: DateTime.now(),
    );
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      feasibilityDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectProposedDate(SelectProposedDateEvent event, emit) async {
    var feasibilityDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: feasibilityDate, lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      proposedDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectFollowUpDate(SelectFollowUpDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      followUpDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectCheckFeasibilityValue(SelectCheckFeasibilityValueEvent event, emit) {
    checkFeasibleValue = event.checkFeasibility;
    _eventCompleted(emit);
  }

  _selectLMCReasonValue(SelectLMCReasonValueEvent event, emit) {
    lmcReasonValue = event.lmcReasonValue;
    print(lmcReasonValue);
    _eventCompleted(emit);
  }

  fetchFreeMaterialApi({required BuildContext context}) async {
    List<String> tempList = [];
    List<MaterialItem> _materialList = [];
    var res = await FormFeasibilityHelper.getAllFreeMaterialApi(
      context: context,
    );
    if (res != null) {
      listOfAllMaterial = res;
      tempList = List.generate(listOfAllMaterial.length, (i) => ('${listOfAllMaterial[i].id}'));
      listOfAllMaterialId.addAll(tempList);
      _materialList = List.generate(
        listOfAllMaterial.length,
        (i) => MaterialItem(
            value: '0',
            id: '${listOfAllMaterial[i].id}',
            name: '${listOfAllMaterial[i].materialName}',
            unit: '${listOfAllMaterial[i].materialUnit}',
            controller: TextEditingController(text: "0")),
      );
      materialList.addAll(_materialList);
      listOfQtyLMC = _materialList.asMap().values.map((e) => e.controller.text).toList();
      return res;
    }
  }

  _selectQTYLMC(SelectQTYLMCEvent event, emit) {
    listOfQtyLMC[event.index] = event.qtyValue;
    _eventCompleted(emit);
  }

  _submit(SubmitFormFeasibilityEvent event, emit) async {
    try {
      var validationCheck = await FormFeasibilityHelper.validationSubmit(
        context: event.context,
        feasibilityDate: feasibilityDateController.text.trim().toString(),
        isFeasible: checkFeasibleValue,
        lmcReasonValue: lmcReasonValue,
        proposedDate: proposedDateController.text.trim().toString(),
        reason: reasonController.text.trim().toString(),
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormFeasibilityHelper.saveLmcFeasibility(
          context: event.context,
          feasibilityDate: feasibilityDateController.text..trim().toString(),
          isFeasible: checkFeasibleValue,
          comment: reasonController.text..trim().toString(),
          followUpDate: followUpDateController.text..trim().toString(),
          proposedDate: proposedDateController.text.trim().toString(),
          extraPipe: "",
          extraPrice: "",
          materialId: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          qtyLMC: "",
        );
        if (res != null && res.error == false) {
          isBtnLoader = false;
          _eventCompleted(emit);
          await Utils.successSnackBar(msg: res.data!, context: event.context);
          await FormFeasibilityHelper.clearCache();
          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(builder: (BuildContext context) => HomeView()),
              //  InstallationView()),
              (Route<dynamic> route) => false);
        } else {
          isBtnLoader = false;
          _eventCompleted(emit);
        }
      }
    } catch (e) {
      print("_submit-->${e.toString()}");
      isBtnLoader = false;
      _eventCompleted(emit);
    }
  }

  fetchCheckFeasibilityApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getCheckFeasibilityApi(context: context);
    if (res != null) {
      listOfCheckFeasible = res;
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
      userName: userName,
      schema: schema,
      isLoader: isLoader,
      isBtnLoader: isBtnLoader,
      isSelected: isSelected,
      checkFeasibleValue: checkFeasibleValue,
      lmcReasonValue: lmcReasonValue,
      listOfCheckFeasible: listOfCheckFeasible,
      listOfLMCReason: listOfLMCReason,
      listOfAllRFC: listOfAllRFC,
      materialList: materialList,
      bpNumberController: bpNumberController,
      proposedDateController: proposedDateController,
      feasibilityDateController: feasibilityDateController,
      assignedDateController: assignedDateController,
      reasonController: reasonController,
      followUpDateController: followUpDateController,
      remarksController: remarksController,
    ));
  }
}
