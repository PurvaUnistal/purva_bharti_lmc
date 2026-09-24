import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart' show Client;
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/helper/form_feasibility_helper.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_event.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_state.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class FormInstallationBloc extends Bloc<FormInstallationEvent, FormInstallationState> {
  FormInstallationBloc() : super(FormInstallationInitialState()) {
    on<FormInstallationPageLoadEvent>(_pageLoad);
    on<SelectInstallationDateEvent>(_selectInstallationDate);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectInstallRegulatorEvent>(_selectInstallRegulator);
    on<SelectRegulatorTypeValueEvent>(_selectRegulatorTypeValue);
    on<SelectNGCValueEvent>(_selectNGCValue);
    on<SelectTypeNRValueEvent>(_selectTypeNRValue);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<SelectRegulatorsValueEvent>(_selectRegulatorsValue);
    on<SelectMREvent>(_selectMR);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<MeterInitReadingEvent>(_meterInitReading);
    on<SelectNGConversionDateEvent>(_selectNGConversionDate);
    on<SelectRFCDateEvent>(_selectRFCDate);
    on<SelectLocationOfHouseEvent>(_selectLocationOfHouse);
    on<CaptureGalleryRFCCardEvent>(_captureGalleryRFCCard);
    on<CaptureCameraRFCCardEvent>(_captureCameraRFCCard);
    on<CaptureGalleryPneumaticEvent>(_captureGalleryPneumatic);
    on<CaptureCameraPneumaticEvent>(_captureCameraPneumatic);
    on<CaptureGalleryHouseEvent>(_captureGalleryHouse);
    on<CaptureCameraHouseEvent>(_captureCameraHouse);
    on<CaptureGalleryInstallationEvent>(_captureGalleryInstallation);
    on<CaptureCameraInstallationEvent>(_captureCameraInstallation);
    on<SelectRFCCheckValueEvent>(_selectRFCCheckValue);
    on<ToggleOptionEvent>(_selectToggleOption);
    on<SelectGasifiedRadioEvent>(_selectGasifiedRadio);
    on<SelectQTYLMCEvent>(_selectQTYLMC);
    on<SelectQTYLMCCopperEvent>(_selectQTYLMCCopper);
    on<SelectManualPipeEvent>(_selectManualPipe);
    on<SubmitFormInstallationEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  bool isInstallRegulator = false;
  bool isRegulator = false;
  bool isSelected = false;
  bool isDelayReason = false;
  bool isCheckMeterMismatch = false;
  bool isCheckRegulatorMismatch = false;
  bool isCheckMR = false;
  bool isGiExtraPipe = false;
  bool isCopperExtraPipe = false;
  bool isManualPipe = false;


  String currentDate = "";
  String installRegulator = "0";

  String meterTesting = "0";
  String paintingOfGIPipe = "0";

  String tapOffValue = "";
  String supplyOfPaintValue = "";
  String gasifiedValue = "";


  String extraGiPipe = "0.0";
  String extraGiPrice = "0.0";
  String extraCopperPipe = "0.0";
  String extraCopperPrice = "0.0";
  String extraTotalPipe = "0.0";
  String extraTotalPrice = "0.0";

  ListOfMeterNo meterNoValue = ListOfMeterNo();
  GetConstantModel typeOfNrValue = GetConstantModel();
  GetConstantModel readyNGCValue = GetConstantModel();
  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNumber = [];
  List<String> listOfMeterNumberSerial = [];
  List<String> listOfMeterNumberId = [];
  List<ListOfMeterNo> listOfRegulator = [];
  List<ListOfMeterNo> listOfMR = [];
  List<String> listOfRegulatorSerial = [];
  List<String> listOfMRSerial = [];
  List<String> listOfRegulatorId = [];
  List<GetConstantModel> listOfTypeOfNr = [];
  List<GetConstantModel> listOfReadyNGC = [];
  List<LmcReasonModel> listOfDelayReason = [];
  List<LmcReasonModel> listOfRegulatorType = [];

  List<FreeMaterialData> listOfAllMaterial = [];
  List<MaterialItem> materialList = [];
  List<String> listOfAllMaterialId = [];
  List<String> listOfQtyLMC = [];

  List<FreeMaterialData> listOfAllMaterialCopper = [];
  List<MaterialItem> materialListCopper = [];
  List<String> listOfAllMaterialIdCopper = [];
  List<String> listOfQtyLMCCopper = [];

  List<GetConstantModel> listOfAllRFC = [];
  List<String> coatTapList = [];
  List<String> selectedCoatTap = [];

  String selectedGasified = '';
  List<String> gasifiedList = [];

  TextEditingController meterConnectionMeterController = TextEditingController();
  TextEditingController meterNumberSerialController = TextEditingController();
  TextEditingController trNumberController = TextEditingController();
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController installationDateController = TextEditingController();
  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController meterIniReading1Controller = TextEditingController();
  TextEditingController meterIniReading2Controller = TextEditingController();
  TextEditingController meterIniReading3Controller = TextEditingController();
  TextEditingController meterInitialReadingController = TextEditingController();
  TextEditingController latOfHouseController = TextEditingController();
  TextEditingController longOfHouseController = TextEditingController();
  TextEditingController ngConversionDateController = TextEditingController();
  TextEditingController rfcDateController = TextEditingController();
  TextEditingController regulatorSerialController = TextEditingController();
  TextEditingController mrNumberController = TextEditingController();
  TextEditingController meterReadingDate = TextEditingController();
  TextEditingController tapOffLengthController = TextEditingController();
  TextEditingController manualPipLengthCtrl = TextEditingController();

  TextEditingController extraGiPipeCtrl = TextEditingController(text: "0");
  TextEditingController extraGiPriceCtrl = TextEditingController(text: "0");

  TextEditingController extraCopperPipeCtrl = TextEditingController(text: "0");
  TextEditingController extraCopperPriceCtrl = TextEditingController(text: "0");

  TextEditingController extraTotalPipeCtrl = TextEditingController(text: "0");
  TextEditingController extraTotalPriceCtrl = TextEditingController(text: "0");

  FocusNode meterIniReading1FocusNode = FocusNode();
  FocusNode meterIniReading2FocusNode = FocusNode();
  FocusNode meterIniReading3FocusNode = FocusNode();


  String regulatorsId = '';
  String mrRegulatorsId = '';
  String meterNoId = '';

  File housePhoto = File("");
  File rfcCardPhoto = File("");
  File meterPhoto = File("");
  File pneumaticTestReportPhoto = File("");
  File installationPhoto = File("");

  _pageLoad(FormInstallationPageLoadEvent event, emit) async {
    emit(FormInstallationPageLoadState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    isInstallRegulator = false;
    isRegulator = false;
    isDelayReason = false;
    isCheckMeterMismatch = false;
    isCheckRegulatorMismatch = false;
    isCheckMR = false;
    isGiExtraPipe = false;
    isCopperExtraPipe = false;
    isManualPipe = false;
    housePhoto = File("");
    rfcCardPhoto = File("");
    pneumaticTestReportPhoto = File("");
    installationPhoto = File("");
    meterPhoto = File("");
    meterNoValue = ListOfMeterNo();
    typeOfNrValue = GetConstantModel();
    delayReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    listOfMeterNumber = [];
    listOfMeterNumberSerial = [];
    listOfMeterNumberId = [];
    listOfRegulator = [];
    listOfMR = [];
    listOfRegulatorSerial = [];
    listOfMRSerial = [];
    listOfRegulatorId = [];

    listOfTypeOfNr = [];
    listOfReadyNGC = [];
    listOfDelayReason = [];
    listOfRegulatorType = [];

    listOfAllMaterial = [];
    materialList = [];
    listOfAllMaterialId = [];
    listOfQtyLMC = [];

    listOfAllMaterialCopper = [];
    materialListCopper = [];
    listOfAllMaterialIdCopper = [];
    listOfQtyLMCCopper = [];


    listOfAllRFC = [];
    meterNoId = "";
    extraGiPipe = "0.0";
    extraGiPrice = "0.0";
    extraCopperPipe = "0.0";
    extraCopperPrice = "0.0";
    extraTotalPipe = "0.0";
    extraTotalPrice = "0.0";
    meterTesting = "0";
    paintingOfGIPipe = "0";
    manualPipLengthCtrl.text = "";
    extraGiPipeCtrl = TextEditingController(text: "0");
    extraGiPriceCtrl = TextEditingController(text: "0");
    extraCopperPriceCtrl = TextEditingController(text: "0");
    extraCopperPipeCtrl = TextEditingController(text: "0");
    extraTotalPipeCtrl = TextEditingController(text: "0");
    extraTotalPriceCtrl = TextEditingController(text: "0");
    meterConnectionMeterController.text = "";
    mrNumberController.text = "";
    meterNumberSerialController.text = "";
    regulatorSerialController.text = "";
    bpNumberController.text = "";
    feasibilityDateController.text = "";
    latOfHouseController.text = "";
    longOfHouseController.text = "";
    installationDateController.text = "";
    meterIniReading1Controller.text = "";
    meterIniReading2Controller.text = "";
    meterIniReading3Controller.text = "";
    meterInitialReadingController.text = "";
    ngConversionDateController.text = "";
    rfcDateController.text = "";
    tapOffLengthController.text = "";
    meterIniReading1FocusNode = FocusNode();
    meterIniReading2FocusNode = FocusNode();
    meterIniReading3FocusNode = FocusNode();
    currentDate = await DateFormat(AppString.dateFormat).format(DateTime.now());

    meterReadingDate.text = currentDate;
    installationDateController.text = currentDate;

    trNumberController.text = await SharedPref.getString(key: PrefsValue.crNumber);
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    proposedDateController.text = await SharedPref.getString(key: PrefsValue.proposedDate);
    feasibilityDateController.text = await SharedPref.getString(key: PrefsValue.feasibilityVisitDate);
    coatTapList = ['Supply of Paint/Coat', 'Tap Off', ];
     selectedGasified = '';
     gasifiedList = ['Yes', 'No',];
    Future.wait(<Future>[
     fetchTypeOfNrApi(context: event.context),
     fetchReadyForNgcApi(context: event.context),
     fetchDelayReasonApi(context: event.context),
     fetchRegulatorTypeApi(context: event.context),
     fetchRFCApi(
      context: event.context,
    ),

    ]);
    await fetchMetersApi(context: event.context, meterSerial: "");
    await fetchFreeMaterialApi(context: event.context);
    if (AppConfig.instanceInit()!.client == Client.hpoil) {
      await fetchFreeMaterialCopperApi(context: event.context);
    }
    await fetchFreeMaterialCopperApi(context: event.context);
   await checkDelayReason();
    _eventCompleted(emit);
  }

  _selectInstallationDate(SelectInstallationDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: assignDate,
      lastDate: DateTime.now(),
    );
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      installationDateController.text = await formattedDate.toString();
      checkDelayReason();
      _eventCompleted(emit);
    }
  }

  checkDelayReason() {
    DateTime proposedDate = DateFormat(AppString.dateFormat).parse(proposedDateController.text);
    DateTime installationDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
    if (installationDate.compareTo(proposedDate) <= 0) {
      isDelayReason = false;
    } else {
      isDelayReason = true;
    }
  }

  _selectNGConversionDate(SelectNGConversionDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: assignDate, lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      ngConversionDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectRFCDate(SelectRFCDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: assignDate, lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      rfcDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectDelayReasonValue(SelectDelayReasonValueEvent event, emit) {
    delayReasonValue = event.delayReasonValue;
    _eventCompleted(emit);
  }

  _selectNGCValue(SelectNGCValueEvent event, emit) {
    readyNGCValue = event.readyNGCValue;
    _eventCompleted(emit);
  }

  _selectInstallRegulator(SelectInstallRegulatorEvent event, emit) async {
    isInstallRegulator = event.installRegulator;
    if (isInstallRegulator == true) {
      installRegulator = "1";
    } else {
      installRegulator = "0";
      regulatorTypeValue = LmcReasonModel();
      ngConversionDateController.text = "";
      rfcDateController.text = "";
      regulatorSerialController.text = "";
      mrNumberController.text = "";
      regulatorsId = '';
      mrRegulatorsId = '';
      rfcCardPhoto = File("");
      pneumaticTestReportPhoto = File("");
    }
    _eventCompleted(emit);
  }

  _selectRegulatorTypeValue(SelectRegulatorTypeValueEvent event, emit) async {
    isRegulator = true;
    _eventCompleted(emit);
    regulatorTypeValue = event.regulatorTypeValue;
    regulatorSerialController.clear();
    mrNumberController.clear();
    if (event.regulatorTypeValue.name == "SR") {
      await fetchMRApi(
        context: event.context,
        regulatorSerial: "",
        regulatorType: event.regulatorTypeValue.id.toString(),
      );
      await fetchRegulatorsApi(
        context: event.context,
        regulatorSerial: "",
        regulatorType: event.regulatorTypeValue.id.toString(),
      );
    } else if (event.regulatorTypeValue.name != null) {
      await fetchRegulatorsApi(
        context: event.context,
        regulatorSerial: "",
        regulatorType: event.regulatorTypeValue.id.toString(),
      );
    }
    isRegulator = false;
    _eventCompleted(emit);
  }

  _selectTypeNRValue(SelectTypeNRValueEvent event, emit) {
    typeOfNrValue = event.typeOfNRValue;
    _eventCompleted(emit);
  }

  fetchTypeOfNrApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.getTypeOfNrApi(context: context);
    if (res != null) {
      listOfTypeOfNr = res;
      typeOfNrValue = listOfTypeOfNr.first;
      return res;
    }
  }

  fetchReadyForNgcApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.getReadyForNgcApi(context: context);
    if (res != null) {
      listOfReadyNGC = res;
      return res;
    }
  }

  fetchDelayReasonApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.lmcReasonApi(context: context);
    if (res != null) {
      listOfDelayReason = res;
      return res;
    }
  }

  fetchRegulatorTypeApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.regulatorTypeApi(context: context);
    if (res != null) {
      listOfRegulatorType = res;
      return res;
    }
  }

  fetchFreeMaterialApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getAllFreeMaterialApi(
      context: context,
    );
    if (res != null) {
      listOfAllMaterial = res;
      materialList.addAll(listOfAllMaterial.map((data) {
        return MaterialItem(
          value: '0',
          id: data.id ?? "",
          name: data.materialName ?? "",
          unit: data.materialUnit ?? "",
          controller: TextEditingController(),
        );
      }));
      print("materialList--->${materialList}");
      listOfAllMaterialId = listOfAllMaterial.map((e) => e.id.toString(),).toList();
      listOfQtyLMC = materialList.map((e) => e.controller.text.isEmpty ? "0" : e.controller.text).toList();
      return res;
    }
  }

  fetchFreeMaterialCopperApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getAllFreeMaterialCopperApi(context: context,);
    if (res != null) {
      listOfAllMaterialCopper = res;
      materialListCopper.addAll(listOfAllMaterialCopper.map((data) {
        return MaterialItem(
          value: '0',
          id: data.id ?? "",
          name: data.materialName ?? "",
          unit: data.materialUnit ?? "",
          controller: TextEditingController(),
        );
      }));
      print("materialListCopper--->${materialListCopper}");
      listOfAllMaterialIdCopper = listOfAllMaterialCopper.map((e) => e.id.toString(),).toList();
      listOfQtyLMCCopper = materialListCopper.map((e) => e.controller.text.isEmpty ? "0" : e.controller.text).toList();
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
    double sumOfPipes = _getSum(materialList);
    double sumOfPipesCopper = _getSum(materialListCopper);

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
      extraGiPipe = "0.0";
      extraGiPrice = "0.0";

      extraCopperPipe = "0.0";
      extraCopperPrice = "0.0";

      extraTotalPipe = "0.0";
      extraTotalPrice = "0.0";

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
        extraGiPipeCtrl.text = "${giRes.qty} ${giRes.pipeUm}";
        extraGiPriceCtrl.text = "${giRes.price} ${giRes.priceUm}";
        extraGiPipe = giRes.qty.toString();
        extraGiPrice = giRes.price.toString();
      } else {
        extraGiPipeCtrl.text = '0';
        extraGiPriceCtrl.text = '0';
        extraGiPipe  = '0';
        extraGiPrice  = '0';
      }

      if (copperRes != null) {
        if (sumOfPipes < 15.0) {
          extraCopperPipeCtrl.text = "${copperRes.qty} ${copperRes.pipeUm}";
          extraCopperPriceCtrl.text = "${copperRes.price} ${copperRes.priceUm}";
          extraCopperPipe = copperRes.qty.toString();
          extraCopperPrice = copperRes.price.toString();
        } else {
          extraCopperPipeCtrl.text = "${copperRes.cupipe} ${copperRes.pipeUm}";
          extraCopperPriceCtrl.text = "${copperRes.cuprice} ${copperRes.priceUm}";
          extraCopperPipe = copperRes.cupipe.toString();
          extraCopperPrice = copperRes.cuprice.toString();
        }
      } else {
        extraCopperPipeCtrl.text = '0';
        extraCopperPriceCtrl.text = '0';
        extraCopperPipe = '0';
        extraCopperPrice = '0';
      }

      /// ✅ SET TOTAL ONLY ONCE (VERY IMPORTANT)
      if (copperRes != null) {
        extraTotalPipeCtrl.text = "${copperRes.qty} ${copperRes.pipeUm}";
        extraTotalPriceCtrl.text = "${copperRes.price} ${copperRes.priceUm}";
        extraTotalPipe = copperRes.qty.toString();
        extraTotalPrice = copperRes.price.toString();
      } else if (giRes != null) {
        extraTotalPipeCtrl.text = "${giRes.qty} ${giRes.pipeUm}";
        extraTotalPriceCtrl.text = "${giRes.price} ${giRes.priceUm}";
        extraTotalPipe = giRes.qty.toString();
        extraTotalPrice = giRes.price.toString();
      } else {
        extraTotalPriceCtrl.text = '0';
        extraTotalPipeCtrl.text = '0';
        extraTotalPipe  = '0';
        extraTotalPrice  = '0';
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

      extraGiPipe = "0.0";
      extraGiPrice = "0.0";

      extraCopperPipe = "0.0";
      extraCopperPrice = "0.0";

      extraTotalPipe = "0.0";
      extraTotalPrice = "0.0";
    }
    _eventCompleted(emit);
  }


  _selectQTYLMC(SelectQTYLMCEvent event, emit) async {
    listOfQtyLMC = materialList
        .map((e) => e.controller.text.isEmpty ? "0" : e.controller.text)
        .toList();

    await _calculateExtraPipe(
      emit: emit,
      context: event.context,
    );
  }

  _selectQTYLMCCopper(SelectQTYLMCCopperEvent event, emit) async {
    listOfQtyLMCCopper = materialListCopper
        .map((e) => e.controller.text.isEmpty ? "0" : e.controller.text)
        .toList();

    await _calculateExtraPipe(
      emit: emit,
      context: event.context,
    );
  }

  _meterInitReading(MeterInitReadingEvent event, emit) {
    var meterIniReading1 = meterIniReading1Controller.text;
    var meterIniReading2 = meterIniReading2Controller.text;
    var meterIniReading3 = meterIniReading3Controller.text;
    double meterIniReadingAdd = double.parse(meterIniReading1 + meterIniReading2 + meterIniReading3);
    meterInitialReadingController.text = (meterIniReadingAdd / 1000).toString();
    log("meterInitialReadingController-->${meterInitialReadingController.text}");
    _eventCompleted(emit);
  }

  fetchMetersApi({required BuildContext context, required String meterSerial}) async {
    var res = await FormInstallationHelper.getMetersApi(context: context, meterSerial: meterSerial);
    if (res != null) {
      listOfMeterNumber = res;
      listOfMeterNumberSerial = listOfMeterNumber.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    var res = await FormInstallationHelper.getRegulatorsApi(context: context, regulatorSerial: regulatorSerial, regulatorType: regulatorType);
    if (res != null) {
      listOfRegulator = res;
      listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  fetchMRApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    var res = await FormInstallationHelper.getMeterRegulatorsApi(context: context, regulatorSerial: regulatorSerial, regulatorType: regulatorType);
    if (res != null) {
      listOfMR = res;
      listOfMRSerial = listOfMR.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    meterNoId = "";
    meterConnectionMeterController.text = "";
    meterNumberSerialController.text = event.meterReadingValue;
    meterNoId = listOfMeterNumber.firstWhereOrNull((element) => element.serialNumber == event.meterReadingValue)?.id ?? "";
    meterConnectionMeterController.text = listOfMeterNumber.firstWhereOrNull((element) => element.serialNumber == event.meterReadingValue)?.meterConnection ?? "";

    if (event.meterReadingValue.isNotEmpty && !listOfMeterNumberSerial.contains(event.meterReadingValue)) {
      isCheckMeterMismatch = true;
    } else {
      isCheckMeterMismatch = false;
    }
    _eventCompleted(emit);
  }

  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    regulatorSerialController.text = event.regulatorsValue;
    regulatorsId = listOfRegulator.firstWhereOrNull((element) => element.serialNumber == event.regulatorsValue)?.id ?? "";
    if (event.regulatorsValue.isNotEmpty && !listOfRegulatorSerial.contains(event.regulatorsValue)) {
      isCheckRegulatorMismatch = true;
    } else {
      isCheckRegulatorMismatch = false;
    }
    _eventCompleted(emit);
  }

  _selectMR(SelectMREvent event, emit) async {
    mrNumberController.text = event.mRegulators;
    mrRegulatorsId = listOfMR.firstWhereOrNull((element) => element.serialNumber == event.mRegulators)?.id ?? "";
    if (event.mRegulators.isNotEmpty && !listOfMRSerial.contains(event.mRegulators)) {
      isCheckMR = true;
    } else {
      isCheckMR = false;
    }
    _eventCompleted(emit);
  }

  _setHouseLocation({required BuildContext context}) async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    if (await Permission.location.isGranted) {
      var getLocation = await FormInstallationHelper.getCurrentLocation();
      latOfHouseController =
          TextEditingController(text: getLocation?.latitude.toString());
      longOfHouseController =
          TextEditingController(text: getLocation?.longitude.toString());
      return getLocation;
    } else {
      Utils.errorSnackBar(
          msg:  "Location permission denied", context: context);
    }
  }

  _selectLocationOfHouse(SelectLocationOfHouseEvent event, emit) {
    _setHouseLocation(context: event.context);
    _eventCompleted(emit);
  }

  _captureGalleryMeter(CaptureGalleryMeterEvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      meterPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraMeter(CaptureCameraMeterEvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      meterPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryRFCCard(CaptureGalleryRFCCardEvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraRFCCard(CaptureCameraRFCCardEvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryPneumatic(CaptureGalleryPneumaticEvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraPneumatic(CaptureCameraPneumaticEvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryInstallation(CaptureGalleryInstallationEvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraInstallation(CaptureCameraInstallationEvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryHouse(CaptureGalleryHouseEvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      await _setHouseLocation(context: event.context);
      housePhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraHouse(CaptureCameraHouseEvent event, Emitter<FormInstallationState> emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      await _setHouseLocation(context: event.context);
      housePhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  fetchRFCApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getRFCApi(
      context: context,
    );
    if (res != null) {
      listOfAllRFC = res;
      return res;
    }
  }

  _selectRFCCheckValue(SelectRFCCheckValueEvent event, emit) {
    emit(FormInstallationInitialState());
    isSelected = event.isSelected;
    listOfAllRFC[event.index].isSelected = isSelected;
    if (listOfAllRFC[event.index].value == "Meter testing" && listOfAllRFC[event.index].isSelected == true) {
      meterTesting = "1";
    } else if (listOfAllRFC[event.index].value == "Painting of GI pipe" && listOfAllRFC[event.index].isSelected == true) {
      paintingOfGIPipe = "1";
    } else if (listOfAllRFC[event.index].value == "Meter testing" && listOfAllRFC[event.index].isSelected == false) {
      meterTesting = "0";
    } else if (listOfAllRFC[event.index].value == "Painting of GI pipe" && listOfAllRFC[event.index].isSelected == false) {
      paintingOfGIPipe = "0";
    }
    log("${listOfAllRFC[event.index]}-->${listOfAllRFC[event.index].isSelected}");
    _eventCompleted(emit);
  }

  _selectToggleOption(ToggleOptionEvent event, emit) {
    tapOffValue = "";
    supplyOfPaintValue = "";
    final currentState = state;
    if (currentState is! FormInstallationDataState) return;

    selectedCoatTap = List<String>.from(currentState.selectedCoatTap);

    if (event.isSelected) {
      selectedCoatTap.remove(event.option);
    } else {
      selectedCoatTap.add(event.option);
    }
     tapOffValue = selectedCoatTap.contains("Tap Off") ? "1" : "0";
     supplyOfPaintValue = selectedCoatTap.contains("Supply of Paint/Coat") ? "1" : "0";

    print("Tap Off Value --> $tapOffValue");
    print("Supply of Paint/Coat Value --> $supplyOfPaintValue");

    _eventCompleted(emit);
  }


  _selectGasifiedRadio(SelectGasifiedRadioEvent event,emit) {
    selectedGasified = event.option;

    print("--selectedGasified--> $selectedGasified");
     gasifiedValue = (selectedGasified == "Yes") ? "1" : "0";
    print("gasifiedValue --> $gasifiedValue");
    _eventCompleted(emit);
  }

  _selectManualPipe(SelectManualPipeEvent event, emit) {
    isManualPipe = event.isValue;
    log("isManualPipe-- ${isManualPipe.toString()}");
    _eventCompleted(emit);
  }

  _submit(SubmitFormInstallationEvent event, emit) async {
    try {
      var validationCheck = await FormInstallationHelper.validationSubmit(
        context: event.context,
        dateInstallation: installationDateController.text.trim().toString(),
        isDelayReason: isDelayReason,
        delayReason: delayReasonValue,
        meterNumber: meterNumberSerialController.text.trim().toString(),
        isCheckMeterMismatch: isCheckMeterMismatch,
        meterInit1: meterIniReading1Controller.text.trim().toString(),
        meterInit2: meterIniReading2Controller.text.trim().toString(),
        meterInit3: meterIniReading3Controller.text.trim().toString(),
        regulatorType: regulatorTypeValue,
        isInstallRegulator: isInstallRegulator,
        regulatorNumber:regulatorSerialController.text.trim().toString(),
        isCheckMR: isCheckMR,
        mrNumber: mrNumberController.text.trim().toString(),
        isCheckRegulatorMismatch: isCheckRegulatorMismatch,
        rfcDateController: rfcDateController.text.trim().toString(),
        ngConversionDate: ngConversionDateController.text.trim().toString(),
        fittingDetails: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
        pipeLength: materialList,
        meterPhoto: meterPhoto.path.toString(),
        rfcPhoto: rfcCardPhoto.path.toString(),
        pneumaticPhoto: pneumaticTestReportPhoto.path.toString(),
        houseLat: latOfHouseController.text.trim().toString(),
        houseLong: longOfHouseController.text.trim().toString(),
        housePhoto: housePhoto.path.toString(),
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormInstallationHelper.saveLMCInstallation(
          context: event.context,
          giExtraPipe: extraGiPipe.trim().toString(),
          giExtraPrice: extraGiPrice.trim().toString(),
          copperExtraPipe: extraCopperPipe.trim().toString(),
          copperExtraPrice: extraCopperPrice.trim().toString(),
          totalExtraPipe: extraTotalPipe.trim().toString(),
          totalExtraPrice: extraTotalPrice.trim().toString(),
          workCompletedDate: installationDateController.text.trim().toString(),
          rfcDate: rfcDateController.text.trim().toString(),
          meterReadingDate: meterReadingDate.text.trim().toString(),
          meterNo: meterNoId.trim().toString(),
          latitudeHg: latOfHouseController.text.trim().toString(),
          longitudeHg: longOfHouseController.text.trim().toString(),
          tfNumber: bpNumberController.text.toString(),
          regulatorCheck: installRegulator,
          materialIdLmc: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          proposedNgcDate: ngConversionDateController.text.trim().toString(),
          qtyLmc: listOfQtyLMC.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          mRegulatorsId: mrRegulatorsId.toString(),
          regulatorsId: regulatorsId.toString(),
          regulatorTypeId: regulatorTypeValue.id == null ? "" : regulatorTypeValue.id.toString(),
          delayReason: delayReasonValue,
          meterReading: meterInitialReadingController.text.trim().toString(),
          materialId:meterNoId.trim().toString(),
          typeOfNR: meterConnectionMeterController.text.trim().toString(),
          meterTesting: meterTesting.trim().toString(),
          paintingOfGIPipe: paintingOfGIPipe.trim().toString(),
          ngc: readyNGCValue,
          meterPhoto: meterPhoto.path,
          housePhoto: housePhoto.path,
          pneumaticPhoto: pneumaticTestReportPhoto.path.toString(),
          isometricPhoto: rfcCardPhoto.path.toString(),
          gaisified: gasifiedValue.toString(),
          supplyPaint: supplyOfPaintValue.toString(),
          tapOff: tapOffValue,
          tapOffLength: tapOffLengthController.text.toString(),
        );
        if (res != null && res.error == false) {
          isBtnLoader = false;
          _eventCompleted(emit);
          await Utils.successSnackBar(msg: res.data!, context: event.context);
          await FormFeasibilityHelper.clearCache();
          return  Navigator.pushReplacementNamed(
            event.context,
            RoutesName.home,
          );
        } else if (res != null && res.error == true) {
          await Utils.errorSnackBar(msg: res.data!, context: event.context);
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
    emit(FormInstallationDataState(
      tapOffValue: tapOffValue,
      isLoader: isLoader,
      isManualPipe: isManualPipe,
      isInstallRegulator: isInstallRegulator,
      isCheckRegulatorMismatch: isCheckRegulatorMismatch,
      isCheckMeterMismatch: isCheckMeterMismatch,
      isBtnLoader: isBtnLoader,
      isDelayReason: isDelayReason,
      isRegulator: isRegulator,
      meterPhoto: meterPhoto,
      housePhoto: housePhoto,
      meterNoValue: meterNoValue,
      typeOfNrValue: typeOfNrValue,
      listOfRegulatorType: listOfRegulatorType,
      regulatorTypeValue: regulatorTypeValue,
      delayReasonValue: delayReasonValue,
      listOfMeterNumber: listOfMeterNumber,
      listOfTypeOfNr: listOfTypeOfNr,
      listOfMeterNumberSerial: listOfMeterNumberSerial,
      listOfDelayReason: listOfDelayReason,
      meterConnectionMeterController: meterConnectionMeterController,
      bpNumberController: bpNumberController,
      trNumberController: trNumberController,
      proposedDateController: proposedDateController,
      rfcDateController: rfcDateController,
      feasibilityDateController: feasibilityDateController,
      installationDateController: installationDateController,
      meterIniReading1Controller: meterIniReading1Controller,
      meterIniReading2Controller: meterIniReading2Controller,
      meterIniReading3Controller: meterIniReading3Controller,
      meterInitialReadingController: meterInitialReadingController,
      meterIniReading1FocusNode: meterIniReading1FocusNode,
      meterIniReading2FocusNode: meterIniReading2FocusNode,
      meterIniReading3FocusNode: meterIniReading3FocusNode,
      listOfQtyLMC: listOfQtyLMC,
      isSelected: isSelected,
      rfcCardPhoto: rfcCardPhoto,
      pneumaticTestReportPhoto: pneumaticTestReportPhoto,
      installationPhoto: installationPhoto,
      listOfRegulatorSerial: listOfRegulatorSerial,
      listOfAllMaterial: listOfAllMaterial,
      listOfAllRFC: listOfAllRFC,
      materialList: materialList,
      latOfHouseController: latOfHouseController,
      longOfHouseController: longOfHouseController,
      ngConversionDateController: ngConversionDateController,
      mrNumberController: mrNumberController,
      manualPipLengthCtrl: manualPipLengthCtrl,
      regulatorSerialController: regulatorSerialController,
      meterNumberSerialController: meterNumberSerialController,
      tapOffLengthController: tapOffLengthController,
      listOfMRSerial: listOfMRSerial,
      coatTapList: coatTapList,
      selectedCoatTap:selectedCoatTap,
      selectedGasified: selectedGasified,
      gasifiedList: gasifiedList,
      isGiExtraPipe: isGiExtraPipe,
      isCopperExtraPipe: isCopperExtraPipe,
      extraGiPipeCtrl: extraGiPipeCtrl,
      extraGiPriceCtrl: extraGiPriceCtrl,
      extraCopperPipeCtrl: extraCopperPipeCtrl,
      extraCopperPriceCtrl: extraCopperPriceCtrl,
      extraTotalPriceCtrl: extraTotalPriceCtrl,
      extraTotalPipeCtrl: extraTotalPipeCtrl,
      materialListCopper: materialListCopper,
    ));
  }


}
