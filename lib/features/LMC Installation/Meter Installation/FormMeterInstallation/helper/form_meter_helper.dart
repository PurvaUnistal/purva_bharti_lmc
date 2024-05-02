import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/DelayReasonModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';
import 'package:geolocator/geolocator.dart';

class FormMeterHelper {

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
  static Future<List<ListOfMeterNo>?> getMetersApi({required BuildContext context}) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
        "meterSerial":"dia",
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

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String meterReading,
    required String meterInit1,
    required String meterInit2,
    required String meterInit3,
    required DelayReasonModel delayReason,
    required String meterReadingDate,
    required String materialId,
    required String typeOfNR,
    required String ngc,
    required String meterPhoto,
  }) async {
    try {
      if (typeOfNR == "null") {
        Utils.errorSnackBar(msg: "The Type Of NR field is required.", context: context);
        return false;
      } else  if (meterReadingDate.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Reading Date field is required.", context: context);
        return false;
      }  else  if (meterReading.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Number field is required.", context: context);
        return false;
      } else if (meterInit1.isEmpty && meterInit2.isEmpty && meterInit3.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Initial Reading field is required.", context: context);
        return false;
      } else if (delayReason == "null" || delayReason.id == "1") {
        Utils.errorSnackBar(msg: "The Delay Reason field is required.", context: context);
        return false;
      } else  if (meterPhoto.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Photo field is required.", context: context);
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
    required String delayReason,
    required String meterReadingDate,
    required String materialId,
    required String typeOfNR,
    required String ngc,
    required String meterReading,
    required String meterPhoto,
  }) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    String meterDma = await SharedPref.getString(key: PrefsValue.meterDma);
    String lmcFeasId = await SharedPref.getString(key: PrefsValue.meterLMCFeasId);
    try {
      Map<String, String> para = {
        "schema": schema,
        "dma_id": meterDma,
        "meter_number": meterNo,
        "delay_reason": delayReason,
        "meter_reading_date": meterReadingDate,
        "meter_reading": meterReading,
        "material_id": materialId,
        "type_of_nr": typeOfNR,
        "ngc": ngc,
        "feasibility_id": lmcFeasId,
      };
      log("para-->${para}");
      var res = await ApiHelper.postDataWithFile(
          urlEndPoint: Apis.saveLmcInstallation,
        body: para, context: context,
          keyWord1: "meter_photo",filePath1: meterPhoto.toString(),
          keyWord2: "",filePath2: "",
          keyWord3: "",filePath3: "",
      );
      if(res != null && res["error"] == false){
       // Utils.successSnackBar(msg: res["data"], context: context);
        return SaveFeasibleModel.fromJson(res);
      } else if(res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
    } catch (e) {
      log("saveLmcInstallation-->${e.toString()}");
      return null;
    }
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



