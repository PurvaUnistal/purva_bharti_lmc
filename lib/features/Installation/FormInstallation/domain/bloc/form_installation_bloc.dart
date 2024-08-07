import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/helper/form_feasibility_helper.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_event.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_state.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';

class FormInstallationBloc extends Bloc<FormInstallationEvent, FormInstallationState> {
  FormInstallationBloc() : super(FormInstallationInitialState()) {
    on<FormInstallationPageLoadEvent>(_pageLoad);
    on<SelectInstallationDateEvent>(_selectInstallationDate);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectRegulatorTypeValueEvent>(_selectRegulatorTypeValue);
    on<SelectNGCValueEvent>(_selectNGCValue);
    on<SelectTypeNRValueEvent>(_selectTypeNRValue);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<MeterInitReadingEvent>(_meterInitReading);
    on<SelectRFCDeclarationDateEvent>(_selectRFCDeclarationDate);
    on<SelectProposedConDateEvent>(_selectProposedConDate);
    on<SelectLocationOfSREvent>(_selectLocationOfSR);
    on<SelectLocationOfHouseEvent>(_selectLocationOfHouse);
    on<SelectRegulatorsValueEvent>(_selectRegulatorsValue);
    on<CaptureGalleryRFCCardEvent>(_captureGalleryRFCCard);
    on<CaptureCameraRFCCardEvent>(_captureCameraRFCCard);
    on<CaptureGalleryPneumaticEvent>(_captureGalleryPneumatic);
    on<CaptureCameraPneumaticEvent>(_captureCameraPneumatic);
    on<CaptureGalleryInstallationEvent>(_captureGalleryInstallation);
    on<CaptureCameraInstallationEvent>(_captureCameraInstallation);
    on<SelectRFCCheckValueEvent>(_selectRFCCheckValue);
    on<SelectQTYLMCEvent>(_selectQTYLMC);
    on<SubmitFormInstallationEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  bool isRegulator = false;
  bool isSelected = false;
  bool isDelayReason = false;


  ListOfMeterNo meterNoValue = ListOfMeterNo();
  GetConstantModel typeOfNrValue = GetConstantModel();
  GetConstantModel readyNGCValue = GetConstantModel();
  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNo = [];
  List<GetConstantModel> listOfTypeOfNr = [];
  List<GetConstantModel> listOfReadyNGC = [];
  List<LmcReasonModel> listOfDelayReason = [];
  List<LmcReasonModel> listOfRegulatorType = [];
  List<String> listOfMeterNumber = [];
  List<String> listOfMeterNumberId = [];
  List<ListOfMeterNo> listOfRegulatorNo = [];
  List<String> listOfRegulator = [];
  List<String> listOfRegulatorId = [];
  List<FreeMaterialData> listOfAllMaterial = [];
  List<MaterialItem> materialList = [];
  List<String> listOfAllMaterialId = [];
  List<String> listOfQtyLMC = [];
  List<GetConstantModel> listOfAllRFC = [];

  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController installationDateController = TextEditingController();
  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController meterIniReading1Controller = TextEditingController();
  TextEditingController meterIniReading2Controller = TextEditingController();
  TextEditingController meterIniReading3Controller = TextEditingController();
  TextEditingController meterInitialReadingController = TextEditingController();
  TextEditingController latOfSRController = TextEditingController();
  TextEditingController longOfSRController = TextEditingController();
  TextEditingController latOfHouseController = TextEditingController();
  TextEditingController longOfHouseController = TextEditingController();
  TextEditingController rfcConDateController = TextEditingController();
  TextEditingController  proConDateController = TextEditingController();
  TextEditingController  workCompletedDate = TextEditingController();
  TextEditingController  meterReadingDate = TextEditingController();
  TextEditingController extraPipeController= TextEditingController(text: "0");
  TextEditingController extraPriceController= TextEditingController(text: "0");

  FocusNode meterIniReading1FocusNode = FocusNode();
  FocusNode meterIniReading2FocusNode = FocusNode();
  FocusNode meterIniReading3FocusNode = FocusNode();

  String regulatorId = '';
  String materialId = '';

  File rfcCardImg = File("");
  File meterImg = File("");
  File pneumaticTestReportImg = File("");
  File installationImg = File("");


  _pageLoad(FormInstallationPageLoadEvent event, emit) async {
    emit(FormInstallationInitialState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    isRegulator = false;
    isDelayReason = false;
    rfcCardImg = File("");
    pneumaticTestReportImg = File("");
    installationImg = File("");
    meterImg = File("");
    meterNoValue = ListOfMeterNo();
    typeOfNrValue = GetConstantModel();
    delayReasonValue =   LmcReasonModel();
    regulatorTypeValue  = LmcReasonModel();
    listOfMeterNo = [];
    listOfTypeOfNr = [];
    listOfReadyNGC = [];
    listOfDelayReason = [];
    listOfRegulatorType = [];
    listOfMeterNumber = [];
    listOfMeterNumberId = [];
    listOfRegulatorNo = [];
    listOfRegulator = [];
    listOfRegulatorId = [];
    listOfAllMaterial = [];
    materialList = [];
    listOfAllMaterialId = [];
    listOfQtyLMC = [];
    listOfAllRFC = [];
    bpNumberController.text = "";
    feasibilityDateController.text = "";
    latOfSRController.text = "";
    longOfSRController.text = "";
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
    rfcConDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    proConDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    workCompletedDate.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    meterReadingDate.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    installationDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    extraPipeController.text = "0";
    extraPriceController.text = "0";
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    proposedDateController.text = await SharedPref.getString(key: PrefsValue.proposedDate);
    feasibilityDateController.text = await SharedPref.getString(key: PrefsValue.feasibilityVisitDate);
    await fetchTypeOfNrApi(context: event.context);
    await fetchReadyForNgcApi(context: event.context);
    await fetchMetersApi(context: event.context, meterSerial: "");
    await fetchDelayReasonApi(context: event.context);
    await fetchRegulatorTypeApi(context: event.context);
    await _setSRLocation();
    await _setHouseLocation();
    await fetchRFCApi(context: event.context,);
    await fetchFreeMaterialApi(context: event.context,);
    _eventCompleted(emit);
  }

  _selectInstallationDate(SelectInstallationDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    var proposedDate = DateFormat(AppString.dateFormat).parse(proposedDateController.text);
    var installationDate = DateFormat(AppString.dateFormat).parse(installationDateController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      installationDateController.text = formattedDate.toString();
      if(assignDate.isAtSameMomentAs(proposedDate) || assignDate.isBefore(proposedDate)|| assignDate.isBefore(installationDate)){
        isDelayReason = true;
        _eventCompleted(emit);
      }else{
        isDelayReason = false;
        _eventCompleted(emit);
      }
      _eventCompleted(emit);
    }
  }

  _selectRFCDeclarationDate(SelectRFCDeclarationDateEvent event,emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      rfcConDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectProposedConDate(SelectProposedConDateEvent event,emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse( installationDateController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime(2050));
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

  _selectRegulatorTypeValue(SelectRegulatorTypeValueEvent event, emit) async {
    isRegulator =  true;
    _eventCompleted(emit);
    regulatorTypeValue = event.regulatorTypeValue;
    if(event.regulatorTypeValue.name != null){
      await fetchRegulatorsApi(context: event.context,regulatorSerial: "", regulatorType : event.regulatorTypeValue.id.toString());
    }
    isRegulator =  false;
    _eventCompleted(emit);
  }

  _selectTypeNRValue(SelectTypeNRValueEvent event, emit) {
    typeOfNrValue = event.typeOfNRValue;
    _eventCompleted(emit);
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    if(event.meterReadingValue.isNotEmpty && event.meterReadingValue.length > 1){
      await fetchMetersApi(context: event.context, meterSerial: event.meterReadingValue);
      for(int i = 0; i< listOfMeterNo.length; i++){
        listOfMeterNumberId = listOfMeterNo.map((e) => e.id!).toList();
        materialId = await listOfMeterNumberId[i].toString();
      }
    }
    _eventCompleted(emit);
  }

  fetchTypeOfNrApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.getTypeOfNrApi(context: context);
    if (res != null) {
      listOfTypeOfNr = res;
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

  fetchMetersApi({required BuildContext context, required String meterSerial}) async {
    var res = await FormInstallationHelper.getMetersApi(context: context,meterSerial: meterSerial);
    if (res != null) {
      listOfMeterNo = res;
      listOfMeterNumber = listOfMeterNo.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  fetchFreeMaterialApi({required BuildContext context}) async {
    List<String> tempList = [];
    List<MaterialItem> _materialList = [];
    var res = await FormFeasibilityHelper.getAllFreeMaterialApi(context: context,);
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

  _selectQTYLMC(SelectQTYLMCEvent event,  emit) {
    listOfQtyLMC[event.index] = event.qtyValue;
    _eventCompleted(emit);
  }
  _meterInitReading(MeterInitReadingEvent event, emit) {
    var meterIniReading1 = meterIniReading1Controller.text;
    var meterIniReading2 = meterIniReading2Controller.text;
    var meterIniReading3 = meterIniReading3Controller.text;
    double meterIniReadingAdd = double.parse( meterIniReading1 + meterIniReading2 + meterIniReading3);
    meterInitialReadingController.text = (meterIniReadingAdd / 1000).toString();
    log("meterInitialReadingController--${meterInitialReadingController.text}");
    _eventCompleted(emit);
  }

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    var res = await FormInstallationHelper.getRegulatorsApi(context: context,regulatorSerial: regulatorSerial,regulatorType: regulatorType);
    if (res != null) {
      listOfRegulatorNo = res;
      listOfRegulator = listOfRegulatorNo.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    if(event.regulatorsValue.isNotEmpty){
      await fetchRegulatorsApi(context: event.context, regulatorSerial: event.regulatorsValue, regulatorType : "");
      for(int i = 0; i< listOfRegulatorNo.length; i++){
        listOfRegulator = listOfRegulatorNo.map((e) => e.serialNumber!).toList();
        listOfRegulatorId = listOfRegulatorNo.map((e) => e.id!).toList();
        regulatorId = await listOfRegulatorId[i].toString();
      }
    }
    _eventCompleted(emit);
  }

  _setSRLocation() async {
    var getLocation = await FormInstallationHelper.getCurrentLocation();
    latOfSRController.text = getLocation.latitude.toString();
    longOfSRController.text = getLocation.longitude.toString();
    return getLocation;
  }

  _setHouseLocation() async {
    var getLocation = await FormInstallationHelper.getCurrentLocation();
    latOfHouseController.text = getLocation.latitude.toString();
    longOfHouseController.text = getLocation.longitude.toString();
    return getLocation;
  }

  _selectLocationOfSR(SelectLocationOfSREvent event,emit) {
    _setSRLocation();
    _eventCompleted(emit);
  }

  _selectLocationOfHouse(SelectLocationOfHouseEvent event,emit) {
    _setHouseLocation();
    _eventCompleted(emit);
  }

  _captureGalleryMeter(CaptureGalleryMeterEvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      meterImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraMeter(CaptureCameraMeterEvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      meterImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryRFCCard(CaptureGalleryRFCCardEvent event,emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraRFCCard(CaptureCameraRFCCardEvent event,emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryPneumatic(CaptureGalleryPneumaticEvent event,emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraPneumatic(CaptureCameraPneumaticEvent event,emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryInstallation(CaptureGalleryInstallationEvent event,emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraInstallation(CaptureCameraInstallationEvent event,emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationImg = photoPath;
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
  //  try {
      var validationCheck = await FormInstallationHelper.validationSubmit(
        context: event.context,
        dateInstallation:  installationDateController.text.trim().toString(),
        delayReason: delayReasonValue,
        meterNumber : materialId,
        meterInit1 : meterIniReading1Controller.text.trim().toString(),
        meterInit2 : meterIniReading2Controller.text.trim().toString(),
        meterInit3 : meterIniReading3Controller.text.trim().toString(),
        rfcDeclarationDate : rfcConDateController.text.trim().toString(),
        proposedNGCConversionDate : proConDateController.text.trim().toString(),
        fittingDetails : listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
        meterPhoto : meterImg.path.toString(),
        rfcPhoto : rfcCardImg.path.toString(),
        pneumaticTestReportPhoto : pneumaticTestReportImg.path.toString(),
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormInstallationHelper.saveLMCInstallation(
          context: event.context,
          extraPipe: extraPipeController.text.trim().toString(),
          extraPrice: extraPriceController.text.trim().toString(),
          rfcForm: "",
          workCompletedDate:workCompletedDate.text.trim().toString(),
          meterReadingDate: meterReadingDate.text.trim().toString(),
          meterNo:listOfMeterNumber.toString(),
          latitudeTf: latOfSRController.text.trim().toString(),
          longitudeTf: longOfSRController.text.trim().toString(),
          latitudeHg: latOfHouseController.text.trim().toString(),
          longitudeHg: longOfHouseController.text.trim().toString(),
          materialIdLmc:listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          proposedNgcDate: proConDateController.text.trim().toString(),
          qtyLmc:  listOfQtyLMC.toList().toString().replaceAll('[', '').replaceAll(']', ''),
          regulators: regulatorId.toString(),
          regulatorTypeId: regulatorTypeValue,
          delayReason: delayReasonValue,
          meterReading: meterInitialReadingController.text.trim().toString(),
          materialId: materialId,
          typeOfNR: typeOfNrValue,
          ngc: readyNGCValue,
          meterPhoto: meterImg.path,
          pneumaticPhoto:pneumaticTestReportImg.path.toString(),
          isometricPhoto: rfcCardImg.path.toString(),
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
                  (Route<dynamic> route) => false);
        }else {
          isBtnLoader = false;
          _eventCompleted(emit);
        }
      }
   /* } catch (e) {
      print("_submit-->${e.toString()}");
      isBtnLoader = false;
      _eventCompleted(emit);
    }*/
  }


  _eventCompleted(emit) {
    emit(FormInstallationDataState(
      isLoader: isLoader,
      isBtnLoader: isBtnLoader,
      isDelayReason: isDelayReason,
      isRegulator: isRegulator,
      meterImg: meterImg,
      meterNoValue: meterNoValue,
      typeOfNrValue: typeOfNrValue,
      listOfRegulatorType: listOfRegulatorType,
      regulatorTypeValue: regulatorTypeValue,
      delayReasonValue: delayReasonValue,
      listOfMeterNo: listOfMeterNo,
      listOfTypeOfNr: listOfTypeOfNr,
      listOfMeterNumber: listOfMeterNumber,
      listOfDelayReason: listOfDelayReason,
      bpNumberController: bpNumberController,
      proposedDateController: proposedDateController,
      installationDateController: installationDateController,
      meterIniReading1Controller: meterIniReading1Controller,
      meterIniReading2Controller: meterIniReading2Controller,
      meterIniReading3Controller: meterIniReading3Controller,
      meterInitialReadingController: meterInitialReadingController,
      meterIniReading1FocusNode: meterIniReading1FocusNode,
      meterIniReading2FocusNode: meterIniReading2FocusNode,
      meterIniReading3FocusNode: meterIniReading3FocusNode,
      listOfQtyLMC : listOfQtyLMC,
      isSelected : isSelected,
      rfcCardImg : rfcCardImg,
      pneumaticTestReportImg : pneumaticTestReportImg,
      installationImg : installationImg,
      listOfRegulatorNo :listOfRegulatorNo,
      listOfRegulator :listOfRegulator,
      listOfAllMaterial :listOfAllMaterial,
      listOfAllRFC :listOfAllRFC,
      materialList :materialList,
      latOfSRController :latOfSRController,
      longOfSRController :longOfSRController,
      latOfHouseController : latOfHouseController,
      longOfHouseController:longOfHouseController,
      rfcConDateController : rfcConDateController,
      proConDateController : proConDateController,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
    ));
  }

}
