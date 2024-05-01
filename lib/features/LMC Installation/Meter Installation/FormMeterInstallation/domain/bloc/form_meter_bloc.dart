import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/bloc/form_meter_state.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/DelayReasonModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/helper/form_meter_helper.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/presentation/meter_installation_view.dart';

class FormMeterBloc extends Bloc<FormMeterEvent, FormMeterState> {
  FormMeterBloc() : super(FormMeterInitialState()) {
    on<FormMeterPageLoadEvent>(_pageLoad);
    on<SelectProposedDateEvent>(_selectProposedDate);
    on<SelectActualWorkDateEvent>(_selectActualWorkDate);
    on<SelectMeterReadingDateEvent>(_selectMeterReadingDate);
    on<SelectDelayReasonValueEvent>(_selectDelayReasonValue);
    on<SelectNGCValueEvent>(_selectNGCValue);
    on<SelectTypeNRValueEvent>(_selectTypeNRValue);
    on<SelectMeterNumberValueEvent>(_selectMeterNumberValue);
    on<CaptureGalleryMeterEvent>(_captureGalleryMeter);
    on<CaptureCameraMeterEvent>(_captureCameraMeter);
    on<MeterInitReadingEvent>(_meterInitReading);
    on<SubmitFormMeterEvent>(_submit);
  }
  String materialId = '';
  bool isLoader = false;
  bool isBtnLoader = false;
  File meterImg = File("");

  ListOfMeterNo? meterNoValue;
  GetConstantModel? typeOfNrValue;
  GetConstantModel? readyNGCValue;
  DelayReasonModel? delayReasonValue;

  List<ListOfMeterNo> listOfMeterNo = [];
  List<GetConstantModel> listOfTypeOfNr = [];
  List<GetConstantModel> listOfReadyNGC = [];
  List<DelayReasonModel> listOfDelayReason = [];
  List<String> listOfMeterNumber = [];
  List<String> listOfMeterNumberId = [];

  TextEditingController bpNumberController = TextEditingController();
  TextEditingController proposedDateController = TextEditingController();
  TextEditingController actualWorkDateController = TextEditingController();
  TextEditingController meterNoController = TextEditingController();
  TextEditingController meterIniReading1Controller = TextEditingController();
  TextEditingController meterIniReading2Controller = TextEditingController();
  TextEditingController meterIniReading3Controller = TextEditingController();
  TextEditingController meterInitialReadingController = TextEditingController();
  TextEditingController meterReadingDateController = TextEditingController();

  FocusNode meterIniReading1FocusNode = FocusNode();
  FocusNode meterIniReading2FocusNode = FocusNode();
  FocusNode meterIniReading3FocusNode = FocusNode();


  _pageLoad(FormMeterPageLoadEvent event, emit) async {
    emit(FormMeterInitialState());
    isLoader = false;
    isBtnLoader = false;
    meterImg = File("");
    meterNoValue = null;
    typeOfNrValue = null;
    delayReasonValue = null;
    listOfMeterNo = [];
    listOfTypeOfNr = [];
    listOfReadyNGC = [];
    listOfDelayReason = [];
    listOfMeterNumber = [];
    listOfMeterNumberId = [];
    bpNumberController.text = "";
    proposedDateController.text = "";
    actualWorkDateController.text = "";
    meterNoController.text = "";
    meterIniReading1Controller.text = "";
    meterIniReading2Controller.text = "";
    meterIniReading3Controller.text = "";
    meterInitialReadingController.text = "";
    meterIniReading1FocusNode = FocusNode();
    meterIniReading2FocusNode = FocusNode();
    meterIniReading3FocusNode = FocusNode();
    meterReadingDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bpNumberController.text = await SharedPref.getString(key: PrefsValue.bpNumber);
    await fetchTypeOfNrApi(context: event.context);
    await fetchReadyForNgcApi(context: event.context);
    await fetchMetersApi(context: event.context);
    await fetchDelayReasonApi(context: event.context);
    _eventCompleted(emit);
  }

  _selectProposedDate(SelectProposedDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      proposedDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectActualWorkDate(SelectActualWorkDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      actualWorkDateController.text = formattedDate.toString();
      _eventCompleted(emit);
    }
  }

  _selectMeterReadingDate(SelectMeterReadingDateEvent event, emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      meterReadingDateController.text = formattedDate.toString();
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

  _selectTypeNRValue(SelectTypeNRValueEvent event, emit) {
    typeOfNrValue = event.typeOfNRValue;
    _eventCompleted(emit);
  }

  _selectMeterNumberValue(SelectMeterNumberValueEvent event, emit) async {
    if(event.meterReadingValue.isNotEmpty && event.meterReadingValue.length > 1){
      listOfMeterNo = listOfMeterNo
          .where((element) => element.serialNumber == event.meterReadingValue.toString())
          .toList();
      listOfMeterNumber = await listOfMeterNo.map((e) => e.serialNumber!).toSet().toList();
      listOfMeterNumberId = await listOfMeterNo.map((e) => e.id!).toSet().toList();
      int i  = await listOfMeterNumber.indexWhere((element) => element.contains(event.meterReadingValue.toString()));
      meterNoController.text = await listOfMeterNumber.elementAt(i);
      materialId = await listOfMeterNumberId.elementAt(i);
    }else if(event.meterReadingValue.length > 0){
      listOfMeterNumber = [];
    }
    print("materialId-->${materialId}");
    _eventCompleted(emit);
  }

  fetchTypeOfNrApi({required BuildContext context}) async {
    var res = await FormMeterHelper.getTypeOfNrApi(context: context);
    if (res != null) {
      listOfTypeOfNr = res;
      typeOfNrValue = listOfTypeOfNr.first;
      return res;
    }
  }

  fetchReadyForNgcApi({required BuildContext context}) async {
    var res = await FormMeterHelper.getReadyForNgcApi(context: context);
    if (res != null) {
      listOfReadyNGC = res;
      readyNGCValue = listOfReadyNGC.first;
      return res;
    }
  }

  fetchDelayReasonApi({required BuildContext context}) async {
    var res = await DelayReasonModel.getCheckData();
    if (res != null) {
      listOfDelayReason = res;
      delayReasonValue = listOfDelayReason.first;
      return res;
    }
  }

  fetchMetersApi({required BuildContext context}) async {
    var res = await FormMeterHelper.getMetersApi(context: context);
    if (res != null) {
      listOfMeterNo = res;
      if(listOfMeterNo.length > 1){
        listOfMeterNumber = await listOfMeterNo.map((e) => e.serialNumber!).toSet().toList();
      }
      return res;
    }
  }
  _captureGalleryMeter(CaptureGalleryMeterEvent event, emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      meterImg = photoPath;
    }
    _eventCompleted(emit);
  }

  _captureCameraMeter(CaptureCameraMeterEvent event, emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      meterImg = photoPath;
    }
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

  _submit(SubmitFormMeterEvent event, emit) async {
    try {
      var validationCheck = await FormMeterHelper.validationSubmit(
          context: event.context,
          delayReason: delayReasonValue!.name!.toString(),
          materialId: materialId,
          meterInitReading: meterInitialReadingController.text.trim().toString(),
          meterReading: meterNoController.text.trim().toString(),
          meterPhoto: meterImg.path,
          meterReadingDate: meterReadingDateController.text.trim().toString(),
          ngc: readyNGCValue!.value.toString(),
          typeOfNR: typeOfNrValue!.value.toString()
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted(emit);
        var res = await FormMeterHelper.saveLMCInstallation(
            context: event.context,
            meterNo:listOfMeterNumber.toString(),
            delayReason: delayReasonValue!.name.toString(),
            meterReadingDate: meterReadingDateController.text.trim().toString(),
            meterReading: meterInitialReadingController.text.trim().toString(),
            materialId: materialId,
            typeOfNR: typeOfNrValue!.value.toString(),
            ngc: readyNGCValue!.value.toString(),
            meterPhoto: meterImg.path);
        if (res != null && res.error == false) {
          isBtnLoader = false;
          _eventCompleted(emit);
          await Utils.successSnackBar(msg: res.data!, context: event.context);
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
    } catch (e) {
      print(e.toString());
      isBtnLoader = false;
      _eventCompleted(emit);
    }
  }


  _eventCompleted(emit) {
    emit(FormMeterDataState(
        isLoader: isLoader,
        isBtnLoader: isBtnLoader,
        meterImg: meterImg,
        meterNoValue: meterNoValue,
        typeOfNrValue: typeOfNrValue,
        delayReasonValue: delayReasonValue,
        listOfMeterNo: listOfMeterNo,
        listOfTypeOfNr: listOfTypeOfNr,
        listOfMeterNumber: listOfMeterNumber,
        listOfDelayReason: listOfDelayReason,
        bpNumberController: bpNumberController,
        proposedDateController: proposedDateController,
        actualWorkDateController: actualWorkDateController,
        meterNoController: meterNoController,
        meterIniReading1Controller: meterIniReading1Controller,
        meterIniReading2Controller: meterIniReading2Controller,
        meterIniReading3Controller: meterIniReading3Controller,
      meterInitialReadingController: meterInitialReadingController,
        meterReadingDateController: meterReadingDateController,
        meterIniReading1FocusNode: meterIniReading1FocusNode,
        meterIniReading2FocusNode: meterIniReading2FocusNode,
        meterIniReading3FocusNode: meterIniReading3FocusNode,
    ));
  }

}
