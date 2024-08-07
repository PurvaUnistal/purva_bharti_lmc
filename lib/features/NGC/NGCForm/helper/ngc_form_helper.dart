import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/NGC/NGCForm/domain/model/SubmitNgcReportModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class NGCFormHelper{


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
    Directory path = Directory("/data/user/0/com.unistal.pbg.ngc_app/cache/");

    if(await path.exists()) {
      List<FileSystemEntity> files = path.listSync();
      for(FileSystemEntity f in files) {
        if(f is File) {
          await f.delete();
        }
      }
    }

    Directory path2 = Directory("/data/user/0/com.unistal.pbg.ngc_app/cache/file_picker/");

    if(await path2.exists()) {
      path2.deleteSync(recursive: true);
    }
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

  static Future<List<ListOfMeterNo>?> getRegulatorsApi({required BuildContext context,required String regulatorSerial}) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
        "regulatorSerial":regulatorSerial,
        "user_id": userId,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getRegulators + json, context: context);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(jsonDecode(res));
      return meterNoModel.data;
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    String? nameContractor,
    String? bpNumber,
    String? noOfBurners,
    String? meterReading,
    String? meterNo,
    String? phoneNo,
    String? meterImg,
    String? ngcReportImg,
    String? delayStatusValue,
    String? date,
    String? delayReason,
  }) async {
    try {
      if (nameContractor!.isEmpty) {
        Utils.errorSnackBar(msg : "The Name Contractor field is required.", context:context);
        return false;
      } else if (bpNumber!.isEmpty) {
        Utils.errorSnackBar(msg : "The bp Number field is required.", context:context);
        return false;
      } else if (noOfBurners!.isEmpty) {
        Utils.errorSnackBar(msg : "The No. Of Burners field is required.",context: context);
        return false;
      } else if (meterReading!.isEmpty) {
        Utils.errorSnackBar(msg : "The Meter Reading field is required.", context:context);
        return false;
      } else if (meterNo!.isEmpty) {
        Utils.errorSnackBar(msg : "The Meter No. field is required.",context: context);
        return false;
      } else if (phoneNo!.isEmpty) {
        Utils.errorSnackBar(msg : "The Phone No. field is required.", context:context);
        return false;
      } else if (date!.isEmpty) {
        Utils.errorSnackBar(msg : "The NG Charge Date field is required.", context:context);
        return false;
      } else if (delayStatusValue == "null") {
        Utils.errorSnackBar(msg : "The Delay Status field is required.",context: context);
        return false;
      } else if (meterImg!.isEmpty || meterImg == "" ) {
        Utils.errorSnackBar(msg : "The Meter File field is required.",context: context);
        return false;
      } else if (ngcReportImg!.isEmpty || ngcReportImg == "") {
        Utils.errorSnackBar(msg : "The NGC Report File field is required.", context:context);
        return false;
      } else if(delayStatusValue == "Yes"){
       if (delayReason!.isEmpty ) {
        Utils.errorSnackBar(msg : "The Delay Reason field is required.",context: context);
        return false;
      }
      }
      return true;
    } catch (e) {
      log("catchValidationSubmit--->${e.toString()}");
      return true;
    }
  }

  static Future<SubmitNgcReportModel?> setNGCReportData({
    required BuildContext context,
    String? schema,
    String? nameOfContractor,
    String? meterReading,
    String? jmrNo,
    String? nOfBurners,
    String? mismatchMeterNo,
    String? contactPerson,
    String? reasonOfDelay,
    String? alternateMobile,
    String? email,
    String? delayStatus,
    String? conversionDate,
    String? workCompletedDate,
    String? dmaUserId,
    String? lmcInstallationId,
    String? isInstall,
    String? comment,
    File? meterFile,
    File? ngcReportFile,

  }) async {
    Map<String, String> body = {
      "schema": schema ?? "",
      "name_of_contractor": nameOfContractor ?? "",
      "meter_reading": meterReading ?? "",
      "jmr_no": jmrNo ?? "",
      "no_of_burners": nOfBurners ?? "",
      "mismatch_meter_no": mismatchMeterNo ?? "",
      "contact_person": contactPerson ?? "",
      "reason_of_delay": reasonOfDelay ?? "",
      "alternate_mobile": alternateMobile ?? "",
      "email": email ?? "",
      "delay_status": delayStatus == null ? "" : delayStatus,
      "conversion_date": conversionDate ?? "",
      "work_completed_date": workCompletedDate ?? "",
      "dma_user_id": dmaUserId ?? "",
      "lmc_installation_id": lmcInstallationId ?? "",
      "is_install": isInstall ?? "",
      "comment": comment ?? "",
    };
    log("jsonBody-->${body}");
    try {
      var res = await ApiHelper.postDataWithFile(
        urlEndPoint: "${Apis.setNGCReport}",
        body: body, keyWord1: "meter_image", filePath1: meterFile!.path.toString(),
        keyWord2: "ngc_report_file", filePath2: ngcReportFile!.path.toString(),
        context: context,
        filePath3: "",
        keyWord3: "",
      );
      if (res != null && res["error"] == false) {
        return SubmitNgcReportModel.fromJson(res);
      } else if (res != null && res["data"]) {
        Utils.errorSnackBar(msg: res["data"]["delay_status"].toString(),context: context);
        return null;
      } else if ( res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"].toString(),context: context);
        return null;
      }
    } catch (e) {
      log("catchSubmitModel-->${e.toString()}");
      Utils.errorSnackBar(msg: e.toString(), context:context);
      return null;
    }
  }

}