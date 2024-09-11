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
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_event.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_state.dart';
import 'package:lmc/features/NGC/NGCForm/helper/ngc_form_helper.dart';
import 'package:lmc/service/Apis.dart';

class NGCFormBloc extends Bloc<NGCFormEvent, NGCFormState> {
  NGCFormBloc() : super(NGCFormInitialState()) {
    on<NGCFormLoadEvent>(_pageLoad);
    on<SelectNGConversionDateEvent>(_selectNGConversionDate);
    on<MeterInitReadingEvent>(_meterInitReading);
    on<SelectTypeNRValueEvent>(_selectTypeNRValue);
    on<SelectMeterReplaceEvent>(_selectMeterReplace);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<SelectRegulatorTypeValueEvent>(_selectRegulatorTypeValue);
    on<SelectRegulatorsValueEvent>(_selectRegulatorsValue);
    on<SelectSRegulatorsEvent>(_selectSRegulators);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectLocationOfSREvent>(_locationOfSR);
    on<SelectLocationOfMREvent>(_locationOfMR);
    on<SelectMeterTypeValueEvent>(_selectMeterTypeValue);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<CaptureGalleryPneumaticEvent>(_captureGalleryPneumatic);
    on<CaptureCameraPneumaticEvent>(_captureCameraPneumatic);
    on<CaptureGalleryRfcEvent>(_captureGalleryRfc);
    on<CaptureCameraRfcEvent>(_captureCameraRfc);
    on<CaptureGalleryMREvent>(_captureGalleryMR);
    on<CaptureCameraMREvent>(_captureCameraMR);
    on<CaptureGallerySREvent>(_captureGallerySR);
    on<CaptureCameraSREvent>(_captureCameraSR);
    on<CaptureGalleryNGCReportEvent>(_captureGalleryNGCReport);
    on<CaptureCameraNGCReportEvent>(_captureCameraNGCReport);
    on<NGCSubmitEvent>(_submit);
  }
  bool isRegulator = false;
  File mrPhoto = File("");
  File srPhoto = File("");
  File pneumaticPhoto = File("");
  File rfcPhoto = File("");
  File _meterPhoto = File("");
  File get meterPhoto => _meterPhoto;

  File _ngcReportPhoto = File("");
  File get ngcReportPhoto => _ngcReportPhoto;

  bool _isPageLoader = false;
  bool get isPageLoader => _isPageLoader;

  bool _isBtnLoader = false;
  bool get isBtnLoader => _isBtnLoader;

  bool isMeterReplacement = false;
  bool isMeterReplace = false;
  bool isCheckMeterMismatch = false;
  bool isCheckRegulatorMismatch = false;
  bool isCheckSR = false;
  bool isDelayReason = false;

  String schema = "";
  String role = "";
  String userName = "";
  String dmaUserId = "";
  String isInstall = "";
  String lmcInstallationId = "";
  String regulatorId = '';
  String srRegulatorId = '';
  String materialId = '';
  String meterReplace = "0";
  String lmcPath = "";
  String baseUrl = '';
  String networkMeterPhoto = "";
  String networkRfcPhoto = "";
  String networkPneumaticPhoto = "";
  String regulatorCheck = "";

  TextEditingController meterIniReading1Controller = TextEditingController();
  TextEditingController meterIniReading2Controller = TextEditingController();
  TextEditingController meterIniReading3Controller = TextEditingController();
  TextEditingController meterInitialReadingController = TextEditingController();
  TextEditingController meterNumberSerialController = TextEditingController();
  TextEditingController meterConnectionMeterController = TextEditingController();
  TextEditingController regulatorSerialController = TextEditingController();
  TextEditingController srNumberController = TextEditingController();
  TextEditingController delayForReasonController = TextEditingController();
  TextEditingController ngConversionDateController = TextEditingController();
  TextEditingController latOfSRController = TextEditingController();
  TextEditingController longOfSRController = TextEditingController();
  TextEditingController latOfMRController = TextEditingController();
  TextEditingController longOfMRController = TextEditingController();
  TextEditingController nameContractorController = TextEditingController();
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController reasonMeterChangeController = TextEditingController();
  TextEditingController noOfBurnersController = TextEditingController();
  TextEditingController meterSerialController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController altMobileNumberController = TextEditingController();
  TextEditingController noOfFamilyMembersController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController typeOfNrController = TextEditingController();
  TextEditingController dateInstallationController = TextEditingController();
  TextEditingController delayReasonController = TextEditingController();
  TextEditingController proposedNgcDateController = TextEditingController();
  TextEditingController extraPipeController = TextEditingController();
  TextEditingController extraPriceController = TextEditingController();
  TextEditingController rfcDateController = TextEditingController();

  FocusNode meterIniReading1FocusNode = FocusNode();
  FocusNode meterIniReading2FocusNode = FocusNode();
  FocusNode meterIniReading3FocusNode = FocusNode();

  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();
  LmcReasonModel meterReplaceTypeValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNumber = [];
  List<String> listOfMeterNumberSerial = [];
  List<String> listOfMeterNumberId = [];

  List<LmcReasonModel> listOfRegulatorType = [];

  List<ListOfMeterNo> listOfRegulator = [];
  List<String> listOfRegulatorSerial = [];
  List<String> listOfRegulatorId = [];

  List<String> listOfSRSerial = [];

  List<GetConstantModel> listOfTypeOfNr = [];
  GetConstantModel typeOfNrValue = GetConstantModel();

  List<LmcReasonModel> listOfDelayReason = [];
  List<LmcReasonModel> listOfNgcDelayStatus = [];
  List<LmcReasonModel> listOfMeterReplaceType = [];

  _pageLoad(NGCFormLoadEvent event, emit) async {
    emit(NGCFormPageLoadState());
    _isPageLoader = false;
    isRegulator = false;
    _isBtnLoader = false;
    isMeterReplace = false;
    isMeterReplacement = false;
    isCheckMeterMismatch = false;
    isCheckRegulatorMismatch = false;
    isCheckSR = false;
    regulatorId = '';
    srRegulatorId = '';
    materialId = '';
    meterReplace = "0";
    mrPhoto = File("");
    srPhoto = File("");
    _meterPhoto = File("");
    _ngcReportPhoto = File("");
    listOfTypeOfNr = [];
    typeOfNrValue = GetConstantModel();
    listOfMeterNumber = [];
    listOfMeterNumberSerial = [];
    listOfMeterNumberId = [];
    listOfRegulatorType = [];
    listOfRegulator = [];
    listOfRegulatorSerial = [];
    listOfSRSerial = [];
    listOfRegulatorId = [];
    listOfDelayReason = [];
    listOfMeterReplaceType = [];
    delayReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    meterReplaceTypeValue = LmcReasonModel();
    reasonMeterChangeController.text = '';
    meterNumberSerialController.text = '';
    regulatorSerialController.text = '';
    delayReasonController.text = '';
    meterIniReading1Controller.text = "";
    meterIniReading2Controller.text = "";
    meterIniReading3Controller.text = "";
    meterInitialReadingController.text = "";
    meterIniReading1FocusNode = FocusNode();
    meterIniReading2FocusNode = FocusNode();
    meterIniReading3FocusNode = FocusNode();
    schema = await SharedPref.getString(key: PrefsValue.schema);
    userName = await SharedPref.getString(key: PrefsValue.userName);
    latOfSRController.text = "0";
    longOfSRController.text = "0";
    latOfMRController.text = "0";
    longOfMRController.text = "0";
    role = await SharedPref.getString(key: PrefsValue.userRole);
    meterConnectionMeterController.text = await SharedPref.getString(key: PrefsValue.typeOfNr.isEmpty ? "" : PrefsValue.typeOfNr);
    regulatorTypeValue.name = await SharedPref.getString(key: PrefsValue.regulatorType.isEmpty ? "" : PrefsValue.regulatorType);
    regulatorTypeValue.id = await SharedPref.getString(key: PrefsValue.regulatorTypeId.isEmpty ? "" : PrefsValue.regulatorTypeId);
    srRegulatorId = await SharedPref.getString(key: PrefsValue.srRegulatorId);
    srNumberController.text = await SharedPref.getString(key: PrefsValue.srRegulatorSerial);
    regulatorId = await SharedPref.getString(key: PrefsValue.mrRegulatorId);
    regulatorSerialController.text = await SharedPref.getString(key: PrefsValue.mrRegulatorSerial);
    lmcPath = await SharedPref.getString(key: PrefsValue.lmcPath);
    baseUrl = await SharedPref.getString(key: PrefsValue.baseUrl);
    String pathKye = await baseUrl == Apis.basePath ? "uploads/" : "public/uploads/";
    networkMeterPhoto = await SharedPref.getString(key: PrefsValue.meterPhoto);
    networkPneumaticPhoto = await SharedPref.getString(key: PrefsValue.pneumaticPhoto);
    networkRfcPhoto = await SharedPref.getString(key: PrefsValue.rfcPhoto);
    regulatorCheck = await SharedPref.getString(key: PrefsValue.regulatorCheck);
    _meterPhoto = File(baseUrl + pathKye + lmcPath + "/" + networkMeterPhoto.toString());
    rfcPhoto = File(baseUrl + pathKye + lmcPath + "/" + networkRfcPhoto.toString());
    pneumaticPhoto = File(baseUrl + pathKye + lmcPath + "/" + networkPneumaticPhoto.toString());
    dmaUserId = await SharedPref.getString(key: PrefsValue.dmaUserId) ?? "";
    isInstall = await SharedPref.getString(key: PrefsValue.isInstall);
    lmcInstallationId = await SharedPref.getString(key: PrefsValue.lmcInstallationId);
    nameContractorController.text = await SharedPref.getString(key: PrefsValue.userName) ?? "";
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber) ?? "0";
    meterInitialReadingController.text = await SharedPref.getString(key: PrefsValue.meterReading) ?? "0";
    List<String> meterNumberStringArrayValues = (meterInitialReadingController.text ?? "0.000").split("");
    int length = meterNumberStringArrayValues.length;
    meterIniReading1Controller.text = meterNumberStringArrayValues[length - 3];
    meterIniReading2Controller.text = meterNumberStringArrayValues[length - 2];
    meterIniReading3Controller.text = meterNumberStringArrayValues[length - 1];
    materialId = await SharedPref.getString(key: PrefsValue.meterNumberId) ?? "0";
    meterSerialController.text = await SharedPref.getString(key: PrefsValue.meterNumberSerial) ?? "0";
    mobileNumberController.text = await SharedPref.getString(key: PrefsValue.mobileNumber) ?? "";
    emailIdController.text = await SharedPref.getString(key: PrefsValue.email) ?? "-";
    altMobileNumberController.text = await SharedPref.getString(key: PrefsValue.alternateMobileNo) ?? "";
    noOfFamilyMembersController.text = await SharedPref.getString(key: PrefsValue.noOfFamilyMembers) ?? "";
    noOfBurnersController.text = await SharedPref.getString(key: PrefsValue.ngOfBurners) == "" ? "2" : await SharedPref.getString(key: PrefsValue.ngOfBurners);
    typeOfNrController.text = await SharedPref.getString(key: PrefsValue.typeOfNr) ?? "";
    dateInstallationController.text = await SharedPref.getString(key: PrefsValue.lmcInstallationDate) ?? "";
    proposedNgcDateController.text = await SharedPref.getString(key: PrefsValue.proposedNgcDate) ?? "";
    extraPipeController.text = await SharedPref.getString(key: PrefsValue.extraPipe) ?? "";
    extraPriceController.text = await SharedPref.getString(key: PrefsValue.extraPrice) ?? "";
    rfcDateController.text = await SharedPref.getString(key: PrefsValue.rfcDate) ?? "";
    ngConversionDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    //  await fetchDelayReasonApi(context: event.context);
    await fetchTypeOfNrApi(context: event.context);
    await fetchNgcReasonApi(context: event.context);
    await fetchMeterReplaceTypeApi(context: event.context);
    await fetchRegulatorTypeApi(context: event.context);
    await fetchMetersApi(context: event.context, meterSerial: "");
    await checkDelayReason();
    if (regulatorTypeValue.id != null) {
      await fetchRegulatorsApi(context: event.context, regulatorSerial: "", regulatorType: regulatorTypeValue.id.toString());
    }
    _eventCompleted(emit);
  }

  checkDelayReason() {
    DateTime proposedDate = DateFormat(AppString.dateFormat).parse(proposedNgcDateController.text);
    DateTime installationDate = DateFormat(AppString.dateFormat).parse(dateInstallationController.text);
    if (installationDate.compareTo(proposedDate) <= 0) {
      isDelayReason = false;
    } else {
      isDelayReason = true;
    }
  }

  _selectNGConversionDate(SelectNGConversionDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(dateInstallationController.text);
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: assignDate, lastDate: DateTime.now());
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      ngConversionDateController.text = formattedDate.toString();
      checkDelayReason();
      _eventCompleted(emit);
    }
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

  fetchTypeOfNrApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.getTypeOfNrApi(context: context);
    if (res != null) {
      listOfTypeOfNr = res;
      // typeOfNrValue = listOfTypeOfNr.first;
      return res;
    }
  }

  _selectTypeNRValue(SelectTypeNRValueEvent event, emit) {
    typeOfNrValue = event.typeOfNRValue;
    _eventCompleted(emit);
  }

  fetchRegulatorTypeApi({required BuildContext context}) async {
    var res = await NGCFormHelper.regulatorTypeApi(context: context);
    if (res != null) {
      listOfRegulatorType = res;
      return res;
    }
  }

  _selectMeterReplace(SelectMeterReplaceEvent event, emit) {
    isMeterReplace = event.meterReplace;
    if (event.meterReplace == true) {
      meterReplace = "1";
      print("meterReplace-->${meterReplace}");
    } else {
      meterReplace = "0";
      print("meterReplace-->${meterReplace}");
    }
    _eventCompleted(emit);
  }

  _selectRegulatorTypeValue(SelectRegulatorTypeValueEvent event, emit) async {
    isRegulator = true;
    _eventCompleted(emit);
    regulatorTypeValue = event.regulatorTypeValue;
    if (event.regulatorTypeValue.name != null) {
      regulatorSerialController.text = "";
      srNumberController.text = "";
      await fetchRegulatorsApi(context: event.context, regulatorSerial: "", regulatorType: event.regulatorTypeValue.id.toString());
    }
    isRegulator = false;
    _eventCompleted(emit);
  }

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    if (role == "ngc") {
      var res = await NGCFormHelper.getRegulatorsNGCApi(context: context, regulatorSerial: regulatorSerial, regulatorType: regulatorType);
      if (res != null) {
        listOfRegulator = res;
        listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
        listOfSRSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
        return res;
      }
    } else if (role == "lmc") {
      var res = await FormInstallationHelper.getRegulatorsApi(context: context, regulatorSerial: regulatorSerial, regulatorType: regulatorType);
      if (res != null) {
        listOfRegulator = res;
        listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
        listOfSRSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
        return res;
      }
    }
  }

  fetchMetersApi({required BuildContext context, required String meterSerial}) async {
    if (role == "ngc") {
      var res = await NGCFormHelper.getMetersNGCApi(context: context, meterSerial: meterSerial);
      if (res != null) {
        listOfMeterNumber = res;
        listOfMeterNumberSerial = listOfMeterNumber.map((e) => e.serialNumber!).toList();
        return res;
      }
    } else if (role == "lmc") {
      var res = await FormInstallationHelper.getMetersApi(context: context, meterSerial: meterSerial);
      if (res != null) {
        listOfMeterNumber = res;
        listOfMeterNumberSerial = listOfMeterNumber.map((e) => e.serialNumber!).toList();
        return res;
      }
    }
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    materialId = "";
    meterConnectionMeterController.text = "";
    meterNumberSerialController.text = event.meterReadingValue;
    materialId = listOfMeterNumber.firstWhereOrNull((element) => element.serialNumber == event.meterReadingValue)?.id ?? "";
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
    regulatorId = listOfRegulator.firstWhereOrNull((element) => element.serialNumber == event.regulatorsValue)?.id ?? "";
    if (event.regulatorsValue.isNotEmpty && !listOfRegulatorSerial.contains(event.regulatorsValue)) {
      isCheckRegulatorMismatch = true;
    } else {
      isCheckRegulatorMismatch = false;
    }
    _eventCompleted(emit);
  }

  _selectSRegulators(SelectSRegulatorsEvent event, emit) async {
    srNumberController.text = event.sRegulators;
    srRegulatorId = listOfRegulator.firstWhereOrNull((element) => element.serialNumber == event.sRegulators)?.id ?? "";
    if (event.sRegulators.isNotEmpty && !listOfRegulatorSerial.contains(event.sRegulators)) {
      isCheckSR = true;
    } else {
      isCheckSR = false;
    }
    _eventCompleted(emit);
  }

  _selectDelayReasonValue(SelectDelayReasonValueEvent event, emit) {
    delayReasonValue = event.delayReasonValue;
    _eventCompleted(emit);
  }

  _selectMeterTypeValue(SelectMeterTypeValueEvent event, emit) {
    meterReplaceTypeValue = event.meterTypeValue;
    _eventCompleted(emit);
  }

  fetchNgcReasonApi({required BuildContext context}) async {
    var res = await NGCFormHelper.ngcReasonApi(context: context);
    if (res != null) {
      listOfDelayReason = res;
      return res;
    }
  }

  fetchMeterReplaceTypeApi({required BuildContext context}) async {
    var res = await NGCFormHelper.meterReplaceTypeApi(context: context);
    if (res != null) {
      listOfMeterReplaceType = res;
      return res;
    }
  }

  _captureGalleryMeter(CaptureGalleryMeterEvent event, emit) async {
    var photoPath = await NGCFormHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      _meterPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraMeter(CaptureCameraMeterEvent event, emit) async {
    var photoPath = await NGCFormHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      _meterPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryPneumatic(CaptureGalleryPneumaticEvent event, emit) async {
    var photoPath = await NGCFormHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraPneumatic(CaptureCameraPneumaticEvent event, emit) async {
    var photoPath = await NGCFormHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureGalleryRfc(CaptureGalleryRfcEvent event, emit) async {
    var photoPath = await NGCFormHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraRfc(CaptureCameraRfcEvent event, emit) async {
    var photoPath = await NGCFormHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcPhoto = photoPath;
    }
    _eventCompleted(emit);
  }



  _captureGalleryNGCReport(CaptureGalleryNGCReportEvent event, emit) async {
    var photoPath = await NGCFormHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      _ngcReportPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraNGCReport(CaptureCameraNGCReportEvent event, emit) async {
    var photoPath = await NGCFormHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      _ngcReportPhoto = photoPath;
    }
    _eventCompleted(emit);
  }

  _setSRLocation() async {
    var getLocation = await FormInstallationHelper.getCurrentLocation();
    latOfSRController.text = getLocation.latitude.toString();
    longOfSRController.text = getLocation.longitude.toString();
    return getLocation;
  }

  _setMRLocation() async {
    var getLocation = await FormInstallationHelper.getCurrentLocation();
    latOfMRController.text = getLocation.latitude.toString();
    longOfMRController.text = getLocation.longitude.toString();
    return getLocation;
  }

  _locationOfSR(SelectLocationOfSREvent event, emit) async {
    await _setSRLocation();
    _eventCompleted(emit);
  }

  _locationOfMR(SelectLocationOfMREvent event, emit) async {
    await _setMRLocation();
    _eventCompleted(emit);
  }

  _captureCameraMR(CaptureCameraMREvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      mrPhoto = photoPath;
      _setMRLocation();
      _eventCompleted(emit);
      ;
    }
  }

  _captureGalleryMR(CaptureGalleryMREvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    if (photoPath.path.isNotEmpty) {
      mrPhoto = photoPath;
      _setMRLocation();
      log("photo-->$photoPath");
      _eventCompleted(emit);
    }
  }

  _captureCameraSR(CaptureCameraSREvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      srPhoto = photoPath;
      _setSRLocation();
      _eventCompleted(emit);
    }
  }

  _captureGallerySR(CaptureGallerySREvent event, emit) async {
    var photoPath = await FormInstallationHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      srPhoto = photoPath;
      _setSRLocation();
      _eventCompleted(emit);
    }
  }

  _submit(NGCSubmitEvent event, emit) async {
    try {
      var validationCheck = await NGCFormHelper.validationSubmit(
        context: event.context,
        isDelayReason: isDelayReason,
        delayReason: delayReasonValue,
        isCheckMeterMismatch: isCheckMeterMismatch,
        meterNumber: isMeterReplace == true ? meterNumberSerialController.text.trim() : meterSerialController.text.trim().toString(),
        changeMeterType: meterReplace == "1" ? meterReplaceTypeValue.id.toString() : "",
        meterInitialReading: meterInitialReadingController.text.trim().toString(),
        isCheckRegulatorMismatch: isCheckRegulatorMismatch,
        regulatorType: regulatorTypeValue,
        regulatorId: regulatorSerialController.text.trim().toString(),
        mrPhoto: mrPhoto.path,
        srPhoto: srPhoto.path,
        latMR: latOfMRController.text.trim().toString(),
        longMR: longOfMRController.text.trim().toString(),
        latSR: latOfSRController.text.trim().toString(),
        longSR: longOfSRController.text.trim().toString(),
        regulatorNumber: regulatorSerialController.text.trim().toString(),
        srNumber: srNumberController.text.trim().toString(),
        isCheckSR: isCheckSR,
        bpNumber: bpNumberController.text.trim().toString(),
        ngChargeDate: ngConversionDateController.text.trim().toString(),
        meterImg: meterPhoto,
        nameContractor: nameContractorController.text.trim().toString(),
        noOfBurners: noOfBurnersController.text.trim().toString(),
        noOfFamily: noOfFamilyMembersController.text.trim().toString(),
        phoneNo: mobileNumberController.text.trim().toString(),
      );
      if (await validationCheck == true) {
        _isBtnLoader = true;
        _eventCompleted(emit);
        var res = await NGCFormHelper.setNGCReportData(
          context: event.context,
          schema: schema,
          dmaUserId: dmaUserId,
          alternateMobile: altMobileNumberController.text.trim().toString(),
          comment: "",
          contactPerson: mobileNumberController.text.trim().toString(),
          conversionDate: ngConversionDateController.text.trim().toString(),
          email: emailIdController.text.trim().toString(),
          isInstall: isInstall,
          jmrNo: bpNumberController.text.trim().toString(),
          lmcInstallationId: lmcInstallationId.toString(),
          meterReading: meterInitialReadingController.text.trim().toString(),
          mismatchMeterNo: materialId,
          meterNumberId: materialId,
          /* mismatchMeterNo:isMeterReplace == true ? materialId : meterSerialController.text.trim().toString(),
          meterNumberId: isMeterReplace == true ? materialId : meterSerialController.text.trim().toString(),*/
          nameOfContractor: nameContractorController.text.trim().toString(),
          nOfBurners: noOfBurnersController.text.trim().toString(),
          delayReasonValue: delayReasonValue.name == null ? "" : delayReasonValue.name.toString(),
          reasonOfDelay: delayReasonController.text.trim().toString(),
          workCompletedDate: dateInstallationController.text.trim().toString(),
          meterChangeReason: reasonMeterChangeController.text.trim().toString(),
          replaceMeter: meterReplace.toString(),
          changeMeterType: meterReplaceTypeValue,
          regulatorTypeId: regulatorTypeValue,
          srNumber: srNumberController.text.trim().toString(),
          srRegulatorId: srRegulatorId.toString(),
          mrRegulatorId: regulatorId.toString(),
          latitudeMR: latOfMRController.text.trim().toString(),
          longitudeMR: longOfMRController.text.trim().toString(),
          latitudeTf: latOfSRController.text.trim().toString(),
          longitudeTf: longOfSRController.text.trim().toString(),
          meterPhoto: meterPhoto.path.toString(),
          mrPhoto: mrPhoto.path.toString(),
          srPhoto: srPhoto.path.toString(),
          ngcReportPhoto: ngcReportPhoto.path.toString(),
          noOfFamily: noOfFamilyMembersController.text.trim().toString(),
        );
        if (res != null) {
          _isBtnLoader = false;
          _eventCompleted(emit);
          Utils.successSnackBar(msg: res.data!, context: event.context);
          Navigator.pushReplacementNamed(
            event.context,
            RoutesName.home,
          );
        } else {
          _isBtnLoader = false;
          _eventCompleted(emit);
        }
      }
    } catch (e) {
      _isBtnLoader = false;
      log("submit--->${e.toString()}");
      _eventCompleted(emit);
    }
  }

  _eventCompleted(emit) {
    emit(NGCFormDataState(
        userName: userName,
        schema: schema,
        isPageLoader: isPageLoader,
        isBtnLoader: isBtnLoader,
        meterIniReading1Controller: meterIniReading1Controller,
        meterIniReading2Controller: meterIniReading2Controller,
        meterIniReading3Controller: meterIniReading3Controller,
        meterInitialReadingController: meterInitialReadingController,
        meterIniReading1FocusNode: meterIniReading1FocusNode,
        meterIniReading2FocusNode: meterIniReading2FocusNode,
        meterIniReading3FocusNode: meterIniReading3FocusNode,
        isCheckMeterMismatch: isCheckMeterMismatch,
        isMeterReplace: isMeterReplace,
        isRegulator: isRegulator,
        listOfMeterNumber: listOfMeterNumber,
        listOfMeterNumberSerial: listOfMeterNumberSerial,
        meterConnectionMeterController: meterConnectionMeterController,
        regulatorSerialController: regulatorSerialController,
        proposedNgcDateController: proposedNgcDateController,
        listOfMeterNumberId: listOfMeterNumberId,
        listOfRegulator: listOfRegulator,
        listOfRegulatorSerial: listOfRegulatorSerial,
        listOfRegulatorId: listOfRegulatorId,
        regulatorTypeValue: regulatorTypeValue,
        meterTypeValue: meterReplaceTypeValue,
        listOfRegulatorType: listOfRegulatorType,
        listOfMeterType: listOfMeterReplaceType,
        srNumberController: srNumberController,
        meterNumberSerialController: meterNumberSerialController,
        noOfFamilyMembersController: noOfFamilyMembersController,
        ngConversionDateController: ngConversionDateController,
        latOfSRController: latOfSRController,
        longOfSRController: longOfSRController,
        nameContractorController: nameContractorController,
        bpNumberController: bpNumberController,
        reasonMeterChangeController: reasonMeterChangeController,
        noOfBurnersController: noOfBurnersController,
        meterSerialController: meterSerialController,
        mobileNumberController: mobileNumberController,
        altMobileNumberController: altMobileNumberController,
        emailIdController: emailIdController,
        ngChargeDateController: ngConversionDateController,
        typeOfNrController: typeOfNrController,
        dateInstallationController: dateInstallationController,
        delayReasonController: delayReasonController,
        delayReasonValue: delayReasonValue,
        listOfDelayReason: listOfDelayReason,
        meterPhoto: meterPhoto,
        ngcReportPhoto: ngcReportPhoto,
        latOfMRController: latOfMRController,
        longOfMRController: longOfMRController,
        mrPhoto: mrPhoto,
        srPhoto: srPhoto,
        isDelayReason: isDelayReason,
        listOfTypeOfNr: listOfTypeOfNr,
        typeOfNrValue: typeOfNrValue,
        baseUrl: baseUrl,
        lmcPath: lmcPath,
        listOfSRSerial: listOfSRSerial,
      regulatorCheck : regulatorCheck,
      rfcPhoto : rfcPhoto,
      pneumaticPhoto : pneumaticPhoto,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
      rfcDateController: rfcDateController,
    ));
  }
}
