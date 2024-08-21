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

class NGCFormBloc extends Bloc<NGCFormEvent, NGCFormState> {
  NGCFormBloc() : super(NGCFormInitialState()) {
    on<NGCFormLoadEvent>(_pageLoad);
    on<SelectNGConversionDateEvent>(_selectNGConversionDate);
    on<SelectTypeNRValueEvent>(_selectTypeNRValue);
    on<SelectMeterReplaceEvent>(_selectMeterReplace);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<SelectRegulatorTypeValueEvent>(_selectRegulatorTypeValue);
    on<SelectRegulatorsValueEvent>(_selectRegulatorsValue);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectDelayStatueValueEvent>(_selectDelayStatueValue);
    on<SelectLocationOfSREvent>(_locationOfSR);
    on<SelectLocationOfMREvent>(_locationOfMR);
    on<SelectMeterTypeValueEvent>(_selectMeterTypeValue);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
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
  bool isDelayReason = false;

  String schema = "";
  String userName = "";
  String dmaUserId = "";
  String isInstall = "";
  String lmcInstallationId = "";
  String regulatorId = '';
  String materialId = '';
  String meterReplace = "0";
  String lmcPath = "";
  String baseUrl = '';
  String networkMeterPhoto = "";
 // String networkMeterPhotoPath = '';

  TextEditingController meterNumberSerialController = TextEditingController();
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
  TextEditingController meterInitialReading = TextEditingController();
  TextEditingController reasonMeterChangeController = TextEditingController();
  TextEditingController noOfBurnersController = TextEditingController();
  TextEditingController meterSerialController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController altMobileNumberController = TextEditingController();
  TextEditingController noOfFamilyMembersController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController delayReasonController = TextEditingController();
  TextEditingController typeOfNrController = TextEditingController();
  TextEditingController dateInstallationController = TextEditingController();


  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();
  LmcReasonModel meterReplaceTypeValue = LmcReasonModel();
  LmcReasonModel delayStatusValue = LmcReasonModel();
  LmcReasonModel ngcDelayStatusValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNumber = [];
  List<String> listOfMeterNumberSerial = [];
  List<String> listOfMeterNumberId = [];

  List<LmcReasonModel> listOfRegulatorType = [];

  List<ListOfMeterNo> listOfRegulator = [];
  List<String> listOfRegulatorSerial = [];
  List<String> listOfRegulatorId = [];

  List<GetConstantModel> listOfTypeOfNr = [];
  GetConstantModel typeOfNrValue = GetConstantModel();



  List<LmcReasonModel> listOfDelayReason = [];
  List<LmcReasonModel> listOfMeterReplaceType = [];
  List<LmcReasonModel> listOfDelayStatus = [];
  List<LmcReasonModel> listOfNgcDelayStatus = [];


  _pageLoad(NGCFormLoadEvent event, emit) async {
    emit(NGCFormPageLoadState());
    _isPageLoader = false;
    isRegulator = false;
    _isBtnLoader = false;
    isMeterReplace = false;
    isMeterReplacement = false;
    isCheckMeterMismatch = false;
    isCheckRegulatorMismatch = false;
    regulatorId = '';
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
    listOfRegulatorId = [];

    listOfDelayReason = [];
    listOfMeterReplaceType = [];
    listOfDelayStatus = [];
    listOfNgcDelayStatus = [];
    delayReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    meterReplaceTypeValue = LmcReasonModel();
    delayStatusValue = LmcReasonModel();
    ngcDelayStatusValue = LmcReasonModel();
    reasonMeterChangeController.text = '';
    meterNumberSerialController.text = '';
    regulatorSerialController.text = '';
    schema = await SharedPref.getString(key: PrefsValue.schema);
    userName = await SharedPref.getString(key: PrefsValue.userName);
    latOfSRController.text = "0";
    longOfSRController.text = "0";
    latOfMRController.text = "0";
    longOfMRController.text = "0";
    typeOfNrValue.value = await SharedPref.getString(key: PrefsValue.typeOfNr.isEmpty ? "":PrefsValue.typeOfNr);
    regulatorTypeValue.name = await SharedPref.getString(key: PrefsValue.regulatorType.isEmpty ? "" :PrefsValue.regulatorType);
    regulatorTypeValue.id = await SharedPref.getString(key: PrefsValue.regulatorTypeId.isEmpty ? "": PrefsValue.regulatorTypeId);
    regulatorSerialController.text = await SharedPref.getString(key: PrefsValue.regulatorSerial);
    regulatorId = await SharedPref.getString(key: PrefsValue.regulators);
    srNumberController.text = await SharedPref.getString(key: PrefsValue.srNumber);
    lmcPath = await SharedPref.getString(key: PrefsValue.lmcPath);
    baseUrl = await SharedPref.getString(key: PrefsValue.baseUrl);
    networkMeterPhoto = await SharedPref.getString(key: PrefsValue.meterPhoto);
    _meterPhoto = File(baseUrl+"uploads/"+lmcPath+"/" +networkMeterPhoto.toString());
    dmaUserId = await SharedPref.getString(key: PrefsValue.dmaUserId) ?? "";
    isInstall = await SharedPref.getString(key: PrefsValue.isInstall);
    lmcInstallationId = await SharedPref.getString(key: PrefsValue.lmcInstallationId);
    nameContractorController.text = await SharedPref.getString(key: PrefsValue.userName) ?? "";
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber) ?? "0";
    meterInitialReading.text = await SharedPref.getString(key: PrefsValue.meterReading) ?? "0";
    meterSerialController.text = await SharedPref.getString(key: PrefsValue.meterSerial) ?? "0";
    mobileNumberController.text =await SharedPref.getString(key: PrefsValue.mobileNumber) ?? "";
    emailIdController.text = await SharedPref.getString(key: PrefsValue.email)??"-";
    altMobileNumberController.text = await SharedPref.getString(key: PrefsValue.alternateMobileNo) ?? "";
    noOfFamilyMembersController.text = await SharedPref.getString(key: PrefsValue.noOfFamilyMembers) ?? "";
    noOfBurnersController.text = await SharedPref.getString(key: PrefsValue.ngOfBurners)  == "" ? "2" : await SharedPref.getString(key: PrefsValue.ngOfBurners);
    typeOfNrController.text = await SharedPref.getString(key: PrefsValue.typeOfNr) ?? "";
    dateInstallationController.text = await SharedPref.getString(key: PrefsValue.lmcInstallationDate) ?? "";
    ngConversionDateController.text =  DateFormat(AppString.dateFormat).format(DateTime.now());
    await fetchDelayReasonApi(context: event.context);
    await fetchTypeOfNrApi(context: event.context);
    await fetchNgcReasonApi(context: event.context);
    await fetchMeterReplaceTypeApi(context: event.context);
    await fetchRegulatorTypeApi(context: event.context);
    await fetchMetersApi(context: event.context, meterSerial: "");
    await checkDelayReason();
    if(regulatorTypeValue.id != null){
      await fetchRegulatorsApi(context: event.context,regulatorSerial: "", regulatorType : regulatorTypeValue.id.toString());
    }
   _eventCompleted(emit);
  }

  checkDelayReason(){
    DateTime  proposedDate = DateFormat(AppString.dateFormat).parse(ngConversionDateController.text);
    DateTime  installationDate = DateFormat(AppString.dateFormat).parse(dateInstallationController.text);
    if (installationDate.compareTo(proposedDate) <= 0 ) {
      isDelayReason = false;
    } else {
      isDelayReason = true;
    }
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
  _selectMeterReplace(SelectMeterReplaceEvent event,  emit) {
    isMeterReplace = event.meterReplace;
    if(event.meterReplace == true){
      meterReplace = "1";
      print("meterReplace-->${meterReplace}");
    }else{
      meterReplace = "0";
      print("meterReplace-->${meterReplace}");
    }
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

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    var res = await NGCFormHelper.getRegulatorsNGCApi(context: context,regulatorSerial: regulatorSerial,regulatorType: regulatorType);
    if (res != null) {
      listOfRegulator = res;
      listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  fetchMetersApi({required BuildContext context, required String meterSerial}) async {
    var res = await NGCFormHelper.getMetersNGCApi(context: context, meterSerial: meterSerial);
    if (res != null) {
      listOfMeterNumber = res;
      listOfMeterNumberSerial = listOfMeterNumber.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    meterNumberSerialController.text = event.meterReadingValue;
    materialId = listOfMeterNumber.firstWhereOrNull((element) => element.serialNumber == event.meterReadingValue)?.id ?? "";
    if(event.meterReadingValue.isNotEmpty && !listOfMeterNumberSerial.contains(event.meterReadingValue)) {
      isCheckMeterMismatch = true;
    }else{
      isCheckMeterMismatch = false;
    }
    _eventCompleted(emit); }

  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    regulatorSerialController.text = event.regulatorsValue;
    regulatorId = listOfRegulator.firstWhereOrNull((element) => element.serialNumber == event.regulatorsValue)?.id ?? "";
    if(event.regulatorsValue.isNotEmpty && !listOfRegulatorSerial.contains(event.regulatorsValue)) {
      isCheckRegulatorMismatch = true;
    }else{
      isCheckRegulatorMismatch = false;
    }
    _eventCompleted(emit);
  }

  _selectNGConversionDate(SelectNGConversionDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(dateInstallationController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      ngConversionDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectDelayReasonValue(SelectDelayReasonValueEvent event, emit) {
    delayReasonValue = event.delayReasonValue;
    _eventCompleted(emit);
  }
  _selectDelayStatueValue(SelectDelayStatueValueEvent event, emit) {
    delayStatusValue = event.delayStatueValue;
    _eventCompleted(emit);
  }


  _selectMeterTypeValue(SelectMeterTypeValueEvent event, emit) {
    meterReplaceTypeValue = event.meterTypeValue;
    _eventCompleted(emit);
  }

  fetchDelayReasonApi({required BuildContext context}) async {
    var res = await NGCFormHelper.lmcReasonApi(context: context);
    if (res != null) {
      listOfDelayReason = res;
      return res;
    }
  }
  fetchNgcReasonApi({required BuildContext context}) async {
    var res = await NGCFormHelper.ngcReasonApi(context: context);
    if (res != null) {
      listOfNgcDelayStatus = res;
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
      _eventCompleted(emit);;
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
        meterInitialReading: meterInitialReading.text.trim().toString(),
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
        bpNumber: bpNumberController.text.trim().toString(),
        ngChargeDate: ngConversionDateController.text.trim().toString(),
        meterImg: meterPhoto,
        nameContractor: nameContractorController.text.trim().toString(),
        ngcDelayStatusValue: ngcDelayStatusValue,
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
          comment: delayReasonController.text.trim().toString(),
          contactPerson: mobileNumberController.text.trim().toString(),
          conversionDate: ngConversionDateController.text.trim().toString(),
          delayStatus: ngcDelayStatusValue,
          email: emailIdController.text.trim().toString(),
          isInstall: isInstall,
          jmrNo:bpNumberController.text.trim().toString(),
          lmcInstallationId: lmcInstallationId.toString(),
          meterReading: meterInitialReading.text.trim().toString(),
          mismatchMeterNo:isMeterReplace == true ? materialId : meterSerialController.text.trim().toString(),
          meterNumber: isMeterReplace == true ? materialId : meterSerialController.text.trim().toString(),
          nameOfContractor: nameContractorController.text.trim().toString(),
          nOfBurners: noOfBurnersController.text.trim().toString(),
          reasonOfDelay: delayReasonController.text.trim().toString(),
          workCompletedDate: dateInstallationController.text.trim().toString(),
          meterChangeReason: reasonMeterChangeController.text.trim().toString(),
          regulatorsNumber: regulatorId.toString(),
          mrRegulatorId: regulatorId.toString(),
          regulatorTypeId: regulatorTypeValue,
          replaceMeter: meterReplace.toString(),
          changeMeterType: meterReplaceTypeValue,
          srNumber: srNumberController.text.trim().toString(),
          latitudeMR: latOfMRController.text.trim().toString(),
          longitudeMR: longOfMRController.text.trim().toString(),
          latitudeTf: latOfSRController.text.trim().toString(),
          longitudeTf: longOfSRController.text.trim().toString(),
          meterPhoto:   meterPhoto.path.toString(),
          mrPhoto: mrPhoto.path.toString(),
          srPhoto: srPhoto.path.toString(),
          ngcReportPhoto: ngcReportPhoto.path.toString(),
          noOfFamily: noOfFamilyMembersController.text.trim().toString(),
        );
        if (res != null ) {
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
      userName : userName,
      schema : schema,
      isPageLoader : isPageLoader,
      isBtnLoader : isBtnLoader,
      isCheckMeterMismatch : isCheckMeterMismatch,
      isMeterReplace : isMeterReplace,
      isRegulator : isRegulator,
      listOfMeterNumber: listOfMeterNumber,
      listOfMeterNumberSerial: listOfMeterNumberSerial,
      regulatorSerialController: regulatorSerialController,
      listOfMeterNumberId: listOfMeterNumberId,
      listOfRegulator: listOfRegulator,
      listOfRegulatorSerial: listOfRegulatorSerial,
      listOfRegulatorId: listOfRegulatorId,
      regulatorTypeValue: regulatorTypeValue,
      meterTypeValue: meterReplaceTypeValue,
      delayStatusValue: delayStatusValue,
      ngcDelayStatusValue: ngcDelayStatusValue,
      listOfRegulatorType: listOfRegulatorType,
      listOfMeterType: listOfMeterReplaceType,
      listOfDelayStatus: listOfDelayStatus,
      listOfNgcDelayStatus: listOfNgcDelayStatus,
      srNumberController : srNumberController,
      meterNumberSerialController : meterNumberSerialController,
      noOfFamilyMembersController : noOfFamilyMembersController,
      ngConversionDateController : ngConversionDateController,
      latOfSRController : latOfSRController,
      longOfSRController : longOfSRController,
      nameContractorController : nameContractorController,
      bpNumberController : bpNumberController,
      meterInitialReading : meterInitialReading,
      reasonMeterChangeController : reasonMeterChangeController,
      noOfBurnersController : noOfBurnersController,
      meterSerialController : meterSerialController,
      mobileNumberController : mobileNumberController,
      altMobileNumberController : altMobileNumberController,
      emailIdController : emailIdController,
      ngChargeDateController : ngConversionDateController,
      typeOfNrController : typeOfNrController,
      dateInstallationController : dateInstallationController,
      delayReasonValue :delayReasonValue,
      listOfDelayReason :listOfDelayReason,
      meterPhoto: meterPhoto,
      ngcReportPhoto : ngcReportPhoto,
      latOfMRController: latOfMRController,
      longOfMRController: longOfMRController,
      mrPhoto: mrPhoto,
      srPhoto: srPhoto,
      isDelayReason: isDelayReason,
      listOfTypeOfNr: listOfTypeOfNr,
      typeOfNrValue: typeOfNrValue,
      baseUrl: baseUrl,
      lmcPath: lmcPath,
    ));
  }


}
