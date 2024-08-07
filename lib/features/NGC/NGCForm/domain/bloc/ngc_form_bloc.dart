
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_event.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_state.dart';
import 'package:lmc/features/NGC/NGCForm/helper/ngc_form_helper.dart';

class NGCFormBloc extends Bloc<NGCFormEvent, NGCFormState> {
  NGCFormBloc() : super(NGCFormInitialState()) {
    on<NGCFormLoadEvent>(_pageLoad);
    on<SelectMeterReplaceEvent>(_selectMeterReplace);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<SelectRegulatorTypeValueEvent>(_selectRegulatorTypeValue);
    on<SelectRegulatorsValueEvent>(_selectRegulatorsValue);
    on<SelectNgcChargeDateEvent>(_selectNgcChargeDate);
    on<SelectProposedNgcConversionDateEvent>(_selectProposedNgcConversionDate);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectLocationOfSREvent>(_selectLocationOfSR);
    on<SelectLocationOfHouseEvent>(_selectLocationOfHouse);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<CaptureGalleryNGCReportEvent>(_captureGalleryNGCReport);
    on<CaptureCameraNGCReportEvent>(_captureCameraNGCReport);
    on<NGCSubmitEvent>(_submit);
  }
  bool isRegulator = false;

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

  String schema = "";
  String dmaUserId = "";
  String isInstall = "";
  String lmcInstallationId = "";
  String workCompletedDate = "";
  String regulatorId = '';
  String materialId = '';

  TextEditingController feasibilityDateController = TextEditingController();
  TextEditingController ngcChargeDateController = TextEditingController();
  TextEditingController rfcDecDateController = TextEditingController();
  TextEditingController proposedNgcConversionDateController = TextEditingController();
  TextEditingController latOfSRController = TextEditingController();
  TextEditingController longOfSRController = TextEditingController();
  TextEditingController latOfHouseController = TextEditingController();
  TextEditingController longOfHouseController = TextEditingController();
  TextEditingController nameContractorController = TextEditingController();
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController meterReaderController = TextEditingController();
  TextEditingController noOfBurnersController = TextEditingController();
  TextEditingController meterNoMismatchController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController altMobileNumberController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController ngChargeDateController = TextEditingController();
  TextEditingController delayReasonController = TextEditingController();
  TextEditingController typeOfNrController = TextEditingController();


  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNumber = [];
  List<String> listOfMeterNumberSerial = [];
  List<String> listOfMeterNumberId = [];

  List<LmcReasonModel> listOfRegulatorType = [];

  List<ListOfMeterNo> listOfRegulator = [];
  List<String> listOfRegulatorSerial = [];
  List<String> listOfRegulatorId = [];



  List<LmcReasonModel> listOfDelayReason = [];


  _pageLoad(NGCFormLoadEvent event, emit) async {
    emit(NGCFormPageLoadState());
    _isPageLoader = false;
    isRegulator = false;
    _isBtnLoader = false;
    isMeterReplace = false;
    isMeterReplacement = false;
    regulatorId = '';
    materialId = '';
    _meterPhoto = File("");
    _ngcReportPhoto = File("");

    listOfMeterNumber = [];
    listOfMeterNumberSerial = [];
    listOfMeterNumberId = [];
    listOfRegulatorType = [];

    listOfRegulator = [];
    listOfRegulatorSerial = [];
    listOfRegulatorId = [];
    delayReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    ngcChargeDateController.text = '';
    latOfSRController.text = await SharedPref.getString(key: PrefsValue.latitudeTf);
    longOfSRController.text = await SharedPref.getString(key: PrefsValue.longitudeTf);
    latOfHouseController.text = await SharedPref.getString(key: PrefsValue.latitudeHg);
    longOfHouseController.text = await SharedPref.getString(key: PrefsValue.longitudeHg);
    rfcDecDateController.text = await SharedPref.getString(key: PrefsValue.rfcDate);
    proposedNgcConversionDateController.text = DateFormat(AppString.dateFormat).format(DateTime.now());
    schema = await SharedPref.getString(key: PrefsValue.schema);
    dmaUserId = await SharedPref.getString(key: PrefsValue.dmaUserId) ?? "";
    isInstall = await SharedPref.getString(key: PrefsValue.isInstall);
    lmcInstallationId = await SharedPref.getString(key: PrefsValue.lmcInstallationId);
    workCompletedDate = await SharedPref.getString(key: PrefsValue.workCompletedDate) ?? "0000:00:00";
    nameContractorController.text = await SharedPref.getString(key: PrefsValue.userName) ?? "";
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber) ?? "0";
    meterReaderController.text = await SharedPref.getString(key: PrefsValue.meterReading) ?? "0";
    meterNoMismatchController.text = await SharedPref.getString(key: PrefsValue.meterSerial) ?? "0";
    mobileNumberController.text =await SharedPref.getString(key: PrefsValue.mobileNumber) ?? "";
    emailIdController.text = await SharedPref.getString(key: PrefsValue.email)??"-";
    altMobileNumberController.text = await SharedPref.getString(key: PrefsValue.alternateMobileNo) ?? "";
    noOfBurnersController.text = await SharedPref.getString(key: PrefsValue.ngOfBurners)  == "" ? "2" : await SharedPref.getString(key: PrefsValue.ngOfBurners);
    ngChargeDateController.text = await SharedPref.getString(key: PrefsValue.ngChargeDate) ?? "";
    delayReasonController.text = await SharedPref.getString(key: PrefsValue.delayReason) ?? "";
    typeOfNrController.text = await SharedPref.getString(key: PrefsValue.typeOfNr) ?? "";
    feasibilityDateController.text = await SharedPref.getString(key: PrefsValue.feasibilityVisitDate);
    await fetchDelayReasonApi(context: event.context);
    await fetchRegulatorTypeApi(context: event.context);
    await fetchMetersApi(context: event.context, meterSerial: "");
    _eventCompleted(emit);
  }

  fetchRegulatorTypeApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.regulatorTypeApi(context: context);
    if (res != null) {
      listOfRegulatorType = res;
      return res;
    }
  }
 _selectMeterReplace(SelectMeterReplaceEvent event,  emit) {
   isMeterReplace = event.meterReplace;
   print(isMeterReplace);
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
    var res = await FormInstallationHelper.getRegulatorsApi(context: context,regulatorSerial: regulatorSerial,regulatorType: regulatorType);
    if (res != null) {
      listOfRegulator = res;
      listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    if(event.regulatorsValue.isNotEmpty){
      await fetchRegulatorsApi(context: event.context, regulatorSerial: event.regulatorsValue, regulatorType : "");
      for(int i = 0; i< listOfRegulator.length; i++){
        listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
        listOfRegulatorId = listOfRegulator.map((e) => e.id!).toList();
        regulatorId = await listOfRegulatorId[i].toString();
      }
    }
    _eventCompleted(emit);
  }

  fetchMetersApi({required BuildContext context, required String meterSerial}) async {
    var res = await NGCFormHelper.getMetersApi(context: context,meterSerial: meterSerial);
    if (res != null) {
      listOfMeterNumber = res;
      listOfMeterNumberSerial = listOfMeterNumber.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    if(event.meterReadingValue.isNotEmpty && event.meterReadingValue.length > 1){
      await fetchMetersApi(context: event.context, meterSerial: event.meterReadingValue);
      for(int i = 0; i< listOfMeterNumber.length; i++){
        listOfMeterNumberSerial = listOfMeterNumber.map((e) => e.serialNumber!).toList();
        listOfMeterNumberId = listOfMeterNumber.map((e) => e.id!).toList();
        materialId = await listOfMeterNumberId[i].toString();
        print("hello---->${materialId}");
      }
    }
    _eventCompleted(emit);
  }

  _selectNgcChargeDate(SelectNgcChargeDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      ngcChargeDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }
  _selectProposedNgcConversionDate(SelectProposedNgcConversionDateEvent event, emit) async {
    var assignDate = DateFormat(AppString.dateFormat).parse(feasibilityDateController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat(AppString.dateFormat).format(dateTime);
      proposedNgcConversionDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }


  _selectDelayReasonValue(SelectDelayReasonValueEvent event, emit) {
    delayReasonValue = event.delayReasonValue;
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

  fetchDelayReasonApi({required BuildContext context}) async {
    var res = await FormInstallationHelper.lmcReasonApi(context: context);
    if (res != null) {
      listOfDelayReason = res;
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


  _submit(NGCSubmitEvent event, emit) async {
    try {
      var validationCheck = await NGCFormHelper.validationSubmit(
        context: event.context,
        meterReading: meterReaderController.text.trim().toString(),
        bpNumber: bpNumberController.text.trim().toString(),
        date: ngChargeDateController.text.trim().toString(),
        delayReason: delayReasonController.text.trim().toString(),
        delayStatusValue: delayReasonValue.toString(),
        meterImg: meterPhoto.path.toString(),
        meterNo: meterNoMismatchController.text.trim().toString(),
        nameContractor: nameContractorController.text.trim().toString(),
        ngcReportImg: ngcReportPhoto.path.toString(),
        noOfBurners: noOfBurnersController.text.trim().toString(),
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
            conversionDate: ngChargeDateController.text.trim().toString(),
            delayStatus: delayReasonValue.name,
            email: emailIdController.text.trim().toString(),
            isInstall: isInstall,
            jmrNo:bpNumberController.text.trim().toString(),
            lmcInstallationId: lmcInstallationId,
            meterFile: meterPhoto,
            meterReading: meterReaderController.text.trim().toString(),
            mismatchMeterNo: meterNoMismatchController.text.trim().toString(),
            nameOfContractor: nameContractorController.text.trim().toString(),
            ngcReportFile: ngcReportPhoto,
            nOfBurners: noOfBurnersController.text.trim().toString(),
            reasonOfDelay: delayReasonController.text.trim().toString(),
            workCompletedDate: workCompletedDate);
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
      isPageLoader : isPageLoader,
      isBtnLoader : isBtnLoader,
      isMeterReplace : isMeterReplace,
      isRegulator : isRegulator,
      listOfMeterNumber: listOfMeterNumber,
      listOfMeterNumberSerial: listOfMeterNumberSerial,
      listOfMeterNumberId: listOfMeterNumberId,
      listOfRegulator: listOfRegulator,
      listOfRegulatorSerial: listOfRegulatorSerial,
      listOfRegulatorId: listOfRegulatorId,
      regulatorTypeValue: regulatorTypeValue,
      listOfRegulatorType: listOfRegulatorType,
      rfcDecDateController : rfcDecDateController,
      ngcChargeDateController : ngcChargeDateController,
      proposedNgcConversionDateController : proposedNgcConversionDateController,
      latOfSRController : latOfSRController,
      longOfSRController : longOfSRController,
     latOfHouseController : latOfHouseController,
      longOfHouseController : longOfHouseController,
      nameContractorController : nameContractorController,
      bpNumberController : bpNumberController,
      meterReaderController : meterReaderController,
      noOfBurnersController : noOfBurnersController,
      meterNoMismatchController : meterNoMismatchController,
      mobileNumberController : mobileNumberController,
      altMobileNumberController : altMobileNumberController,
      emailIdController : emailIdController,
      ngChargeDateController : ngChargeDateController,
      delayReasonController : delayReasonController,
      typeOfNrController : typeOfNrController,
      delayReasonValue :delayReasonValue,
      listOfDelayReason :listOfDelayReason,
      meterPhoto: meterPhoto,
      ngcReportPhoto : ngcReportPhoto,
    ));
  }


}
