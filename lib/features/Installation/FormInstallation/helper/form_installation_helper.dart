import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class FormInstallationHelper {

  static Future<List<GetConstantModel>?> getTypeOfNrApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "typeOfNr",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("typeOfNr-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> lmcReasonApi({required BuildContext context}) async {
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.lmcReason, context: context);
      List<LmcReasonModel> response = lmcReasonModelFromJson(res);
      return response;
    } catch (e) {
      log("lmcReasonApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> regulatorTypeApi({required BuildContext context}) async {
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.regulatorType, context: context);
      List<LmcReasonModel> response = lmcReasonModelFromJson(res);
      return response;
    } catch (e) {
      log("regulatorTypeApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<GetConstantModel>?> getReadyForNgcApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "isCustomerReadyForNgc",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("getReadyForNgcApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getMetersApi({required BuildContext context, required String meterSerial}) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
        "meterSerial":meterSerial,
        "user_id": userId,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getMeters + json, context: context);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(jsonDecode(res));
      return meterNoModel.data;
    } catch (e) {
      log("getMetersApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getRegulatorsApi({
    required BuildContext context,
    required String regulatorSerial,
    required String regulatorType}) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
        "regulatorSerial":regulatorSerial,
        "user_id": userId,
        "regulatorType": regulatorType,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getRegulators + json, context: context);
      print(res);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(jsonDecode(res));
      return meterNoModel.data;
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String dateInstallation,
    required LmcReasonModel delayReason,
    required String meterNumber,
    required String meterInit1,
    required String meterInit2,
    required String meterInit3,
    required String rfcDeclarationDate,
    required String proposedNGCConversionDate,
    required String fittingDetails,
    required String meterPhoto,
    required String rfcPhoto,
    required String pneumaticTestReportPhoto,
  }) async {
    try {
      if (dateInstallation.isEmpty) {
        Utils.errorSnackBar(msg: "The Date Installation field is required.", context: context);
        return false;
      } else  if (delayReason.id == null) {
        Utils.errorSnackBar(msg: "The Reason For Delay field is required.", context: context);
        return false;
      }  else  if (meterNumber.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Number field is required.", context: context);
        return false;
      } else if (meterInit1.isEmpty && meterInit2.isEmpty && meterInit3.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Initial Reading field is required.", context: context);
        return false;
      } else if (rfcDeclarationDate.isEmpty) {
        Utils.errorSnackBar(msg: "The RFC Declaration Date field is required.", context: context);
        return false;
      } else if (proposedNGCConversionDate.isEmpty) {
        Utils.errorSnackBar(msg: "The Proposed NGC Conversion Date field is required.", context: context);
        return false;
      } else if (fittingDetails.isEmpty) {
        Utils.errorSnackBar(msg: "The Fitting Details field is required.", context: context);
        return false;
      } else if (meterPhoto.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Photo field is required.", context: context);
        return false;
      } else if (rfcPhoto.isEmpty) {
        Utils.errorSnackBar(msg: "The RFC Photo field is required.", context: context);
        return false;
      } else if (pneumaticTestReportPhoto.isEmpty) {
        Utils.errorSnackBar(msg: "The Pneumatic Test Report Photo field is required.", context: context);
        return false;
      }
      return true;
    } catch (e) {
      log("catchValidationSubmit--->${e.toString()}");
      return true;
    }
  }


  static Future<SaveFeasibleModel?> saveLMCInstallation({
    required BuildContext context,
    required String meterNo,
    required String regulators,
    required String latitudeTf,
    required String longitudeTf,
    required String latitudeHg,
    required String longitudeHg,
    required String workCompletedDate,
    required String materialIdLmc,
    required String qtyLmc,
    required String extraPipe,
    required String extraPrice,
    required String rfcForm,
    required LmcReasonModel delayReason,
    required String meterReadingDate,
    required String materialId,
    required GetConstantModel typeOfNR,
    required GetConstantModel ngc,
    required String proposedNgcDate,
    required LmcReasonModel regulatorTypeId,
    required String meterReading,
    required String meterPhoto,
    required String isometricPhoto,
    required String pneumaticPhoto,
  }) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    String meterDma = await SharedPref.getString(key: PrefsValue.meterDma);
    String lmcFeasId = await SharedPref.getString(key: PrefsValue.meterLMCFeasId);
  //  try {
      Map<String, String> para = {
        "schema": schema,
        "meter_reading_date": meterReadingDate,
        "meter_reading": meterReading,
        "dma_id": meterDma,
        "meter_number": meterNo,
        "material_id": materialId,
        "feasibility_id": lmcFeasId,
        "regulators": regulators,
        "latitude_tf": latitudeTf,
        "longitude_tf": longitudeTf,
        "latitude_hg": latitudeHg,
        "longitude_hg": longitudeHg,
        "work_completed_date": workCompletedDate,
        "material_id_lmc": materialIdLmc,
        "qty_lmc": qtyLmc,
        "extra_pipe": extraPipe,
        "extra_price": extraPrice,
        "rfc_form": rfcForm ?? "",
        "delay_reason": delayReason.name ?? "",
        "type_of_nr": typeOfNR.value ?? "",
        "ngc": ngc.value ?? "",
        "proposed_ngc_date": proposedNgcDate ?? "",
        "regulator_type_id": regulatorTypeId.name ?? "",
      };
      log("para-->${para}");
      var res = await ApiHelper.postDataWithFile(
        urlEndPoint: Apis.saveLmcInstallation,
        body: para, context: context,
        keyWord1: "meter_photo",filePath1: meterPhoto.toString(),
        keyWord2: "isometric_image",filePath2: isometricPhoto.toString(),
        keyWord3: "pneumatic_image",filePath3: pneumaticPhoto.toString(),
      );
      if(res != null && res["error"] == false){
        // Utils.successSnackBar(msg: res["data"], context: context);
        return SaveFeasibleModel.fromJson(res);
      } else if(res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
  /*  } catch (e) {
      log("saveLmcInstallation-->${e.toString()}");
      return null;
    }*/
    return null;
  }

  static Future<File> cameraCapture() async {
    await Permission.camera.request();
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 900,
      maxWidth: 1000,
    );
    File files = File(file!.path);
    return files;
  }

  static Future<File> galleryCapture() async {
    await Permission.storage.request();
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 900,
      maxWidth: 1000,
    );
    File files = File(file!.path);
    return files;
  }

  static Future<Position > getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Permission.locationAlways.request();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    log('latitude : ${position.latitude} longitude : ${position.longitude}');
    return position;
  }

}



