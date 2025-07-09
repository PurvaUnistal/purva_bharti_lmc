import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/NGC/NGCForm/domain/model/SubmitNgcReportModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_server_dio.dart';
// import 'package:lmc/service/api_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class NGCFormHelper{

  static Future<Position > getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Permission.locationAlways.request();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    log('latitude : ${position.latitude} longitude : ${position.longitude}');
    return position;
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

  static Future<void> clearCache() async {
    Directory path = Directory("/data/user/0/com.app.pbg.lmc/cache/");

    if(await path.exists()) {
      List<FileSystemEntity> files = path.listSync();
      for(FileSystemEntity f in files) {
        if(f is File) {
          await f.delete();
        }
      }
    }

    Directory path2 = Directory("/data/user/0/com.app.pbg.lmc/cache/file_picker/");

    if(await path2.exists()) {
      path2.deleteSync(recursive: true);
    }
  }

  static Future<List<LmcReasonModel>?> lmcReasonApi({required BuildContext context}) async {
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.lmcReason, context: context);
      List<LmcReasonModel> response = List<LmcReasonModel>.from(res.map((x) => LmcReasonModel.fromJson(x)));
      return response;
    } catch (e) {
      log("lmcReasonApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> ngcReasonApi({required BuildContext context}) async {
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.ngcReason, context: context);
      List<LmcReasonModel> response = List<LmcReasonModel>.from(res.map((x) => LmcReasonModel.fromJson(x)));
      return response;
    } catch (e) {
      log("ngcReasonApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> meterReplaceTypeApi({required BuildContext context}) async {
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.meterReplaceType, context: context);
      List<LmcReasonModel> response = List<LmcReasonModel>.from(res.map((x) => LmcReasonModel.fromJson(x)));
      return response;
    } catch (e) {
      log("lmcReasonApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> regulatorTypeApi({required BuildContext context}) async {
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.regulatorType, context: context);
      List<LmcReasonModel> response = List<LmcReasonModel>.from(res.map((x) => LmcReasonModel.fromJson(x)));
      return response;
    } catch (e) {
      log("regulatorTypeApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getMetersNGCApi({required BuildContext context, required String meterSerial}) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
        "meterSerial":meterSerial,
        "user_id": userId,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getNgcMeters + json, context: context);
      if(res != null){
        MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
        return meterNoModel.data;
      }
    } catch (e) {
      log("getMetersApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getRegulatorsNGCApi({
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
    var res = await ApiHelper.getData(urlEndPoint: Apis.getNgcRegulators + json, context: context);
    if(res != null){
      print(res);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
      return meterNoModel.data;
    }
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required bool isDelayReason,
    required LmcReasonModel delayReason,
    required String meterNumber,
    required bool isCheckMeterMismatch,
    required String regulatorType,
    required String regulatorNumber,
    required bool isCheckRegulatorMismatch,
    required String mrNumber,
    required bool isCheckMR,
    required String regulatorId,
    required String latSR,
    required String longSR,
    required String latMR,
    required String longMR,
    required String mrPhoto,
    required String srPhoto,
    required String nameContractor,
    required String bpNumber,
    required String noOfBurners,
    required String noOfFamily,
    required String meterInitialReading,
    required String phoneNo,
    required File meterImg,
    required String ngChargeDate,
    required String changeMeterType,
    required String changeRegulatorType,
  }) async {
    try {
      if (isDelayReason && delayReason.id == null) {
        Utils.errorSnackBar(msg: "The Reason For Delay field is required.", context: context);
        return false;
      }

      if (meterNumber.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Number field is required.", context: context);
        return false;
      }

      if (isCheckMeterMismatch) {
        Utils.errorSnackBar(msg: "The Meter Number is mismatch. Please check your Meter Number.", context: context);
        return false;
      }

      if (changeMeterType == "null") {
        Utils.errorSnackBar(msg: "The Change Meter Reason is required.", context: context);
        return false;
      }

      if (meterInitialReading.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Initial Reading field is required.", context: context);
        return false;
      }

      if (regulatorType.isEmpty || regulatorType == "null") {
        Utils.errorSnackBar(msg: "The Regulator Type field is required.", context: context);
        return false;
      }

      switch (regulatorType) {
        case "1":
          if (regulatorNumber.isEmpty) {
            Utils.errorSnackBar(msg: "The SR Regulator Number field is required.", context: context);
            return false;
          }
          if (isCheckRegulatorMismatch) {
            Utils.errorSnackBar(msg: "The SR Regulator Number is mismatch. Please check your SR Number.", context: context);
            return false;
          }
          if (mrNumber.isEmpty) {
            Utils.errorSnackBar(msg: "The Meter Regulator Number field is required.", context: context);
            return false;
          }
          if (isCheckMR) {
            Utils.errorSnackBar(msg: "The Meter Regulator Number is mismatch. Please check your Meter Regulator Number.", context: context);
            return false;
          }
          if (changeRegulatorType == "null") {
            Utils.errorSnackBar(msg: "The Change Regulator Type Reason is required.", context: context);
            return false;
          }
          if (mrPhoto.isEmpty) {
            Utils.errorSnackBar(msg: "The MR Photo field is required.", context: context);
            return false;
          }
          if (srPhoto.isEmpty) {
            Utils.errorSnackBar(msg: "The SR Photo field is required.", context: context);
            return false;
          }
          if (latMR.isEmpty || longMR.isEmpty) {
            Utils.errorSnackBar(msg: "The latMR/longMR field is required.", context: context);
            return false;
          }
          if (latSR.isEmpty || longSR.isEmpty) {
            Utils.errorSnackBar(msg: "The latSR/longSR field is required.", context: context);
            return false;
          }
          break;

        case "2":
          if (regulatorNumber.isEmpty) {
            Utils.errorSnackBar(msg: "The Regulator field is required.", context: context);
            return false;
          }
          if (isCheckRegulatorMismatch) {
            Utils.errorSnackBar(msg: "The Regulator Number is mismatch. Please check your Regulator Number.", context: context);
            return false;
          }
          if (changeRegulatorType == "null") {
            Utils.errorSnackBar(msg: "The Change Regulator Reason is required.", context: context);
            return false;
          }
          break;
      }

      if (bpNumber.isEmpty) {
        Utils.errorSnackBar(msg: "The BP Number field is required.", context: context);
        return false;
      }

      if (noOfBurners.isEmpty) {
        Utils.errorSnackBar(msg: "The No. Of Burners field is required.", context: context);
        return false;
      }

     /* if (noOfFamily.isEmpty) {
        Utils.errorSnackBar(msg: "The No. Of Family field is required.", context: context);
        return false;
      }*/

      if (phoneNo.isEmpty) {
        Utils.errorSnackBar(msg: "The Phone No. field is required.", context: context);
        return false;
      }

      if (meterImg.path.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Photo field is required.", context: context);
        return false;
      }

      return true;
    } catch (e) {
      log("catchValidationSubmit ---> ${e.toString()}");
      return true;
    }
    }


    static Future<SubmitNgcReportModel?> setNGCReportData({
    required BuildContext context,
    required String nameOfContractor,
    required String meterReading,
    required String jmrNo,
    required String nOfBurners,
    required String mismatchMeterNo,
    required String contactPerson,
    required String reasonOfDelay,
    required String delayReasonValue,
    required String alternateMobile,
    required String email,
    required String conversionDate,
    required String workCompletedDate,
    required String dmaUserId,
    required String lmcInstallationId,
    required String isInstall,
    required String comment,
    required String meterNumberId,
    required String tfNumber,
    required String regulatorId,
    required LmcReasonModel regulatorTypeId,
    required String meterChangeReason,
    required String replaceMeter,
    required LmcReasonModel changeMeterType,
    required String mrRegulatorId,
    required String latitudeMR,
    required String longitudeMR,
    required String latitudeTf,
    required String longitudeTf,
    required String mrPhoto,
    required String srPhoto,
    required String noOfFamily,
    required String meterPhoto,
    required String ngcReportPhoto,
  }) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    Map<String, String> body = {
      "schema": schema,
      "user_id": userId,
      "name_of_contractor": nameOfContractor.isEmpty ? "" : nameOfContractor,
      "meter_reading": meterReading.isEmpty ? "" :meterReading,
      "jmr_no": jmrNo.isEmpty ? "" :jmrNo,
      "no_of_burners": nOfBurners.isEmpty ? "" : nOfBurners,
      "mismatch_meter_no": mismatchMeterNo.isEmpty ? "" :mismatchMeterNo,
      "ngc_meter_number": meterNumberId.isEmpty ? "" :meterNumberId,
      "contact_person": contactPerson.isEmpty ? "" : contactPerson,
      "reason_of_delay":  reasonOfDelay.isEmpty  ? "" :reasonOfDelay.toString(),
      "delay_status": delayReasonValue.isEmpty  ? "" :delayReasonValue.toString(),
      "alternate_mobile": alternateMobile.isEmpty ? "" : alternateMobile,
      "email": email.isEmpty ? "" :email,
      "conversion_date": conversionDate.isEmpty ? "" : conversionDate,
      "work_completed_date": workCompletedDate.isEmpty ? "" : workCompletedDate,
      "dma_user_id": dmaUserId.isEmpty ? "" : dmaUserId,
      "lmc_installation_id": lmcInstallationId.isEmpty ? "" : lmcInstallationId,
      "is_install": isInstall.isEmpty ? "" : isInstall,
      "comment": comment.isEmpty ? "" : comment,

      "meter_change_reason": meterChangeReason.isEmpty ? "": meterChangeReason,
      "replace_meter": replaceMeter.isEmpty ? "0" :replaceMeter,
      "change_meter_type": changeMeterType.id == null ? "0" : changeMeterType.id.toString(),
      "tf_number": tfNumber.isEmpty ? "" : tfNumber,
      "regulator_type_id": regulatorTypeId.id == null ? "":regulatorTypeId.id.toString(),
      "regulators_number": regulatorId,
      "mr_regulator_id": mrRegulatorId,
      "latitude_mr": latitudeMR.isEmpty ? "0" : latitudeMR,
      "longitude_mr": longitudeMR.isEmpty ? "0" :longitudeMR,
      "latitude_tf": latitudeTf.isEmpty ? "0" : latitudeTf,
      "longitude_tf": longitudeTf.isEmpty ? "0" : longitudeTf,
      "no_of_family": noOfFamily.isEmpty ? "0" : noOfFamily,
    };
    log("jsonBody-->${body}");
    try {
      var res = await ApiHelper.postDataWithFile(
        urlEndPoint: "${Apis.setNGCReport}",
        body: body,
        imageRequestObject: [
          ImageRequestObject("meter_image", meterPhoto.isEmpty ? "" : meterPhoto.toString()),
          ImageRequestObject("ngc_report_file", ngcReportPhoto.isEmpty ? "" :ngcReportPhoto.toString()),
          ImageRequestObject("mr_photo", mrPhoto.isEmpty ? "" : mrPhoto.toString()),
          ImageRequestObject("sr_photo", srPhoto.isEmpty  ? "" : srPhoto.toString()),
        ],
        context: context,
      );
      if (res != null && res["error"] == false) {
        return SubmitNgcReportModel.fromJson(res);
      } else if (res != null && res['success'] != null && res['success'] == 415 && res['data'] != null) {
        Utils.errorSnackBar(msg: res["data"].toString(),context: context);
        return null;
      } else if ( res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"].toString(),context: context);
        return null;
      }
    }catch(e){
      print("setNGCReportData-->${e.toString()}");
    }
    return null;
  }

}