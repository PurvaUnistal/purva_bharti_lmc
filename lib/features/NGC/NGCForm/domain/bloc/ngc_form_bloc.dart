import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/res/singleton.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/Installation/FormInstallation/helper/form_installation_helper.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_event.dart';
import 'package:lmc/features/NGC/NGCForm/domain/bloc/ngc_form_state.dart';
import 'package:lmc/features/NGC/NGCForm/helper/ngc_form_helper.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';
import 'package:permission_handler/permission_handler.dart';

class NGCFormBloc extends Bloc<NGCFormEvent, NGCFormState> {
  NGCFormBloc() : super(NGCFormInitialState()) {
    on<NGCFormLoadEvent>(_pageLoad);
    on<SelectNGConversionDateEvent>(_selectNGConversionDate);
    on<MeterInitReadingEvent>(_meterInitReading);
    on<SelectTypeNRValueEvent>(_selectTypeNRValue);
    on<SelectMeterReplaceEvent>(_selectMeterReplace);
    on<SelectRegularReplaceEvent>(_selectRegularReplace);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<SelectRegulatorTypeValueEvent>(_selectRegulatorTypeValue);
    on<SelectRegulatorsValueEvent>(_selectRegulatorsValue);
    on<SelectMRegulatorsEvent>(_selectMRegulators);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectLocationOfSREvent>(_locationOfSR);
    on<SelectLocationOfMREvent>(_locationOfMR);
    on<SelectMeterTypeValueEvent>(_selectMeterTypeValue);
    on<SelectRegulatorTypeReasonValueEvent>(_selectRegulatorTypeReasonValue);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<CaptureGalleryPneumaticEvent>(_captureGalleryPneumatic);
    on<CaptureCameraPneumaticEvent>(_captureCameraPneumatic);
    on<CaptureGalleryRfcEvent>(_captureGalleryRfc);
    on<CaptureCameraRfcEvent>(_captureCameraRfc);
    on<CaptureCameraMREvent>(_captureCameraMR);
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
  bool isRegularReplace = false;
  bool isCheckMeterMismatch = false;
  bool isCheckRegulatorMismatch = false;
  bool isCheckMR = false;
  bool isDelayReason = false;
  bool isSRLatLong = false;
  bool isMRLatLong = false;


  String dmaUserId = "";
  String isInstall = "";
  String lmcInstallationId = "";
  String regulatorId = '';
  String mrRegulatorId = '';
  String materialId = '';
  String meterReplace = "0";
  String lmcPath = "";
  String baseUrl = '';
  String networkMeterPhoto = "";
  String networkRfcPhoto = "";
  String networkPneumaticPhoto = "";
  String regulatorCheck = "";


  InstallationByNgcData  ngcData = InstallationByNgcData();
  TextEditingController meterIniReading1Controller = TextEditingController();
  TextEditingController meterIniReading2Controller = TextEditingController();
  TextEditingController meterIniReading3Controller = TextEditingController();
  TextEditingController meterInitialReadingController = TextEditingController();
  TextEditingController meterNumberSerialController = TextEditingController();
  TextEditingController meterConnectionMeterController =
      TextEditingController();
  TextEditingController regulatorSerialSearchController =
      TextEditingController();
  TextEditingController regulatorSerialController = TextEditingController();
  TextEditingController mrNumberSearchController = TextEditingController();
  TextEditingController mrSerialNumberController = TextEditingController();
  TextEditingController delayForReasonController = TextEditingController();
  TextEditingController ngConversionDateController = TextEditingController();
  TextEditingController latOfSRController = TextEditingController();
  TextEditingController longOfSRController = TextEditingController();
  TextEditingController latOfMRController = TextEditingController();
  TextEditingController longOfMRController = TextEditingController();
  TextEditingController nameContractorController = TextEditingController();
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController reasonMeterChangeController = TextEditingController();
  TextEditingController reasonRegulatorChangeController =
      TextEditingController();
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
  TextEditingController regulatorTypeController = TextEditingController();

  FocusNode meterIniReading1FocusNode = FocusNode();
  FocusNode meterIniReading2FocusNode = FocusNode();
  FocusNode meterIniReading3FocusNode = FocusNode();

  LmcReasonModel delayReasonValue = LmcReasonModel();
  LmcReasonModel regulatorTypeValue = LmcReasonModel();
  LmcReasonModel meterReplaceTypeValue = LmcReasonModel();
  LmcReasonModel regulatorTypeReasonValue = LmcReasonModel();

  List<ListOfMeterNo> listOfMeterNumber = [];
  List<String> listOfMeterNumberSerial = [];
  List<String> listOfMeterNumberId = [];

  List<LmcReasonModel> listOfRegulatorType = [];

  List<ListOfMeterNo> listOfRegulator = [];
  List<ListOfMeterNo> listOfMR = [];
  List<String> listOfRegulatorSerial = [];
  List<String> listOfRegulatorId = [];

  List<String> listOfMRSerial = [];

  List<GetConstantModel> listOfTypeOfNr = [];
  GetConstantModel typeOfNrValue = GetConstantModel();

  List<LmcReasonModel> listOfDelayReason = [];
  List<LmcReasonModel> listOfNgcDelayStatus = [];
  List<LmcReasonModel> listOfMeterReplaceType = [];
  List<LmcReasonModel> listOfRegulatorTypeReason = [];
  static BuildContext? context = Singleton.instanceInit()?.context;


  static var ctx = UserContext.getUserContext();

  _pageLoad(NGCFormLoadEvent event, emit) async {
    emit(NGCFormPageLoadState());
    _isPageLoader = false;
    isRegulator = false;
    _isBtnLoader = false;
    isMeterReplace = false;
    isRegularReplace = false;
    isMeterReplacement = false;
    isCheckMeterMismatch = false;
    isCheckRegulatorMismatch = false;
    isCheckMR = false;
    isSRLatLong = false;
    isMRLatLong = false;
    regulatorId = '';
    mrRegulatorId = '';
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
    listOfMR = [];
    listOfRegulatorSerial = [];
    listOfMRSerial = [];
    listOfRegulatorId = [];
    listOfDelayReason = [];
    listOfMeterReplaceType = [];
    listOfRegulatorTypeReason = [];
    delayReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    meterReplaceTypeValue = LmcReasonModel();
    regulatorTypeReasonValue = LmcReasonModel();
    reasonMeterChangeController.text = '';
    reasonRegulatorChangeController.text = '';
    meterNumberSerialController.text = '';
    regulatorSerialSearchController.text = '';
    regulatorSerialController.text = '';
    delayReasonController.text = '';
    meterIniReading1Controller.text = "";
    meterIniReading2Controller.text = "";
    meterIniReading3Controller.text = "";
    meterInitialReadingController.text = "";
    regulatorTypeController.text = "";
    meterIniReading1FocusNode = FocusNode();
    meterIniReading2FocusNode = FocusNode();
    meterIniReading3FocusNode = FocusNode();

    latOfSRController.text = "0";
    longOfSRController.text = "0";
    latOfMRController.text = "0";
    longOfMRController.text = "0";
    ctx = UserContext.getUserContext();
    ngcData = await AppConfig.instanceInit()!.ngcData;
    meterConnectionMeterController.text = await ngcData.typeOfNr ?? "";

    regulatorTypeController.text = await ngcData.regulatorType ?? "";
    regulatorTypeValue.id =  await ngcData.regulatorTypeId ?? "";
    mrRegulatorId = await ngcData.mrRegulatorId ?? "";
    mrSerialNumberController.text = await ngcData.mrRegulatorSerial ?? "";
    
    regulatorId = await ngcData.regulators ?? "";
    regulatorSerialController.text =  await ngcData.regulatorSerial ?? "";
    lmcPath = await ngcData.lmcpath ?? "";
    baseUrl = EnvironmentConfig.of(context!)!.imageBaseURL;
    String pathKye = "public/uploads/";

    networkMeterPhoto = await ngcData.meterPhoto ?? "";
    networkPneumaticPhoto = await ngcData.pneumaticImage ?? "";


    networkRfcPhoto = await ngcData.rfcForm ?? "";

    regulatorCheck = await ngcData.regulatorCheck ?? "";
    _meterPhoto = File(baseUrl + pathKye + lmcPath + "/" + networkMeterPhoto.toString());
    rfcPhoto = File(baseUrl + pathKye + lmcPath + "/" + networkRfcPhoto.toString());
    pneumaticPhoto = File(baseUrl + pathKye + lmcPath + "/" + networkPneumaticPhoto.toString());

    dmaUserId = await ngcData.dmaUserId ?? "";

    isInstall = await ngcData.isInstall ?? "";

    lmcInstallationId = await ngcData.lmcInstallationId ?? "";

    bpNumberController.text = await ngcData.bpNumber ?? "0";

    meterInitialReadingController.text = await ngcData.meterreading ?? "0";

    if (meterInitialReadingController.text.length == 5) {
      List<String> meterNumberStringArrayValues =
          (meterInitialReadingController.text ?? "0.000").split("");
      int length = meterNumberStringArrayValues.length;
      meterIniReading1Controller.text =
          meterNumberStringArrayValues[length - 3];
      meterIniReading2Controller.text =
          meterNumberStringArrayValues[length - 2];
      meterIniReading3Controller.text =
          meterNumberStringArrayValues[length - 1];
    } else if (meterInitialReadingController.text == "0") {
      meterIniReading1Controller.text = "0";
      meterIniReading2Controller.text = "0";
      meterIniReading3Controller.text = "0";
    } else {
      double meterIniReadingAdd =
          double.parse(meterInitialReadingController.text);
      String newMeterInitialReading = (meterIniReadingAdd * 1000).toString();
      List<String> meterNumberStringArrayValues =
          (newMeterInitialReading.trim().split("")).toList();
      meterIniReading1Controller.text = meterNumberStringArrayValues[0];
      meterIniReading2Controller.text = meterNumberStringArrayValues[1];
      meterIniReading3Controller.text = meterNumberStringArrayValues[2];
    }
    materialId = await ngcData.meterNumber ?? "";

    meterSerialController.text = await ngcData.meterSerial ?? "";

    mobileNumberController.text = await ngcData.mobileNumber ?? "";

    emailIdController.text = await ngcData.email ?? "";

    altMobileNumberController.text = await ngcData.alternateMobile ?? "";

    noOfFamilyMembersController.text = await ngcData.noOfFamilyMembers.isEmpty ? "" :ngcData.noOfFamilyMembers;

    noOfBurnersController.text =  await ngcData.ngOfBurners.isEmpty ? "2" : ngcData.ngOfBurners;

    typeOfNrController.text =  await ngcData.typeOfNr ?? "";

    dateInstallationController.text =  await ngcData.lmcInstallationDate ?? "";

    proposedNgcDateController.text =  await ngcData.lmcProposedNgcDate ?? "";

    extraPipeController.text =  await ngcData.extraPipe ?? "";

    extraPriceController.text =  await ngcData.extraPrice ?? "";

    rfcDateController.text = await ngcData.rfcDate ?? "";

    ngConversionDateController.text =
        DateFormat(AppString.dateFormat).format(DateTime.now());
    Future.wait(<Future>[
      fetchTypeOfNrApi(context: event.context),
      fetchMeterReplaceTypeApi(context: event.context),
      fetchRegulatorTypeApi(context: event.context),
      fetchMetersApi(context: event.context, meterSerial: ""),
    ]);
    await checkDelayReason();
    await  fetchNgcReasonApi(context: event.context);
    /* if (regulatorTypeValue.id != null) {
      await fetchRegulatorsApi(context: event.context, regulatorSerial: "", regulatorType: regulatorTypeValue.id.toString());
    }*/
    await fetchMRApi(
      context: event.context,
      regulatorSerial: "",
      regulatorType: regulatorTypeValue.id ?? "",
    );
    await fetchRegulatorsApi(
      context: event.context,
      regulatorSerial: "",
      regulatorType: regulatorTypeValue.id ?? "",
    );
    _eventCompleted(emit);
  }

  checkDelayReason() {
    DateTime proposedDate =
        DateFormat(AppString.dateFormat).parse(proposedNgcDateController.text);
    DateTime installationDate =
        DateFormat(AppString.dateFormat).parse(dateInstallationController.text);
    if (installationDate.compareTo(proposedDate) <= 0) {
      isDelayReason = false;
    } else {
      isDelayReason = true;
    }
  }

  _selectNGConversionDate(SelectNGConversionDateEvent event, emit) async {
    var assignDate =
        DateFormat(AppString.dateFormat).parse(dateInstallationController.text);
    DateTime? dateTime = await showDatePicker(
        context: event.context,
        initialDate: DateTime.now(),
        firstDate: assignDate,
        lastDate: DateTime.now());
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
    double meterIniReadingAdd =
        double.parse(meterIniReading1 + meterIniReading2 + meterIniReading3);
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
    meterReplace = event.meterReplace ? "1" : "0";
    print("meterReplace --> $meterReplace");
    _eventCompleted(emit);
  }

  _selectRegularReplace(SelectRegularReplaceEvent event, emit) async {
    srPhoto = File("");
    mrPhoto = File("");
    latOfMRController.text = "";
    longOfMRController.text = "";
    latOfSRController.text = "";
    longOfSRController.text = "";
    reasonRegulatorChangeController.text = "";
    regulatorTypeReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    isRegularReplace = event.regularReplace;
    if (!isRegularReplace) {
      regulatorTypeController.text = await ngcData.regulatorType ?? "";
      regulatorTypeValue.id =  await ngcData.regulatorTypeId ?? "";
    }
    _eventCompleted(emit);
  }

  _selectRegulatorTypeValue(SelectRegulatorTypeValueEvent event, emit) async {
    srPhoto = File("");
    mrPhoto = File("");
    latOfMRController.text = "";
    longOfMRController.text = "";
    latOfSRController.text = "";
    longOfSRController.text = "";
    reasonRegulatorChangeController.text = "";
    regulatorTypeReasonValue = LmcReasonModel();
    regulatorTypeValue = LmcReasonModel();
    isRegulator = true;
    _eventCompleted(emit);
    regulatorTypeValue = event.regulatorTypeValue;
    if (event.regulatorTypeValue.name != null) {
      regulatorSerialSearchController.text = "";
      mrNumberSearchController.text = "";
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
    }
    isRegulator = false;
    _eventCompleted(emit);
  }

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    if (ctx.user.role == "ngc") {
      var res = await NGCFormHelper.getRegulatorsNGCApi(
          context: context,
          regulatorSerial: regulatorSerial,
          regulatorType: regulatorType);
      if (res != null) {
        listOfRegulator = res;
        listOfRegulatorSerial = listOfRegulator.map((e) => e.serialNumber!).toList();
        return res;
      }
    } else if (ctx.user.role == "lmc") {
      var res = await FormInstallationHelper.getRegulatorsApi(
          context: context,
          regulatorSerial: regulatorSerial,
          regulatorType: regulatorType);
      if (res != null) {
        listOfRegulator = res;
        listOfRegulatorSerial =
            listOfRegulator.map((e) => e.serialNumber!).toList();
        return res;
      }
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
  fetchMetersApi(
      {required BuildContext context, required String meterSerial}) async {
    if (ctx.user.role == "ngc") {
      var res = await NGCFormHelper.getMetersNGCApi(
          context: context, meterSerial: meterSerial);
      if (res != null) {
        listOfMeterNumber = res;
        listOfMeterNumberSerial =
            listOfMeterNumber.map((e) => e.serialNumber!).toList();
        return res;
      }
    } else if (ctx.user.role == "lmc") {
      var res = await FormInstallationHelper.getMetersApi(
          context: context, meterSerial: meterSerial);
      if (res != null) {
        listOfMeterNumber = res;
        listOfMeterNumberSerial =
            listOfMeterNumber.map((e) => e.serialNumber!).toList();
        return res;
      }
    }
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    materialId = "";
    meterConnectionMeterController.text = "";
    meterNumberSerialController.text = event.meterReadingValue;
    materialId = listOfMeterNumber
            .firstWhereOrNull(
                (element) => element.serialNumber == event.meterReadingValue)
            ?.id ??
        "";
    meterConnectionMeterController.text = listOfMeterNumber
            .firstWhereOrNull(
                (element) => element.serialNumber == event.meterReadingValue)
            ?.meterConnection ??
        "";
    if (event.meterReadingValue.isNotEmpty &&
        !listOfMeterNumberSerial.contains(event.meterReadingValue)) {
      isCheckMeterMismatch = true;
    } else {
      isCheckMeterMismatch = false;
    }
    _eventCompleted(emit);
  }

  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    regulatorSerialSearchController.text = event.regulatorsValue;
    regulatorId = listOfRegulator.firstWhereOrNull((element) => element.serialNumber == event.regulatorsValue)?.id ??"";
    if (event.regulatorsValue.isNotEmpty && !listOfRegulatorSerial.contains(event.regulatorsValue)) {
      isCheckRegulatorMismatch = true;
    } else {
      isCheckRegulatorMismatch = false;
    }
    _eventCompleted(emit);
  }

  _selectMRegulators(SelectMRegulatorsEvent event, emit) async {
    mrNumberSearchController.text = event.mRegulators;
    mrRegulatorId = listOfMR.firstWhereOrNull((element) => element.serialNumber == event.mRegulators)?.id ?? "";
    if (event.mRegulators.isNotEmpty &&
        !listOfRegulatorSerial.contains(event.mRegulators)) {
      isCheckMR = true;
    } else {
      isCheckMR = false;
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

  _selectRegulatorTypeReasonValue(
      SelectRegulatorTypeReasonValueEvent event, emit) {
    regulatorTypeReasonValue = event.regulatorTypeReasonValue;
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
      listOfRegulatorTypeReason = listOfMeterReplaceType;
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

  _setSRLocation({required BuildContext context}) async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    if (await Permission.location.isGranted) {
      var getLocation = await FormInstallationHelper.getCurrentLocation();
      latOfSRController =
          TextEditingController(text: getLocation?.latitude.toString());
      longOfSRController =
          TextEditingController(text: getLocation?.longitude.toString());
      return getLocation;
    } else {
      Utils.errorSnackBar(msg: "Location permission denied", context: context);
    }
  }


  _setMRLocation({required BuildContext context}) async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    if (await Permission.location.isGranted) {
      var getLocation = await FormInstallationHelper.getCurrentLocation();
      latOfMRController =
          TextEditingController(text: getLocation?.latitude.toString());
      longOfMRController =
          TextEditingController(text: getLocation?.longitude.toString());
      return getLocation;
    } else {
      Utils.errorSnackBar(msg: "Location permission denied", context: context);
    }
  }

  _locationOfSR(SelectLocationOfSREvent event, emit) async {
    await _setSRLocation(context: event.context);
    _eventCompleted(emit);
  }

  _locationOfMR(SelectLocationOfMREvent event, emit) async {
    await _setMRLocation(context: event.context);
    _eventCompleted(emit);
  }


  _captureCameraMR(CaptureCameraMREvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      mrPhoto = photoPath;
      isMRLatLong = true;
      _eventCompleted(emit);
      await  _setMRLocation(context: event.context);
      isMRLatLong = false;
      _eventCompleted(emit);
    }
  }



  _captureCameraSR(CaptureCameraSREvent event, emit) async {
    var photoPath = await FormInstallationHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      srPhoto = photoPath;
      isSRLatLong = true;
      _eventCompleted(emit);
      await _setSRLocation(context: event.context);
      isSRLatLong = false;
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
        meterNumber: isMeterReplace == true
            ? meterNumberSerialController.text.trim()
            : meterSerialController.text.trim().toString(),
        changeMeterType:
        meterReplace == "1" ? meterReplaceTypeValue.id.toString() : "",
        meterInitialReading: meterInitialReadingController.text.trim().toString(),
        isCheckRegulatorMismatch: isCheckRegulatorMismatch,
        regulatorType: regulatorTypeValue.id.toString(),
        regulatorId: regulatorSerialSearchController.text.trim().toString(),
        mrPhoto: mrPhoto.path,
        srPhoto: srPhoto.path,
        latMR: latOfMRController.text.trim().toString(),
        longMR: longOfMRController.text.trim().toString(),
        latSR: latOfSRController.text.trim().toString(),
        longSR: longOfSRController.text.trim().toString(),
        regulatorNumber: isRegularReplace == false
            ? regulatorSerialController.text.trim().toString()
            : regulatorSerialSearchController.text.trim().toString(),
        mrNumber: isRegularReplace == false
            ? mrSerialNumberController.text.trim().toString()
            : mrNumberSearchController.text.trim().toString(),
        isCheckMR: isCheckMR,
        bpNumber: bpNumberController.text.trim().toString(),
        ngChargeDate: ngConversionDateController.text.trim().toString(),
        meterImg: meterPhoto,
        nameContractor: nameContractorController.text.trim().toString(),
        noOfBurners: noOfBurnersController.text.trim().toString(),
        noOfFamily: noOfFamilyMembersController.text.trim().toString(),
        phoneNo: mobileNumberController.text.trim().toString(),
        changeRegulatorType: isRegularReplace == false
            ? ""
            : regulatorTypeReasonValue.id.toString(),
      );
      if (await validationCheck == true) {
        print("DONE=========================");
        _isBtnLoader = true;
        _eventCompleted(emit);
        var res = await NGCFormHelper.setNGCReportData(
          context: event.context,
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
          nameOfContractor: nameContractorController.text.trim().toString(),
          nOfBurners: noOfBurnersController.text.trim().toString(),
          delayReasonValue: delayReasonValue.name == null ? "" : delayReasonValue.name.toString(),
          reasonOfDelay: delayReasonController.text.trim().toString(),
          workCompletedDate: dateInstallationController.text.trim().toString(),
          replaceMeter: meterReplace.toString(),
          changeMeterType: meterReplaceTypeValue,
          meterChangeReason: meterReplaceTypeValue.id.toString(),
          meterChangeRemark: reasonMeterChangeController.text.trim().toString(),
          regulatorChangeReason: regulatorTypeReasonValue.id.toString(),
          regulatorChangeRemark: reasonRegulatorChangeController.text.trim().toString(),
          regulatorTypeId: regulatorTypeValue,
          tfNumber: await ngcData.tfNumber.toString(),
          mrRegulatorId: mrRegulatorId.isEmpty ? ngcData.mrRegulatorId : mrRegulatorId.toString(),
          regulatorId: regulatorId.toString(),
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
      isRegularReplace: isRegularReplace,
      isRegulator: isRegulator,

      listOfMeterNumber: listOfMeterNumber,
      listOfMeterNumberSerial: listOfMeterNumberSerial,
      meterConnectionMeterController: meterConnectionMeterController,
      regulatorSerialSearchController: regulatorSerialSearchController,
      regulatorSerialController: regulatorSerialController,
      proposedNgcDateController: proposedNgcDateController,
      listOfMeterNumberId: listOfMeterNumberId,
      listOfRegulatorSerial: listOfRegulatorSerial,
      listOfRegulatorId: listOfRegulatorId,
      regulatorTypeValue: regulatorTypeValue,
      meterTypeValue: meterReplaceTypeValue,
      regulatorTypeReasonValue: regulatorTypeReasonValue,
      listOfRegulatorType: listOfRegulatorType,
      listOfMeterType: listOfMeterReplaceType,
      listOfRegulatorTypeReason: listOfRegulatorTypeReason,
      mrNumberSearchController: mrNumberSearchController,
      mrSerialNumberController: mrSerialNumberController,
      meterNumberSerialController: meterNumberSerialController,
      noOfFamilyMembersController: noOfFamilyMembersController,
      ngConversionDateController: ngConversionDateController,
      latOfSRController: latOfSRController,
      longOfSRController: longOfSRController,
      nameContractorController: nameContractorController,
      bpNumberController: bpNumberController,
      reasonMeterChangeController: reasonMeterChangeController,
      reasonRegulatorChangeController: reasonRegulatorChangeController,
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
      isSRLatLong: isSRLatLong,
      isMRLatLong: isMRLatLong,
      isDelayReason: isDelayReason,
      listOfTypeOfNr: listOfTypeOfNr,
      typeOfNrValue: typeOfNrValue,
      baseUrl: baseUrl,
      lmcPath: lmcPath,
      listOfMRSerial: listOfMRSerial,
      regulatorCheck: regulatorCheck,
      rfcPhoto: rfcPhoto,
      pneumaticPhoto: pneumaticPhoto,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
      rfcDateController: rfcDateController,
      regulatorTypeController: regulatorTypeController,
    ));
  }
}
