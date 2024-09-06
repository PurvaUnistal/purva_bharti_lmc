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
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';

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
  bool isExtraPipe = false;

  String schema = "";
  String userName = "";
  String extraPipe = "0";
  String extraPrice = "0";

  GetConstantModel checkFeasibleValue = GetConstantModel();
  GetConstantModel lmcReasonValue = GetConstantModel();

  List<GetConstantModel> listOfCheckFeasible = [];
  List<GetConstantModel> listOfLMCReason = [];

  List<FreeMaterialData> listOfAllMaterial = [];
  List<String> listOfAllMaterialId = [];
  List<MaterialItem> materialList = [];
  List<MaterialItem> listOfMaterial = [];
  List<String> listOfQtyLMC = [];
  String  qtyData = "";
  List<GetConstantModel> listOfAllRFC = [];

  TextEditingController bpNumberController = TextEditingController();
  TextEditingController trNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController assignedDateController = TextEditingController();
  TextEditingController followUpDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController extraPipeController = TextEditingController(text: "0");
  TextEditingController extraPriceController = TextEditingController(text: "0");

  _pageLoad(FormFeasibilityPageLoadEvent event, emit) async {
    emit(FormFeasibilityInitialState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    isExtraPipe = false;
    checkFeasibleValue = GetConstantModel();
    lmcReasonValue = GetConstantModel();
    listOfCheckFeasible = [];
    listOfLMCReason = [];
    listOfAllMaterial = [];
    listOfAllMaterialId = [];
    materialList = [];
    listOfMaterial = [];
    listOfQtyLMC = [];
    listOfAllRFC = [];
     extraPipe = "0";
     extraPrice = "0";
    extraPipeController.text = "0";
    extraPriceController.text = "0";
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
    trNumberController.text = await SharedPref.getString(key: PrefsValue.crNumber);
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
    print(" event.checkFeasibility;-->${ event.checkFeasibility}");
    print(" checkFeasibleValue-->${ checkFeasibleValue}");
    _eventCompleted(emit);
  }

  _selectLMCReasonValue(SelectLMCReasonValueEvent event, emit) {
    lmcReasonValue = event.lmcReasonValue;
    print(lmcReasonValue);
    _eventCompleted(emit);
  }

  fetchFreeMaterialApi({required BuildContext context}) async {
    List<String> tempList = [];
    var res = await FormFeasibilityHelper.getAllFreePipeMaterial(
      context: context,
    );
    if (res != null) {
      listOfAllMaterial = res;
      tempList = List.generate(listOfAllMaterial.length, (i) => listOfAllMaterial[i].id!);
      listOfAllMaterialId.addAll(tempList);
      listOfMaterial = List.generate(
        listOfAllMaterial.length,
        (i) => MaterialItem(
            value: '0',
            id: '${listOfAllMaterial[i].id}',
            name: '${listOfAllMaterial[i].materialName}',
            unit: '${listOfAllMaterial[i].materialUnit}',
            controller: TextEditingController()),
      );
      materialList.addAll(listOfMaterial);
      listOfQtyLMC = listOfMaterial.map((e) => e.controller.text.isEmpty ? "0" : e.controller.text).toList();
      print("listOfQtyLMC-->${listOfQtyLMC}");
      return res;
    }
  }

  _selectQTYLMC(SelectQTYLMCEvent event, emit) async {
    double sumOfPipes = 0.0;
    for(int i = 0; i< listOfMaterial.length; i++){
      MaterialItem dataOfAllMaterial = listOfMaterial[i];
      if(dataOfAllMaterial.name.toLowerCase().contains("pipe")){
        if(dataOfAllMaterial.controller.text != ""){
          listOfQtyLMC = listOfMaterial.map((e) => e.controller.text.isEmpty ? "0" : e.controller.text).toList();
          sumOfPipes +=  double.parse(dataOfAllMaterial.controller.text);
        }else{
          dataOfAllMaterial.controller.text = '';
          listOfQtyLMC = listOfMaterial.map((e) => e.controller.text.isEmpty ? "0" : e.controller.text).toList();
        }
      }
    }
    print("sumOfPipes---> $sumOfPipes");
    if(sumOfPipes > 15.0){
      isExtraPipe = true;
      _eventCompleted(emit);
      var res = await FormInstallationHelper.getExtraPipeDetailsApi(context: event.context, pipeQty : sumOfPipes.toString());
      extraPriceController.text = "";
      extraPipeController.text = "";
      extraPipe = "";
      extraPrice = "";
      if(res != null){
        isExtraPipe = false;
        _eventCompleted(emit);
        extraPriceController.text = res.price.toString() + ' ' + res.priceUm.toString();
        extraPipeController.text = res.qty.toString() + ' ' + res.pipeUm.toString();
        extraPipe = res.price.toString();
        extraPrice = res.qty.toString();
        _eventCompleted(emit);
      }
    }else{
      isExtraPipe = false;
      _eventCompleted(emit);
      extraPriceController.text = '0';
      extraPipeController.text = '0';
    }
    _eventCompleted(emit);
  }

  _submit(SubmitFormFeasibilityEvent event, emit) async {
    try {
      var validationCheck = await FormFeasibilityHelper.validationSubmit(
        context: event.context,
        feasibilityDate: feasibilityDateController.text.trim().toString(),
        pipeLength: listOfQtyLMC.toString().trim().replaceAll(' ', ''),
        isFeasible: checkFeasibleValue,
        lmcReasonValue: lmcReasonValue,
        proposedDate: proposedDateController.text.trim().toString(),
        reason: reasonController.text.trim().toString(),
        followUpDate: followUpDateController.text.trim().toString(),
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormFeasibilityHelper.saveLmcFeasibility(
          context: event.context,
          feasibilityDate: feasibilityDateController.text..trim().toString(),
          proposedDate: proposedDateController.text.trim().toString(),
          isFeasible: checkFeasibleValue,
          comment: reasonController.text..trim().toString(),
          followUpDate: followUpDateController.text..trim().toString(),
          extraPipe: extraPipe,
          extraPrice: extraPrice,
          materialId: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          qtyLMC:listOfQtyLMC.toList().toString().replaceAll('[', '').replaceAll(']', ''),
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
      isExtraPipe: isExtraPipe,
      checkFeasibleValue: checkFeasibleValue,
      lmcReasonValue: lmcReasonValue,
      listOfCheckFeasible: listOfCheckFeasible,
      listOfLMCReason: listOfLMCReason,
      listOfAllRFC: listOfAllRFC,
      materialList: materialList,
      bpNumberController: bpNumberController,
      trNumberController: trNumberController,
      proposedDateController: proposedDateController,
      feasibilityDateController: feasibilityDateController,
      assignedDateController: assignedDateController,
      reasonController: reasonController,
      followUpDateController: followUpDateController,
      remarksController: remarksController,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
    ));
  }
}
