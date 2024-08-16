import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:collection/collection.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/helper/form_feasibility_helper.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_event.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_state.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';

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
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<MeterInitReadingEvent>(_meterInitReading);
    on<SelectRFCDeclarationDateEvent>(_selectRFCDeclarationDate);
    on<SelectProposedConDateEvent>(_selectProposedConDate);
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
    on<SelectQTYLMCEvent>(_selectQTYLMC);
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

  String schema = "";
  String userName = "";
  String installRegulator = "0";
  String extraPipe = "0";
  String extraPrice = "0";

  ListOfMeterNo meterNoValue = ListOfMeterNo();
  GetConstantModel typeOfNrValue = GetConstantModel();
  GetConstantModel readyNGCValue = GetConstantModel();
  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNumber = [];
  List<String> listOfMeterNumberSerial = [];
  List<String> listOfMeterNumberId = [];
  List<ListOfMeterNo> listOfRegulator = [];
  List<String> listOfRegulatorSerial = [];
  List<String> listOfRegulatorId = [];
  List<GetConstantModel> listOfTypeOfNr = [];
  List<GetConstantModel> listOfReadyNGC = [];
  List<LmcReasonModel> listOfDelayReason = [];
  List<LmcReasonModel> listOfRegulatorType = [];
  List<FreeMaterialData> listOfAllMaterial = [];
  List<MaterialItem> listOfMaterial = [];
  List<MaterialItem> materialList = [];
  List<String> listOfAllMaterialId = [];
  List<String> listOfQtyLMC = [];
  List<GetConstantModel> listOfAllRFC = [];

  TextEditingController meterNumberSerialController = TextEditingController();
  TextEditingController regulatorSerialController = TextEditingController();
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
  TextEditingController rfcConDateController = TextEditingController();
  TextEditingController srNumberController = TextEditingController();
  TextEditingController proConDateController = TextEditingController();
  TextEditingController workCompletedDate = TextEditingController();
  TextEditingController meterReadingDate = TextEditingController();
  TextEditingController extraPipeController = TextEditingController(text: "0");
  TextEditingController extraPriceController = TextEditingController(text: "0");

  FocusNode meterIniReading1FocusNode = FocusNode();
  FocusNode meterIniReading2FocusNode = FocusNode();
  FocusNode meterIniReading3FocusNode = FocusNode();

  String regulatorId = '';
  String materialId = '';
  String pipeQty = '0.00';

  File housePhoto = File("");
  File rfcCardPhoto = File("");
  File meterPhoto = File("");
  File pneumaticTestReportPhoto = File("");
  File installationPhoto = File("");

  _pageLoad(FormInstallationPageLoadEvent event, emit) async {
    emit(FormInstallationInitialState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    isInstallRegulator = false;
    isRegulator = false;
    isDelayReason = false;
    isCheckMeterMismatch = false;
    isCheckRegulatorMismatch = false;
    pipeQty = '0.00';
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
    listOfRegulatorSerial = [];
    listOfRegulatorId = [];

    listOfTypeOfNr = [];
    listOfReadyNGC = [];
    listOfDelayReason = [];
    listOfRegulatorType = [];

    listOfAllMaterial = [];
    listOfMaterial = [];
    materialList = [];
    listOfAllMaterialId = [];
    listOfQtyLMC = [];
    listOfAllRFC = [];
    extraPipe = "0";
    extraPrice = "0";
    srNumberController.text = "";
    meterNumberSerialController.text = "";
    regulatorSerialController.text = "";
    bpNumberController.text = "";
    feasibilityDateController.text = "";
    latOfHouseController.text = "";
    longOfHouseController.text = "";
    proposedDateController.text = "";
    installationDateController.text = "";
    meterIniReading1Controller.text = "";
    meterIniReading2Controller.text = "";
    meterIniReading3Controller.text = "";
    meterInitialReadingController.text = "";
    meterIniReading1FocusNode = FocusNode();
    meterIniReading2FocusNode = FocusNode();
    meterIniReading3FocusNode = FocusNode();
    schema = await SharedPref.getString(
      key: PrefsValue.schema,
    );
    userName = await SharedPref.getString(
      key: PrefsValue.userName,
    );
    rfcConDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    proConDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    workCompletedDate.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    meterReadingDate.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    installationDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    extraPipeController.text = "0";
    extraPriceController.text = "0";
    trNumberController.text = await SharedPref.getString(key: PrefsValue.trNumber);
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    proposedDateController.text = await SharedPref.getString(key: PrefsValue.proposedDate);
    feasibilityDateController.text = await SharedPref.getString(key: PrefsValue.feasibilityVisitDate);
    await fetchTypeOfNrApi(context: event.context);
    await fetchReadyForNgcApi(context: event.context);
    await fetchMetersApi(context: event.context, meterSerial: "");
    await fetchDelayReasonApi(context: event.context);
    await fetchRegulatorTypeApi(context: event.context);
    await fetchRFCApi(context: event.context,);
    await fetchFreeMaterialApi(context: event.context,);
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
      DateTime  proposedDate = DateFormat(AppString.dateFormat).parse(proposedDateController.text);
      DateTime  installationDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
      if (installationDate.compareTo(proposedDate) <= 0 ) {
        isDelayReason = false;
      } else {
        isDelayReason = true;
      }
      _eventCompleted(emit);
    }
  }

  checkDelayReason(){
    DateTime  proposedDate = DateFormat(AppString.dateFormat).parse(proposedDateController.text);
    DateTime  installationDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
    if (installationDate.compareTo(proposedDate) <= 0 ) {
      isDelayReason = false;
    } else {
      isDelayReason = true;
    }
  }

  _selectRFCDeclarationDate(SelectRFCDeclarationDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: assignDate,
      lastDate: DateTime.now(),
    );
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      rfcConDateController.text = formattedDate.toString();
    }
    _eventCompleted(emit);
  }

  _selectProposedConDate(SelectProposedConDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: assignDate, lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      rfcConDateController.text = formattedDate.toString();
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
    if(isInstallRegulator == true){
      installRegulator = "1";
    }else{
      installRegulator = "0";
    }
    _eventCompleted(emit);
  }

  _selectRegulatorTypeValue(SelectRegulatorTypeValueEvent event, emit) async {
    isRegulator = true;
    _eventCompleted(emit);
    regulatorTypeValue = event.regulatorTypeValue;
    regulatorSerialController.clear();
    if (event.regulatorTypeValue.name != null) {
      await fetchRegulatorsApi(context: event.context, regulatorSerial: "", regulatorType: event.regulatorTypeValue.id.toString());
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
    List<String> tempList = [];
    var res = await FormFeasibilityHelper.getAllFreeMaterialApi(
      context: context,
    );
    if (res != null) {
      listOfAllMaterial = res;
      tempList = List.generate(listOfAllMaterial.length, (i) => ('${listOfAllMaterial[i].id}'));
      listOfAllMaterialId.addAll(tempList);
      listOfMaterial = List.generate(
        listOfAllMaterial.length,
            (i) => MaterialItem(
            value: '0',
            id: '${listOfAllMaterial[i].id}',
            name: '${listOfAllMaterial[i].materialName}',
            unit: '${listOfAllMaterial[i].materialUnit}',
            controller: TextEditingController(text: "0")),
      );
      materialList.addAll(listOfMaterial);
      listOfQtyLMC = listOfMaterial.asMap().values.map((e) => e.controller.text).toList();
      return res;
    }
  }

  _selectQTYLMC(SelectQTYLMCEvent event, emit) async {
    double sumOfPipes = 0.0;
    for(int i = 0; i< listOfMaterial.length; i++){
      MaterialItem dataOfAllMaterial = listOfMaterial[i];
      if(dataOfAllMaterial.name.toLowerCase().contains("pipe")){
        if(dataOfAllMaterial.controller.text != ""){
          sumOfPipes +=  double.parse(dataOfAllMaterial.controller.text);
        }else{
          dataOfAllMaterial.controller.text = '0';
        }
      }
    }
    pipeQty = sumOfPipes.toString();
    _eventCompleted(emit);
    print("sumOfPipes---> $sumOfPipes");
    if(sumOfPipes > 15.0){
      extraPriceController.text = "";
      extraPipeController.text = "";
      var res = await FormInstallationHelper.getExtraPipeDetailsApi(context: event.context, pipeQty : sumOfPipes.toString());
      if(res != null){
        extraPriceController.text = res.price.toString() + ' ' + res.priceUm.toString();
        extraPipeController.text = res.qty.toString() + ' ' + res.pipeUm.toString();
        extraPipe = res.price.toString();
        extraPrice = res.qty.toString();
        _eventCompleted(emit);
      }else{
        extraPriceController.text = '0';
        extraPipeController.text = '0';
        _eventCompleted(emit);
      }
    }
    _eventCompleted(emit);
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
  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    meterNumberSerialController.text = event.meterReadingValue;
    materialId = listOfMeterNumber.firstWhereOrNull((element) => element.serialNumber == event.meterReadingValue)?.id ?? "";
  }
  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
      if (regulatorTypeValue.id != null) {
        regulatorSerialController.text = event.regulatorsValue;
        regulatorId = listOfRegulator.firstWhereOrNull((element) => element.serialNumber == event.regulatorsValue)?.id ?? "";
      } else {
        Utils.errorSnackBar(msg: "The Regulator Type field is required.", context: event.context);
      }
      _eventCompleted(emit);
  }

  _setHouseLocation() async {
    var getLocation = await FormInstallationHelper.getCurrentLocation();
    latOfHouseController.text = getLocation.latitude.toString();
    longOfHouseController.text = getLocation.longitude.toString();
    return getLocation;
  }

  _selectLocationOfHouse(SelectLocationOfHouseEvent event, emit) {
    _setHouseLocation();
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
      await _setHouseLocation();
      housePhoto = photoPath;
    }
    _eventCompleted(emit);
  }


  _captureCameraHouse(CaptureCameraHouseEvent event, Emitter<FormInstallationState> emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      await _setHouseLocation();
      housePhoto = photoPath;
    }
    _eventCompleted(emit);
  }


  fetchRFCApi({required BuildContext context}) async {
    var res = await FormFeasibilityHelper.getRFCApi(context: context,);
    if (res != null) {
      listOfAllRFC = res;
      return res;
    }
  }

  _selectRFCCheckValue(SelectRFCCheckValueEvent event, emit) {
    emit(FormInstallationInitialState());
    isSelected = event.isSelected;
    listOfAllRFC[event.index].isSelected = isSelected;
    log("${listOfAllRFC[event.index]}-->${listOfAllRFC[event.index].isSelected}");
    _eventCompleted(emit);
  }

  _submit(SubmitFormInstallationEvent event, emit) async {
    try {
      var validationCheck = await FormInstallationHelper.validationSubmit(
        context: event.context,
        dateInstallation: installationDateController.text.trim().toString(),
        isDelayReason: isDelayReason,
        delayReason: delayReasonValue,
        meterNumber: materialId,
        isCheckMeterMismatch: isCheckMeterMismatch,
        meterInit1: meterIniReading1Controller.text.trim().toString(),
        meterInit2: meterIniReading2Controller.text.trim().toString(),
        meterInit3: meterIniReading3Controller.text.trim().toString(),
        regulatorType: regulatorTypeValue,
        isInstallRegulator: isInstallRegulator,
        srNumber: srNumberController.text.trim().toString(),
        regulatorNumber: regulatorSerialController.text.trim().toString(),
        isCheckRegulatorMismatch: isCheckRegulatorMismatch,
        proposedNGCConversionDate: proConDateController.text.trim().toString(),
        fittingDetails: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
        meterPhoto: meterPhoto.path.toString(),
        rfcPhoto: rfcCardPhoto.path.toString(),
        housePhoto: housePhoto.path.toString(),
        pneumaticTestReportPhoto: pneumaticTestReportPhoto.path.toString(),
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormInstallationHelper.saveLMCInstallation(
          context: event.context,
          extraPipe: extraPipe.toString(),
          extraPrice: extraPrice.toString(),
          rfcForm: "",
          workCompletedDate: workCompletedDate.text.trim().toString(),
          meterReadingDate: meterReadingDate.text.trim().toString(),
          meterNo: materialId,
          rfcDate: rfcConDateController.text.trim().toString(),
          latitudeHg: latOfHouseController.text.trim().toString(),
          longitudeHg: longOfHouseController.text.trim().toString(),
         /* latitudeMR: latOfMRController.text.trim().toString(),
          longitudeMR: longOfMRController.text.trim().toString(),
          latitudeTf: latOfSRController.text.trim().toString(),
          longitudeTf: longOfSRController.text.trim().toString(),*/
          srNumber: srNumberController.text.trim().toString(),
      /*    mrPhoto: mrPhoto.path,
          mrRegulatorId: "",*/
          regulatorCheck: installRegulator,
          materialIdLmc: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          proposedNgcDate: proConDateController.text.trim().toString(),
          qtyLmc: listOfQtyLMC.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          regulatorsNumber: regulatorId.toString(),
          regulatorTypeId: regulatorTypeValue,
          delayReason: delayReasonValue,
          meterReading: meterInitialReadingController.text.trim().toString(),
          materialId: materialId,
          typeOfNR: typeOfNrValue,
          ngc: readyNGCValue,
          meterPhoto: meterPhoto.path,
          housePhoto: housePhoto.path,
      //    sr_photo: srPhoto.path,
          pneumaticPhoto: pneumaticTestReportPhoto.path.toString(),
          isometricPhoto: rfcCardPhoto.path.toString(),
        );
        if (res != null && res.error == false) {
          isBtnLoader = false;
          _eventCompleted(emit);
          await Utils.successSnackBar(msg: res.data!, context: event.context);
          await FormFeasibilityHelper.clearCache();
          Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (BuildContext context) => HomeView()), (Route<dynamic> route) => false);
        } else if (res != null && res.error == true){
          await Utils.errorSnackBar(msg: res.data!, context: event.context);
        }else {
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
      userName: userName,
      schema: schema,
      isLoader: isLoader,
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
      bpNumberController: bpNumberController,
      trNumberController: trNumberController,
      proposedDateController: proposedDateController,
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
      listOfRegulator: listOfRegulator,
      listOfAllMaterial: listOfAllMaterial,
      listOfAllRFC: listOfAllRFC,
      materialList: materialList,
      latOfHouseController: latOfHouseController,
      longOfHouseController: longOfHouseController,
      rfcConDateController: rfcConDateController,
      srNumberController: srNumberController,
      proConDateController: proConDateController,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
      regulatorSerialController: regulatorSerialController,
      meterNumberSerialController: meterNumberSerialController,
    ));
  }
}
