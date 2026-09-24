import 'dart:developer';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/MaterialItem.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/ExtraPipeDetailsModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_server_dio.dart';
import 'package:permission_handler/permission_handler.dart';

class FormInstallationHelper {
  static final ctx = UserContext.getUserContext();

  static Future<List<GetConstantModel>?> getTypeOfNrApi({
    required BuildContext context,
  }) async {
    try {
      Map<String, String> para = {"key": "typeOfNr"};
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelperDio.getData(
        urlEndPoint: Apis.getConstant + json,
      );
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
      return response;
    } catch (e) {
      log("typeOfNr-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> lmcReasonApi({
    required BuildContext context,
  }) async {
    try {
      var res = await ApiHelperDio.getData(urlEndPoint: Apis.lmcReason);
      List<LmcReasonModel> response = List<LmcReasonModel>.from(
        res.map((x) => LmcReasonModel.fromJson(x)),
      );
      return response;
    } catch (e) {
      log("lmcReasonApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<LmcReasonModel>?> regulatorTypeApi({
    required BuildContext context,
  }) async {
    try {
      var res = await ApiHelperDio.getData(urlEndPoint: Apis.regulatorType);
      List<LmcReasonModel> response = List<LmcReasonModel>.from(
        res.map((x) => LmcReasonModel.fromJson(x)),
      );
      return response;
    } catch (e) {
      log("regulatorTypeApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<GetConstantModel>?> getReadyForNgcApi({
    required BuildContext context,
  }) async {
    try {
      Map<String, String> para = {"key": "isCustomerReadyForNgc"};
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelperDio.getData(
        urlEndPoint: Apis.getConstant + json,
      );
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
      return response;
    } catch (e) {
      log("getReadyForNgcApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getMetersApi({
    required BuildContext context,
    required String meterSerial,
  }) async {
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "user_id": ctx.user.id ?? "",
        "role": ctx.user.role ?? "",
        "meterSerial": meterSerial,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelperDio.getData(urlEndPoint: Apis.getMeters + json);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
      return meterNoModel.data;
    } catch (e) {
      log("getMetersApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getRegulatorsApi({
    required BuildContext context,
    required String regulatorSerial,
    required String regulatorType,
  }) async {
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "user_id": ctx.user.id ?? "",
        "role": ctx.user.role ?? "",
        "regulatorSerial": regulatorSerial,
        "regulatorType": regulatorType,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelperDio.getData(
        urlEndPoint: Apis.getRegulators + json,
      );
      MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
      return meterNoModel.data;
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getMeterRegulatorsApi({
    required BuildContext context,
    required String regulatorSerial,
    required String regulatorType,
  }) async {
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "user_id": ctx.user.id ?? "",
        "role": ctx.user.role ?? "",
        "regulatorSerial": regulatorSerial,
        "regulatorType": "",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelperDio.getData(
        urlEndPoint: Apis.getMrRegulators + json,
      );
      MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
      return meterNoModel.data;
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<ExtraPipePriceData?> getExtraPipeDetailsApi({
    required BuildContext context,
    required String pipeQty,
  }) async {
    String propertyCategoryId = await SharedPref.getString(
      key: PrefsValue.propertyCategoryId,
    );
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "pipeQty": pipeQty,
        "property_category_id": propertyCategoryId,
      };
      var res = await ApiHelperDio.postData(
        urlEndPoint: Apis.getExtraPipeDetails,
        body: para,
      );
      if (res['data'] != null) {
        return ExtraPipePriceData.fromJson(res['data']);
      }
    } catch (e) {
      log("getExtraPipeDetails-->${e.toString()}");
    }
    return null;
  }

  static Future<ExtraPipePriceData?> getExtraPipeDetailsCopperApi({
    required BuildContext context,
    required String pipeQty,
    required String giqty,
  }) async {
    String propertyCategoryId = await SharedPref.getString(
      key: PrefsValue.propertyCategoryId,
    );
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "pipeQty": pipeQty,
        "property_category_id": propertyCategoryId,
        "giqty": giqty,
      };
      log("jsonCopper---->  ${para}");
      var res = await ApiHelperDio.postData(
        urlEndPoint: Apis.getExtraPipeDetailsCopper,
        body: para,
      );
      return ExtraPipePriceData.fromJson(res['data']);
    } catch (e) {
      log("getExtraPipeDetailsCopper-->${e.toString()}");
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
    required String pneumaticPhoto,
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
      }
      if (isCheckMeterMismatch) {
        return error(
          "The Meter Number is mismatch. Please check your Meter Number.",
        );
      }
      if ([meterInit1, meterInit2, meterInit3].any((e) => e.isEmpty)) {
        return error("The Meter Initial Reading field is required.");
      }

      if (!isInstallRegulator &&
          AppConfig.instanceInit()!.client == Client.hpoil) {
        return error("Please select Install Regulator Checkbox.");
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
            return error(
              "The SR Number is mismatch. Please check your SR Number.",
            );
          }
          if (mrNumber.isEmpty) {
            return error("The Meter Regulator field is required.");
          }
          if (isCheckMR) {
            return error(
              "The Meter Regulator Number is mismatch. Please check your Meter Regulator Number.",
            );
          }
        } else if (regulatorType.name == "PRV") {
          if (regulatorNumber.isEmpty) {
            return error("The Regulator field is required.");
          }
          if (isCheckRegulatorMismatch) {
            return error(
              "The Regulator Number is mismatch. Please check your Regulator Number.",
            );
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
      if (rfcPhoto.isEmpty &&
          AppConfig.instanceInit()!.client == Client.hpoil) {
        return error("The RFC Photo field is required.");
      }
      if (pneumaticPhoto.isEmpty &&
          AppConfig.instanceInit()!.client == Client.hpoil) {
        return error("The Pneumatic Photo field is required.");
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

  static Future<SaveFeasibleModel?> saveLMCInstallation({
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
    required String tapOff,
    required String tapOffLength,
    required String supplyPaint,
    required String gaisified,
    required String giExtraPipe,
    required String giExtraPrice,
    required String copperExtraPipe,
    required String copperExtraPrice,
    required String totalExtraPipe,
    required String totalExtraPrice,
  }) async {
    String lmcInstallId = await SharedPref.getString(
      key: PrefsValue.lmcInstallId,
    );
    String meterDma = await SharedPref.getString(key: PrefsValue.meterDma);
    String lmcFeasId = await SharedPref.getString(
      key: PrefsValue.meterLMCFeasId,
    );

    try {
      Map<String, String> para = {
        "lmc_install_id": lmcInstallId.isEmpty ? " " : lmcInstallId,
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
        "gi_pipe": giExtraPipe.isNotEmpty ? giExtraPipe.trim().toString() : "0.0",
        "gi_pipe_price": giExtraPrice.isNotEmpty ? giExtraPrice.trim().toString() : "0.0",
        "extra_pipe":
            totalExtraPipe.isNotEmpty
                ? totalExtraPipe.trim().toString()
                : "0.0",
        "extra_price":
            totalExtraPrice.isNotEmpty
                ? totalExtraPrice.trim().toString()
                : "0.0",
        "tap_off": tapOff,
        "tap_off_length": tapOffLength,
        "supply_paint": supplyPaint,
        "gaisified": gaisified,
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
      if (AppConfig.instanceInit()!.client == Client.hpoil) {
        para["cu_pipe"] = copperExtraPipe.isNotEmpty ? copperExtraPipe.trim().toString() : "0.0";
        para["cu_pipe_price"] =  copperExtraPrice.isNotEmpty ? copperExtraPrice.trim().toString() : "0.0";
      }
      log("para-->${para}");
      var res = await ApiHelperDio.postDataWithFile(
        urlEndPoint: Apis.saveLmcInstallation,
        body: para,
        imageRequestObject: [
          ImageRequestObject(
            key: "meter_photo",
            path: meterPhoto.isEmpty ? "" : meterPhoto.toString(),
          ),
          //    ImageRequestObject("isometric_image", isometricPhoto.toString()),
          ImageRequestObject(
            key: "rfc_form",
            path: isometricPhoto.isEmpty ? "" : isometricPhoto.toString(),
          ),
          ImageRequestObject(
            key: "pneumatic_image",
            path: pneumaticPhoto.isEmpty ? "" : pneumaticPhoto.toString(),
          ),
          ImageRequestObject(
            key: "house_image",
            path: housePhoto.isEmpty ? "" : housePhoto.toString(),
          ),
        ],
      );
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

  static Future<Position?> getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Permission.locationAlways.request();
    if (Platform.isAndroid) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
        locationSettings: LocationSettings(),
      );
      log('latitude : ${position.latitude} longitude : ${position.longitude}');
      return position;
    }
    return null;
  }
}
