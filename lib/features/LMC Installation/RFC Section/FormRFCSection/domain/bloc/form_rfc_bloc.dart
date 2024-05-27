import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/helper/form_feasibility_helper.dart';
import 'package:lmc/features/Home/presentation/home_view.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/helper/form_meter_helper.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/bloc/form_rfc_state.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/model/MaterialItem.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/helper/form_rfc_helper.dart';

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
    on<SelectQTYLMCEvent>(_selectQTYLMC);
    on<SubmitFormRFCEvent>(_submit);
  }

  String regulatorId = '';
  bool isLoader = false;
  bool isBtnLoader = false;
  bool isRegulator = false;
  bool isSelected = false;
  File rfcCardImg = File("");
  File pneumaticTestReportImg = File("");
  File installationImg = File("");
  List<ListOfMeterNo> listOfRegulatorNo = [];
  List<String> listOfRegulator = [];
  List<String> listOfRegulatorId = [];
  List<FreeMaterialData> listOfAllMaterial = [];
  List<MaterialItem> materialList = [];
  List<String> listOfAllMaterialId = [];
  List<String> listOfQtyLMC = [];
  List<GetConstantModel> listOfAllRFC = [];
  TextEditingController srNumberController = TextEditingController();
  TextEditingController latOfSRController = TextEditingController();
  TextEditingController longOfSRController = TextEditingController();
  TextEditingController latOfHouseController = TextEditingController();
  TextEditingController longOfHouseController = TextEditingController();
  TextEditingController rfcConDateController = TextEditingController();
  TextEditingController  proConDateController = TextEditingController();
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
    listOfAllMaterialId = [];
    materialList = [];
    listOfQtyLMC = [];
    listOfAllRFC = [];
    listOfRegulatorId = [];
    srNumberController.text = "";
    latOfSRController.text = "";
    longOfSRController.text = "";
    latOfHouseController.text = "";
    longOfHouseController.text = "";
    rfcConDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());;
    proConDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());;
    extraPipeController.text = "0";
    extraPriceController.text = "0";
    await fetchFreeMaterialApi(context: event.context,);
    await fetchRFCApi(context: event.context,);
    await fetchRegulatorsApi(context: event.context,regulatorSerial: "");
    await _setSRLocation();
    await _setHouseLocation();
     _eventCompleted(emit);
  }

  fetchRegulatorsApi({required BuildContext context, required String regulatorSerial,}) async {
    var res = await FormRFCHelper.getRegulatorsApi(context: context,regulatorSerial: regulatorSerial);
    if (res != null) {
      listOfRegulatorNo = res;
      listOfRegulator = listOfRegulatorNo.map((e) => e.serialNumber!).toList();
      return res;
    }
  }

  fetchFreeMaterialApi({required BuildContext context}) async {
    List<String> tempList = [];
    List<MaterialItem> _materialList = [];
    var res = await FormRFCHelper.getAllFreeMaterialApi(context: context,);
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

  fetchRFCApi({required BuildContext context}) async {
    var res = await FormRFCHelper.getRFCApi(context: context,);
    if (res != null) {
      listOfAllRFC = res;
      return res;
    }
  }

  _selectRegulatorsValue(SelectRegulatorsValueEvent event, emit) async {
    if(event.regulatorsValue.isNotEmpty){
     await fetchRegulatorsApi(context: event.context, regulatorSerial: event.regulatorsValue);
     for(int i = 0; i< listOfRegulatorNo.length; i++){
       listOfRegulator = listOfRegulatorNo.map((e) => e.serialNumber!).toList();
       listOfRegulatorId = listOfRegulatorNo.map((e) => e.id!).toList();
       regulatorId = await listOfRegulatorId[i].toString();
       print("hello---->${regulatorId}");
     }
    }
    _eventCompleted(emit);
  }

  _selectProposedDate(SelectProposedConDateEvent event,emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      proConDateController.text = formattedDate.toString();
       _eventCompleted(emit);
    }
  }

  _selectRFCDeclarationDate(SelectRFCDeclarationDateEvent event,emit) async {
    DateTime? dateTime = await showDatePicker(context: event.context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (dateTime != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      rfcConDateController.text = formattedDate.toString();
       _eventCompleted(emit);
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
     _eventCompleted(emit);
  }

  _selectLocationOfHouse(SelectLocationOfHouseEvent event,emit) {
    _setHouseLocation();
     _eventCompleted(emit);
  }

  _captureGalleryRFCCard(CaptureGalleryRFCCardEvent event,emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardImg = photoPath;
    }
     _eventCompleted(emit);
  }

  _captureCameraRFCCard(CaptureCameraRFCCardEvent event,emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      rfcCardImg = photoPath;
    }
     _eventCompleted(emit);
  }

  _captureGalleryPneumatic(CaptureGalleryPneumaticEvent event,emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportImg = photoPath;
    }
     _eventCompleted(emit);
  }

  _captureCameraPneumatic(CaptureCameraPneumaticEvent event,emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      pneumaticTestReportImg = photoPath;
    }
     _eventCompleted(emit);
  }

  _captureGalleryInstallation(CaptureGalleryInstallationEvent event,emit) async {
    var photoPath = await FormMeterHelper.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationImg = photoPath;
    }
     _eventCompleted(emit);
  }

  _captureCameraInstallation(CaptureCameraInstallationEvent event,emit) async {
    var photoPath = await FormMeterHelper.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      installationImg = photoPath;
    }
     _eventCompleted(emit);
  }

  _selectRFCCheckValue(SelectRFCCheckValueEvent event, emit) {
    emit(FormRFCInitialState());
    isSelected = event.isSelected;
    listOfAllRFC[event.index].isSelected = isSelected;
    log("${listOfAllRFC[event.index]}-->${listOfAllRFC[event.index].isSelected}");
     _eventCompleted(emit);
  }

  _submit(SubmitFormRFCEvent event, emit) async {
    try {
      var validationCheck = await FormRFCHelper.validationSubmit(
          context: event.context,
         // srNumber: srNumberController.text.trim().toString(),
          regulators: regulatorId.toString(),
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
         _eventCompleted(emit);
        var res = await FormRFCHelper.saveRFCInstallation(
            context: event.context,
            srNumber: srNumberController.text.trim().toString(),
            regulators: regulatorId.toString(),
            latitudeTF: latOfSRController.text.trim().toString(),
            longitudeTF: longOfSRController.text.trim().toString(),
            latitudeHG: latOfHouseController.text.trim().toString(),
            longitudeHG: longOfHouseController.text.trim().toString(),
            workCompletedDate: rfcConDateController.text.trim().toString(),
            materialIdLMC: listOfAllMaterialId.toList().toString().replaceAll('[', '').replaceAll(']', ''),
            qtyLMC: listOfQtyLMC.toList().toString().replaceAll('[', '').replaceAll(']', ''),
           extraPipe: extraPipeController.text.trim().toString(),
           extraPrice: extraPriceController.text.trim().toString(),
            isometricImg: rfcCardImg.path.toString(),
            installationImg: installationImg.path.toString(),
            pneumaticImg: pneumaticTestReportImg.path.toString());
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
    } catch (e) {
      print(e.toString());
      isBtnLoader = false;
      _eventCompleted(emit);
    }
  }

  _eventCompleted(emit) {
    emit(FormRFCDataState(
      isLoader : isLoader,
      isBtnLoader : isBtnLoader,
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
      srNumberController :srNumberController,
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
