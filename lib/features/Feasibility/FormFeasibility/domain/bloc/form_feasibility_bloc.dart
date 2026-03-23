import 'dart:async';
import 'dart:developer';
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

class FormFeasibilityBloc
    extends Bloc<FormFeasibilityEvent, FormFeasibilityState> {
  FormFeasibilityBloc() : super(FormFeasibilityInitialState()) {
    on<FormFeasibilityPageLoadEvent>(_pageLoad);
    on<SelectProposedDateEvent>(_selectProposedDate);
    on<SelectFeasibilityDateEvent>(_selectFeasibilityDate);
    on<SelectFollowUpDateEvent>(_selectFollowUpDate);
    on<SelectCheckFeasibilityValueEvent>(_selectCheckFeasibilityValue);
    on<SelectLMCReasonValueEvent>(_selectLMCReasonValue);
    on<SelectQTYLMCEvent>(_selectQTYLMC);
    on<SelectQTYLMCCopperEvent>(_selectQTYLMCCopper);
    on<SelectTFAvailableEvent>(_selectTFAvailable);
    on<SelectManualPipeEvent>(_selectManualPipe);
    on<SubmitFormFeasibilityEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  bool isSelected = false;
  bool isGiExtraPipe = false;
  bool isCopperExtraPipe = false;
  bool isTFAvail = false;
  bool isManualPipe = false;


  GetConstantModel checkFeasibleValue = GetConstantModel();
  GetConstantModel lmcReasonValue = GetConstantModel();

  List<GetConstantModel> listOfCheckFeasible = [];
  List<GetConstantModel> listOfLMCReason = [];

  List<FreeMaterialData> listOfAllMaterial = [];
  List<String> listOfAllMaterialId = [];
  List<MaterialItem> materialList = [];
  List<MaterialItem> listOfMaterial = [];
  List<String> listOfQtyLMC = [];

  List<FreeMaterialData> listOfAllMaterialCopper = [];
  List<String> listOfAllMaterialIdCopper = [];
  List<MaterialItem> materialListCopper = [];
  List<MaterialItem> listOfMaterialCopper = [];
  List<String> listOfQtyLMCCopper = [];
  String qtyDataCopper = "";

  TextEditingController bpNumberController = TextEditingController();
  TextEditingController trNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController assignedDateController = TextEditingController();
  TextEditingController followUpDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController manualPipLengthCtrl = TextEditingController();

  TextEditingController extraGiPipeCtrl = TextEditingController(text: "0");
  TextEditingController extraGiPriceCtrl = TextEditingController(text: "0");

  TextEditingController extraCopperPipeCtrl = TextEditingController(text: "0");
  TextEditingController extraCopperPriceCtrl = TextEditingController(text: "0");

  TextEditingController extraTotalPipeCtrl = TextEditingController(text: "0");
  TextEditingController extraTotalPriceCtrl = TextEditingController(text: "0");

  _pageLoad(FormFeasibilityPageLoadEvent event, emit) async {
    emit(FormFeasibilityPageLoadState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    isGiExtraPipe = false;
    isCopperExtraPipe = false;
    isTFAvail = false;
    isManualPipe = false;
    checkFeasibleValue = GetConstantModel();
    lmcReasonValue = GetConstantModel();
    listOfCheckFeasible = [];
    listOfLMCReason = [];
    listOfAllMaterial = [];
    listOfAllMaterialId = [];
    materialList = [];
    listOfMaterial = [];
    listOfQtyLMC = [];
    listOfAllMaterialCopper = [];
     listOfAllMaterialIdCopper = [];
    materialListCopper = [];
   listOfMaterialCopper = [];
    listOfQtyLMCCopper = [];
     qtyDataCopper = "";
    manualPipLengthCtrl.text = "";
    extraGiPipeCtrl = TextEditingController(text: "0");
    extraGiPriceCtrl = TextEditingController(text: "0");
    extraCopperPriceCtrl = TextEditingController(text: "0");
    extraCopperPipeCtrl = TextEditingController(text: "0");
     extraTotalPipeCtrl = TextEditingController(text: "0");
     extraTotalPriceCtrl = TextEditingController(text: "0");
    proposedDateController.text = '';
    reasonController.text = '';
    remarksController.text = '';
    followUpDateController.text = '';
    final results = await Future.wait(<Future>[
      SharedPref.getString(key: PrefsValue.bpNumber),
      SharedPref.getString(key: PrefsValue.crNumber),
      SharedPref.getString(key: PrefsValue.assignLmcDate),
    ]);

    bpNumberController.text = results[0] ?? "";
    trNumberController.text = results[1] ?? "";
    assignedDateController.text = results[2] ?? "";
    feasibilityDateController.text = DateFormat(
      AppString.dateFormat,
    ).format(DateTime.now());
    await Future.wait(<Future>[
      fetchCheckFeasibilityApi(context: event.context),
      fetchLMCReasonApi(context: event.context),
      fetchFreeMaterialApi(context: event.context),
      fetchFreeMaterialCopperApi(context: event.context),
    ]);
    _eventCompleted(emit);
  }

  _selectFeasibilityDate(SelectFeasibilityDateEvent event, emit) async {
    var assignDate = DateFormat(
      AppString.dateFormat,
    ).parse(assignedDateController.text);
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
    var feasibilityDate = DateFormat(
      AppString.dateFormat,
    ).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: feasibilityDate,
      lastDate: DateTime(2050),
    );
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      proposedDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectFollowUpDate(SelectFollowUpDateEvent event, emit) async {
    var assignDate = DateFormat(
      AppString.dateFormat,
    ).parse(assignedDateController.text);
    DateTime? dateTime = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: assignDate,
      lastDate: DateTime(2050),
    );
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      followUpDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectCheckFeasibilityValue(SelectCheckFeasibilityValueEvent event, emit) {
    checkFeasibleValue = event.checkFeasibility;
    print(" event.checkFeasibility;-->${event.checkFeasibility}");
    print(" checkFeasibleValue-->${checkFeasibleValue}");
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
      tempList = List.generate(
        listOfAllMaterial.length,
        (i) => listOfAllMaterial[i].id!,
      );
      listOfAllMaterialId.addAll(tempList);
      listOfMaterial = List.generate(
        listOfAllMaterial.length,
        (i) => MaterialItem(
          value: '0',
          id: '${listOfAllMaterial[i].id}',
          name: '${listOfAllMaterial[i].materialName}',
          unit: '${listOfAllMaterial[i].materialUnit}',
          controller: TextEditingController(),
        ),
      );
      materialList.addAll(listOfMaterial);
      listOfQtyLMC =
          listOfMaterial
              .map((e) => e.controller.text.isEmpty ? "0" : e.controller.text)
              .toList();
      print("listOfQtyLMC-->${listOfQtyLMC}");
      return res;
    }
  }

  fetchFreeMaterialCopperApi({required BuildContext context}) async {
    List<String> tempCopperList = [];
    var res = await FormFeasibilityHelper.getAllFreeMaterialCopperApi(
      context: context,
    );
    if (res != null) {
      listOfAllMaterialCopper = res;
      tempCopperList = List.generate(
        listOfAllMaterialCopper.length,
        (i) => listOfAllMaterialCopper[i].id!,
      );
      listOfAllMaterialIdCopper.addAll(tempCopperList);
      listOfMaterialCopper = List.generate(
        listOfAllMaterialCopper.length,
        (i) => MaterialItem(
          value: '0',
          id: '${listOfAllMaterialCopper[i].id}',
          name: '${listOfAllMaterialCopper[i].materialName}',
          unit: '${listOfAllMaterialCopper[i].materialUnit}',
          controller: TextEditingController(),
        ),
      );
      materialListCopper.addAll(listOfMaterialCopper);
      listOfQtyLMCCopper =
          listOfMaterialCopper
              .map((e) => e.controller.text.isEmpty ? "0" : e.controller.text)
              .toList();
      print("listOfQtyLMC-->${listOfQtyLMCCopper}");
      return res;
    }
  }

  double _getSum(List<MaterialItem> list) {
    return list.fold(0.0, (sum, item) {
      if (item.name.toLowerCase().contains("pipe")) {
        final value = item.controller.text.trim();
        return sum + (value.isEmpty ? 0.0 : double.parse(value));
      }
      return sum;
    });
  }

  Future<void> _calculateExtraPipe({
    required Emitter emit,
    required BuildContext context,
  }) async {
    double sumOfPipes = _getSum(listOfMaterial);
    double sumOfPipesCopper = _getSum(listOfMaterialCopper);

    double totalSum = sumOfPipes + sumOfPipesCopper;

    print("Total Sum ---> $totalSum");

    /// Declare OUTSIDE
    var giRes;
    var copperRes;

    if (totalSum > 15.0) {
      isGiExtraPipe = true;
      isCopperExtraPipe = true;
      _eventCompleted(emit);

      /// Reset BEFORE API
      extraGiPriceCtrl.text = "";
      extraGiPipeCtrl.text = "";
      extraCopperPriceCtrl.text = "";
      extraCopperPipeCtrl.text = "";

      /// Run APIs in parallel
      await Future.wait([
        if (sumOfPipes != 0.0)
          Future(() async {
            giRes = await FormInstallationHelper.getExtraPipeDetailsApi(
              context: context,
              pipeQty: sumOfPipes.toString(),
            );
          }),

        if (sumOfPipesCopper != 0.0)
          Future(() async {
            copperRes =
            await FormInstallationHelper.getExtraPipeDetailsCopperApi(
              context: context,
              pipeQty: sumOfPipesCopper.toString(),
              giqty: sumOfPipes.toString(),
            );
          }),
      ]);

      /// Apply Results
      if (giRes != null) {
        extraGiPriceCtrl.text = "${giRes.price} ${giRes.priceUm}";
        extraGiPipeCtrl.text = "${giRes.qty} ${giRes.pipeUm}";
      } else {
        extraGiPriceCtrl.text = '0';
        extraGiPipeCtrl.text = '0';
      }

      if (copperRes != null) {
        if(sumOfPipes < 15.0){
          extraCopperPriceCtrl.text = "${copperRes.price} ${copperRes.priceUm}";
          extraCopperPipeCtrl.text = "${copperRes.qty} ${copperRes.pipeUm}";
        }else{
          extraCopperPriceCtrl.text = "${copperRes.cuprice} ${copperRes.priceUm}";
          extraCopperPipeCtrl.text = "${copperRes.cupipe} ${copperRes.pipeUm}";
        }
      } else {
        extraCopperPriceCtrl.text = '0';
        extraCopperPipeCtrl.text = '0';
      }
      /// ✅ SET TOTAL ONLY ONCE (VERY IMPORTANT)
      if (copperRes != null) {
        extraTotalPriceCtrl.text = "${copperRes.price} ${copperRes.priceUm}";
        extraTotalPipeCtrl.text = "${copperRes.qty} ${copperRes.pipeUm}";
      } else if (giRes != null) {
        extraTotalPriceCtrl.text = "${giRes.price} ${giRes.priceUm}";
        extraTotalPipeCtrl.text = "${giRes.qty} ${giRes.pipeUm}";
      } else {
        extraTotalPriceCtrl.text = '0';
        extraTotalPipeCtrl.text = '0';
      }

      isGiExtraPipe = false;
      isCopperExtraPipe = false;
    } else {
      /// RESET BOTH
      isGiExtraPipe = false;
      isCopperExtraPipe = false;

      extraGiPriceCtrl.text = '0';
      extraGiPipeCtrl.text = '0';

      extraCopperPriceCtrl.text = '0';
      extraCopperPipeCtrl.text = '0';

      extraTotalPriceCtrl.text = '0';
      extraTotalPipeCtrl.text = '0';
    }
    _eventCompleted(emit);
  }

  _selectQTYLMC(SelectQTYLMCEvent event, emit) async {
    listOfQtyLMC = listOfMaterial
        .map((e) => e.controller.text.isEmpty ? "0" : e.controller.text)
        .toList();

    await _calculateExtraPipe(
      emit: emit,
      context: event.context,
    );
  }

  _selectQTYLMCCopper(SelectQTYLMCCopperEvent event, emit) async {
    listOfQtyLMCCopper = listOfMaterialCopper
        .map((e) => e.controller.text.isEmpty ? "0" : e.controller.text)
        .toList();

    await _calculateExtraPipe(
      emit: emit,
      context: event.context,
    );
  }

  fetchCheckFeasibilityApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getCheckFeasibilityApi(
      context: context,
    );
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

  _selectTFAvailable(SelectTFAvailableEvent event, emit) {
    isTFAvail = event.isValue;
    log("isTFAvail-- ${isTFAvail.toString()}");
    _eventCompleted(emit);
  }

  _selectManualPipe(SelectManualPipeEvent event, emit) {
    isManualPipe = event.isValue;
    log("isManualPipe-- ${isManualPipe.toString()}");
    _eventCompleted(emit);
  }

  _submit(SubmitFormFeasibilityEvent event, emit) async {
    try {
      var validationCheck = await FormFeasibilityHelper.validationSubmit(
        context: event.context,
        feasibilityDate: feasibilityDateController.text.trim().toString(),
        pipeLength: listOfQtyLMC,
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
          followUpDate: followUpDateController.text.trim().toString(),
          giExtraPipe: extraGiPipeCtrl.text.trim().toString(),
          giExtraPrice: extraGiPriceCtrl.text.trim().toString(),
          copperExtraPipe: extraCopperPipeCtrl.text.trim().toString(),
          copperExtraPrice: extraCopperPriceCtrl.text.trim().toString(),
          totalExtraPipe: extraTotalPipeCtrl.text.trim().toString(),
          totalExtraPrice: extraTotalPriceCtrl.text.trim().toString(),
          manualPipe: isManualPipe ? "1" : "0",
          manualPipeLength: manualPipLengthCtrl.text.trim().toString(),
          tfStatus: isTFAvail ? "1" : "0",
          materialId: listOfAllMaterialId
              .toList()
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
          qtyLMC: listOfQtyLMC
              .toList()
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', ''),
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
            (Route<dynamic> route) => false,
          );
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

  _eventCompleted(emit) {
    emit(
      FormFeasibilityDataState(
        isLoader: isLoader,
        isTFAvail: isTFAvail,
        isManualPipe: isManualPipe,
        isBtnLoader: isBtnLoader,
        isSelected: isSelected,
        isGiExtraPipe: isGiExtraPipe,
        checkFeasibleValue: checkFeasibleValue,
        lmcReasonValue: lmcReasonValue,
        listOfCheckFeasible: listOfCheckFeasible,
        listOfLMCReason: listOfLMCReason,
        materialList: materialList,
        bpNumberController: bpNumberController,
        trNumberController: trNumberController,
        proposedDateController: proposedDateController,
        feasibilityDateController: feasibilityDateController,
        assignedDateController: assignedDateController,
        reasonController: reasonController,
        followUpDateController: followUpDateController,
        remarksController: remarksController,
        manualPipLengthCtrl: manualPipLengthCtrl,
        extraGiPipeCtrl: extraGiPipeCtrl,
        extraGiPriceCtrl: extraGiPriceCtrl,
        isCopperExtraPipe: isCopperExtraPipe,
        extraCopperPipeCtrl: extraCopperPipeCtrl,
        extraCopperPriceCtrl: extraCopperPriceCtrl,
        extraTotalPriceCtrl: extraTotalPriceCtrl,
        extraTotalPipeCtrl: extraTotalPipeCtrl,
        materialListCopper: materialListCopper,
      ),
    );
  }
}
