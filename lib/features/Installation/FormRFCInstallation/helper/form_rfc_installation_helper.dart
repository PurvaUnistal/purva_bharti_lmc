import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormRFCInstallation/domain/model/RFCInstallationModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_server_dio.dart';
import 'package:permission_handler/permission_handler.dart';

class FormRFCInstallationHelper {

  static final ctx = UserContext.getUserContext();

  static Future<RFCInstallationModel?> lmcRFCInstallationApi({required BuildContext context}) async {

    String bpNumber = await SharedPref.getString(key: PrefsValue.bpNumber);
    Map<String, String> para = {
      "schema": ctx.user.schema ?? "",
      "user_id": ctx.user.id ?? "",
      "page": "",
      "bp_number": bpNumber,
      "area_id": "",
    };
    String json = Uri(queryParameters: para).query;
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.getlmcRFCInstallationApi + json, context: context);
      return RFCInstallationModel.fromJson(res);
    } catch (e) {
      log("getlmcRFCInstallationApi-->${e.toString()}");
    }
    return null;
  }

  static Future<bool> validationSubmit({
    required BuildContext context,
    required String dateInstallation,
    required String rfcDateController,
    required bool isDelayReason,
    required LmcReasonModel delayReason,
    required String meterNumber,
    required bool isCheckMeterMismatch,
    required bool isCheckMR,
    required String meterInit1,
    required String meterInit2,
    required String meterInit3,
    required bool isInstallRegulator,
    required LmcReasonModel regulatorType,
    required bool isCheckRegulatorMismatch,
    required String mrNumber,
    required String regulatorNumber,
    required String ngConversionDate,
    required String fittingDetails,
    required List<MaterialItem> pipeLength,
    required String meterPhoto,
    required String rfcPhoto,
    required String pneumaticTestReportPhoto,
    required String houseLat,
    required String houseLong,
    required String housePhoto,
  }) async {
    bool error(String msg) {
      Utils.errorSnackBar(msg: msg, context: context);
      return false;
    }

    try {
      // Calculate total pipe length
      double totalPipeLength = pipeLength
          .where((m) => m.unit == "Meter")
          .map((m) => double.tryParse(m.controller.text) ?? 0)
          .fold(0, (a, b) => a + b);

      if (dateInstallation.isEmpty) {
        return error("The Date Installation field is required.");
      }
      if (isDelayReason && delayReason.id == null) {
        return error("The Reason For Delay field is required.");
      }
      if (meterNumber.isEmpty) {
        return error("The Meter Number field is required.");
      } else if (isCheckMeterMismatch) {
        return error("The Meter Number is mismatch. Please check your Meter Number.");
      }
      if ([meterInit1, meterInit2, meterInit3].any((e) => e.isEmpty)) {
        return error("The Meter Initial Reading field is required.");
      }

      if (isInstallRegulator) {
        if (regulatorType.name == null) {
          return error("The Regulator Type field is required.");
        }

        if (regulatorType.name == "SR") {
          if (regulatorNumber.isEmpty) {
            return error("The SR Number field is required.");
          }
          if (isCheckRegulatorMismatch) {
            return error("The SR Number is mismatch. Please check your SR Number.");
          }
          if (mrNumber.isEmpty) {
            return error("The Meter Regulator field is required.");
          }
          if (isCheckMR) {
            return error("The Meter Regulator Number is mismatch. Please check your Meter Regulator Number.");
          }
        } else if (regulatorType.name == "PRV") {
          if (regulatorNumber.isEmpty) {
            return error("The Regulator field is required.");
          }
          if (isCheckRegulatorMismatch) {
            return error("The Regulator Number is mismatch. Please check your Regulator Number.");
          }
        }

        if (ngConversionDate.isEmpty) {
          return error("The Proposed NG Conversion Date field is required.");
        }
        if (rfcDateController.isEmpty) {
          return error("The RFC Date field is required.");
        }
      }

      if (fittingDetails.isEmpty) {
        return error("The Fitting Details field is required.");
      }

      if (totalPipeLength <= 0) {
        return error("Please enter at least one pipe detail.");
      }

      if (meterPhoto.isEmpty) {
        return error("The Meter Photo field is required.");
      }
      if (houseLat.isEmpty || houseLong.isEmpty) {
        return error("The House Latitude and Longitude Point is required.");
      }
      if (housePhoto.isEmpty) {
        return error("The House Photo field is required.");
      }

      return true;
    } catch (e) {
      log("catchValidationSubmit--->${e.toString()}");
      return true;
    }
  }


  static Future<SaveFeasibleModel?> saveLmcRFCInstallation({
    required BuildContext context,
    required String meterNo,
    required String regulatorsId,
    required String tfNumber,
    required String mRegulatorsId,
    required String latitudeHg,
    required String longitudeHg,
    required String workCompletedDate,
    required String materialIdLmc,
    required String qtyLmc,
    required String extraPipe,
    required String extraPrice,
    required LmcReasonModel delayReason,
    required String meterReadingDate,
    required String materialId,
    required String typeOfNR,
    required GetConstantModel ngc,
    required String proposedNgcDate,
    required String regulatorCheck,
    required String regulatorTypeId,
    required String meterReading,
    required String meterPhoto,
    required String rfcDate,
    required String meterTesting,
    required String paintingOfGIPipe,
    required String isometricPhoto,
    required String pneumaticPhoto,
    required String housePhoto,
  }) async {

    String lmcInstallId = await SharedPref.getString(key: PrefsValue.lmcInstallId);
    String installationId = await SharedPref.getString(key: PrefsValue.installationId);
    String meterDma = await SharedPref.getString(key: PrefsValue.meterDma);
    String lmcFeasId = await SharedPref.getString(key: PrefsValue.meterLMCFeasId);
    try {
      Map<String, String> para = {
        "lmc_install_id": lmcInstallId.isEmpty ? " " : lmcInstallId,
        "installation_id": installationId.isEmpty ? " " : installationId,
        "schema": ctx.user.schema ?? "",
        "user_id": ctx.user.id ?? "",
        "meter_reading_date": meterReadingDate,
        "meter_reading": meterReading.isEmpty ? "" : meterReading,
        "dma_id": meterDma,
        "meter_number": meterNo,
        "material_id": materialId,
        "feasibility_id": lmcFeasId,
        "tf_number": tfNumber,
        "regulators": regulatorsId,
        "mr_regulator_id": mRegulatorsId,
        "latitude_hg": latitudeHg,
        "longitude_hg": longitudeHg,
        "work_completed_date": workCompletedDate,
        "material_id_lmc": materialIdLmc,
        "qty_lmc": qtyLmc,
        "extra_pipe": extraPipe,
        "extra_price": extraPrice,
        "delay_reason": delayReason.name == null ? "" : delayReason.name.toString(),
        "type_of_nr": typeOfNR.isEmpty ? "" : typeOfNR.toString(),
        "ngc": ngc.key == null ? "" : ngc.key.toString(),
        "proposed_ngc_date": proposedNgcDate,
        "regulator_check": regulatorCheck.isEmpty ? "0" : regulatorCheck,
        "regulator_type_id": regulatorTypeId == "" ? "" : regulatorTypeId.toString(),
        "rfc_date": rfcDate.isEmpty ? "" : rfcDate,
        "meter_testing": meterTesting.isEmpty ? "0" : meterTesting,
        "paintaingofGIpipe": paintingOfGIPipe.isEmpty ? "0" : paintingOfGIPipe,
      };
      log("para-->${para}");
      var res = await ApiHelper.postDataWithFile(urlEndPoint: Apis.saveLmcRFCInstallation, body: para, context: context, imageRequestObject: [
        ImageRequestObject("meter_photo", meterPhoto.isEmpty ? "" : meterPhoto.toString()),
        ImageRequestObject("rfc_form", isometricPhoto.isEmpty ? "" : isometricPhoto.toString()),
        ImageRequestObject("pneumatic_image", pneumaticPhoto.isEmpty ? "" : pneumaticPhoto.toString()),
        ImageRequestObject("house_image", housePhoto.isEmpty ? "" : housePhoto.toString()),
      ]);
      if (res != null && res["error"] == false) {
        return SaveFeasibleModel.fromJson(res);
      } else if (res != null && res["error"] == true) {
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      } else {
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
    } catch (e) {
      log("saveLmcInstallation-->${e.toString()}");
      return null;
    }
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

  static Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Permission.locationAlways.request();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    log('latitude : ${position.latitude} longitude : ${position.longitude}');
    return position;
  }
}
