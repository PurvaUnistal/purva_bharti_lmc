import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/presentation/lmc_feasibility_view.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/helper/form_meter_helper.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_state.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/helper/form_rfc_helper.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/presentation/rfc_section_view.dart';

class FormRFCBloc extends Bloc<FormRFCEvent, FormRFCState> {
  FormRFCBloc() : super(FormRFCInitialState()) {
    on<FormRFCPageLoadEvent>(_pageLoad);
    on<SelectProposedConDateEvent>(_selectProposedDate);
    on<SelectRFCDeclarationDateEvent>(_selectRFCDeclarationDate);
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
    on<SubmitFormRFCEvent>(_submit);
  }

  bool isLoader = false;
  bool isBtnLoader = false;
  bool isRegulator = false;
  bool isSelected= false;
  File rfcCardImg = File("");
  File pneumaticTestReportImg = File("");
  File installationImg = File("");
  List<ListOfMeterNo> listOfRegulatorNo = [];
  List<String> listOfRegulator = [];
  List<FreeMaterialData> listOfAllMaterial = [];
  List<GetConstantModel> listOfAllRFC = [];
  TextEditingController srNumberController = TextEditingController();
  TextEditingController regulatorController = TextEditingController();
  TextEditingController latOfSRController = TextEditingController();
  TextEditingController longOfSRController = TextEditingController();
  TextEditingController latOfHouseController = TextEditingController();
  TextEditingController longOfHouseController = TextEditingController();
  TextEditingController rfcConDateController = TextEditingController();
  TextEditingController  proConDateController = TextEditingController();
  TextEditingController  materialController = TextEditingController(text: "0");
  TextEditingController extraPipeController= TextEditingController(text: "0");
  TextEditingController extraPriceController= TextEditingController(text: "0");

  _pageLoad(FormRFCPageLoadEvent event, emit) async {
    emit(FormRFCInitialState());
    isLoader = false;
    isBtnLoader = false;
    isSelected = false;
    isRegulator = false;
    rfcCardImg = File("");
    pneumaticTestReportImg = File("");
    installationImg = File("");
    listOfRegulatorNo = [];
    listOfRegulator = [];
    listOfAllMaterial = [];
    listOfAllRFC = [];
    srNumberController.text = "";
    regulatorController.text = "";
    latOfSRController.text = "";
    longOfSRController.text = "";
    latOfHouseController.text = "";
    longOfHouseController.text = "";
    rfcConDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());;
    proConDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());;
    materialController.text = "0";
    extraPipeController.text = "0";
    extraPriceController.text = "0";
    await fetchRegulatorsApi(context: event.context,regulatorSerial: "2");
    await fetchFreeMaterialApi(context: event.context,);
    await fetchRFCApi(context: event.context,);
    await _setSRLocation();
    await _setHouseLocation();
    _eventCompleted();
  }

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial,}) async {
    var res = await FormRFCHelper.getRegulatorsApi(context: context,regulatorSerial: regulatorSerial);
    if (res != null) {
      listOfRegulatorNo = res;
      listOfRegulator = await listOfRegulatorNo.map((e) => e.serialNumber!).toSet().toList();
      return res;
    }
  }

  fetchFreeMaterialApi({required BuildContext context}) async {
    var res = await FormRFCHelper.getAllFreeMaterialApi(context: context,);
    if (res != null) {
      listOfAllMaterial = res;
      return res;
    }
  }

  fetchRFCApi({required BuildContext context}) async {
    var res = await FormRFCHelper.getRFCApi(context: context,);
    if (res != null) {
      listOfAllRFC = res;
      return res;
    }
  }
  
  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    if(event.regulatorsValue.isNotEmpty){
      listOfRegulatorNo = listOfRegulatorNo
          .where((element) => element.serialNumber == event.regulatorsValue.toString())
          .toList();
      listOfRegulator = await listOfRegulatorNo.map((e) => e.serialNumber!).toSet().toList();
      int i  = await listOfRegulator.indexWhere((element) => element.contains(event.regulatorsValue.toString()));
      regulatorController.text = await listOfRegulator.elementAt(i);
      _eventCompleted();
    }
  }

  _selectProposedDate(SelectProposedConDateEvent event,emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      proConDateController.text = formattedDate.toString();
      _eventCompleted();
    }
  }

  _selectRFCDeclarationDate(SelectRFCDeclarationDateEvent event,emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      rfcConDateController.text = formattedDate.toString();
      _eventCompleted();
    }
  }

  _setSRLocation() async {
    var getLocation = await FormMeterHelper.getCurrentLocation();
    latOfSRController.text = getLocation.latitude.toString();
    longOfSRController.text = getLocation.longitude.toString();
    return getLocation;
  }
  _setHouseLocation() async {
    var getLocation = await FormMeterHelper.getCurrentLocation();
    latOfHouseController.text = getLocation.latitude.toString();
    longOfHouseController.text = getLocation.longitude.toString();
    return getLocation;
  }

  _selectLocationOfSR(SelectLocationOfSREvent event,emit) {
    _setSRLocation();
    _eventCompleted();
  }

  _selectLocationOfHouse(SelectLocationOfHouseEvent event,emit) {
    _setHouseLocation();
    _eventCompleted();
  }

  _captureGalleryRFCCard(CaptureGalleryRFCCardEvent event,emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardImg = photoPath;
    }
    _eventCompleted();
  }

  _captureCameraRFCCard(CaptureCameraRFCCardEvent event,emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardImg = photoPath;
    }
    _eventCompleted();
  }

  _captureGalleryPneumatic(CaptureGalleryPneumaticEvent event,emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportImg = photoPath;
    }
    _eventCompleted();
  }

  _captureCameraPneumatic(CaptureCameraPneumaticEvent event,emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportImg = photoPath;
    }
    _eventCompleted();
  }

  _captureGalleryInstallation(CaptureGalleryInstallationEvent event,emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationImg = photoPath;
    }
    _eventCompleted();
  }

  _captureCameraInstallation(CaptureCameraInstallationEvent event,emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationImg = photoPath;
    }
    _eventCompleted();
  }

  _selectRFCCheckValue(SelectRFCCheckValueEvent event, emit) {
    isSelected = event.isSelected;
    listOfAllRFC[event.index].isSelected = isSelected;
    _eventCompleted();
  }
  _submit(SubmitFormRFCEvent event, emit) async {
    try {
      var validationCheck = await FormRFCHelper.validationSubmit(
          context: event.context,
          regulators: regulatorController.text.trim().toString(),
          latitudeTF: latOfSRController.text.trim().toString(),
          longitudeTF: longOfSRController.text.trim().toString(),
          latitudeHG: latOfHouseController.text.trim().toString(),
          longitudeHG: longOfHouseController.text.trim().toString(),
          workCompletedDate: rfcConDateController.text.trim().toString(),
          isometricImg: rfcCardImg.path.toString(),
          installationImg: installationImg.path.toString(),
          pneumaticImg: pneumaticTestReportImg.path.toString()
      );
      if (validationCheck == true) {
        isBtnLoader = true;
        _eventCompleted();
        var res = await FormRFCHelper.saveRFCInstallation(
            context: event.context,
            regulators: regulatorController.text.trim().toString(),
            latitudeTF: latOfSRController.text.trim().toString(),
            longitudeTF: longOfSRController.text.trim().toString(),
            latitudeHG: latOfHouseController.text.trim().toString(),
            longitudeHG: longOfHouseController.text.trim().toString(),
            workCompletedDate: rfcConDateController.text.trim().toString(),
            isometricImg: rfcCardImg.path.toString(),
            installationImg: installationImg.path.toString(),
            pneumaticImg: pneumaticTestReportImg.path.toString());
        if (res != null && res.error == false) {
          isBtnLoader = false;
          _eventCompleted();
          Utils.successSnackBar(msg: res.data!, context: event.context);
          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FeasibilityView()),
                  (Route<dynamic> route) => false);
        } else if (res != null && res.error == true) {
          isBtnLoader = false;
          _eventCompleted();
          Utils.errorSnackBar(msg: res.data!, context: event.context);
        }else {
          isBtnLoader = false;
          _eventCompleted();
        }
      }
    } catch (e) {
      print(e.toString());
      isBtnLoader = false;
      _eventCompleted();
    }
  }
  _eventCompleted() {
    emit(FormRFCDataState(
      isLoader : isLoader,
      isBtnLoader : isBtnLoader,
      isSelected : isSelected,
      rfcCardImg : rfcCardImg,
      pneumaticTestReportImg : pneumaticTestReportImg,
      installationImg : installationImg,
      listOfRegulatorNo :listOfRegulatorNo,
      listOfRegulator :listOfRegulator,
      listOfAllMaterial :listOfAllMaterial,
      listOfAllRFC :listOfAllRFC,
      srNumberController :srNumberController,
      regulatorController :regulatorController,
      latOfSRController :latOfSRController,
      longOfSRController :longOfSRController,
      latOfHouseController : latOfHouseController,
      longOfHouseController:longOfHouseController,
      rfcConDateController : rfcConDateController,
      proConDateController : proConDateController,
      materialController : materialController,
      extraPipeController: extraPipeController,
      extraPriceController: extraPriceController,
    ));
  }

}
