import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
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
  static Future<List<GetConstantModel>?> getTypeOfNrApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "typeOfNr",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
      return response;
    } catch (e) {
      log("typeOfNr-->${e.toString()}");
    }
    return null;
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

  static Future<List<GetConstantModel>?> getReadyForNgcApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "isCustomerReadyForNgc",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
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
        "schema": schema,
        "meterSerial": meterSerial,
        "user_id": userId,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getMeters + json, context: context);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
      return meterNoModel.data;
    } catch (e) {
      log("getMetersApi-->${e.toString()}");
    }
    return null;
  }

  static Future<List<ListOfMeterNo>?> getRegulatorsApi({required BuildContext context, required String regulatorSerial, required String regulatorType}) async {
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema": schema,
        "regulatorSerial": regulatorSerial,
        "user_id": userId,
        "regulatorType": regulatorType,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getRegulators + json, context: context);
      print(res);
      MeterNoModel meterNoModel = MeterNoModel.fromJson(res);
      return meterNoModel.data;
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<ExtraPipePriceData?> getExtraPipeDetailsApi({required BuildContext context, required String pipeQty}) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema": schema,
        "pipeQty": pipeQty,
      };
      var res = await ApiHelper.postData(urlEndPoint: Apis.getExtraPipeDetails, context: context, formData: para);
      return ExtraPipePriceData.fromJson(res['data']);
    } catch (e) {
      log("getExtraPipeDetails-->${e.toString()}");
    }
    return null;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String dateInstallation,
    required String rfcDateController,
    required bool isDelayReason,
    required LmcReasonModel delayReason,
    required String meterNumber,
    required bool isCheckMeterMismatch,
    required bool isCheckSR,
    required String meterInit1,
    required String meterInit2,
    required String meterInit3,
    required bool isInstallRegulator,
    required LmcReasonModel regulatorType,
    required String regulatorNumber,
    required bool isCheckRegulatorMismatch,
    required String srNumber,
    required String ngConversionDate,
    required String fittingDetails,
    required List<MaterialItem> pipeLength,
    required String meterPhoto,
    required String houseLat,
    required String houseLong,
    required String housePhoto,
  }) async {
    try {

      List<String> meterPipeValues = [];
      for(MaterialItem m in pipeLength) {
        if(m.unit == "Meter"){
          meterPipeValues.add(m.controller.text.isEmpty ? "0" : m.controller.text);
        }
      }
      if (dateInstallation.isEmpty) {
        Utils.errorSnackBar(msg: "The Date Installation field is required.", context: context);
        return false;
      } else if (isDelayReason == true && delayReason.id == null) {
        Utils.errorSnackBar(msg: "The Reason For Delay field is required.", context: context);
        return false;
      } else if (meterNumber.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Number field is required.", context: context);
        return false;
      } else if (isCheckMeterMismatch == true) {
        Utils.errorSnackBar(msg: "The Meter Number is mismatch. Please check your Meter Number.", context: context);
        return false;
      } else if (meterInit1.isEmpty || meterInit2.isEmpty || meterInit3.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Initial Reading field is required.", context: context);
        return false;
      } else if (isInstallRegulator == true) {
        if (regulatorType.name == null) {
          Utils.errorSnackBar(msg: "The Regulator Type field is required.", context: context);
          return false;
        } else if (regulatorType.name == "SR") {
          if (srNumber.isEmpty) {
            Utils.errorSnackBar(msg: "The SR Number field is required.", context: context);
            return false;
          } else if (isCheckSR == true) {
            Utils.errorSnackBar(msg: "The SR Number is mismatch. Please check your SR Number.", context: context);
            return false;
          } else if (regulatorNumber.isEmpty) {
            Utils.errorSnackBar(msg: "The Meter Regulator field is required.", context: context);
            return false;
          } else if (isCheckRegulatorMismatch == true) {
            Utils.errorSnackBar(msg: "The Meter Regulator Number is mismatch. Please check your Meter Regulator Number.", context: context);
            return false;
          }
        } else if (regulatorType.name == "PRV") {
          if (regulatorNumber.isEmpty) {
            Utils.errorSnackBar(msg: "The Regulator field is required.", context: context);
            return false;
          } else if (isCheckRegulatorMismatch == true) {
            Utils.errorSnackBar(msg: "The Regulator Number is mismatch. Please check your Regulator Number.", context: context);
            return false;
          }
        }
        if (ngConversionDate.isEmpty) {
          Utils.errorSnackBar(msg: "The Proposed NG Conversion Date field is required.", context: context);
          return false;
        } else if (rfcDateController.isEmpty) {
          Utils.errorSnackBar(msg: "The RFC Date field is required.", context: context);
          return false;
        }
      }
      if (fittingDetails.isEmpty) {
        Utils.errorSnackBar(msg: "The Fitting Details field is required.", context: context);
        return false;
      }
      else if (double.parse(meterPipeValues.reduce((value, element) => (double.parse(value) + double.parse(element)).toString())) <= 0) {
        Utils.errorSnackBar(msg: "Please enter at least one pipe detail.", context: context);
        return false;
      }
      if (meterPhoto.isEmpty) {
        Utils.errorSnackBar(msg: "The Meter Photo field is required.", context: context);
        return false;
      }else if (houseLat.isEmpty ||houseLong.isEmpty) {
        Utils.errorSnackBar(msg: "The House Latitude and Longitude Point is required.", context: context);
        return false;
      }
      else if (housePhoto.isEmpty) {
        Utils.errorSnackBar(msg: "The House Photo field is required.", context: context);
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
    required String sRegulatorsId,
    required String mRegulatorsId,
    required String srNumber,
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
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    String lmcInstallId = await SharedPref.getString(key: PrefsValue.lmcInstallId);
    String meterDma = await SharedPref.getString(key: PrefsValue.meterDma);
    String lmcFeasId = await SharedPref.getString(key: PrefsValue.meterLMCFeasId);
    String userId = await SharedPref.getString(key: PrefsValue.userId);
    try {
      Map<String, String> para = {
        "lmc_install_id": lmcInstallId.isEmpty ? " " : lmcInstallId,
        "schema": schema,
        "user_id": userId,
        "meter_reading_date": meterReadingDate,
        "meter_reading": meterReading.isEmpty ? "" : meterReading,
        "dma_id": meterDma,
        "meter_number": meterNo,
        "material_id": materialId,
        "feasibility_id": lmcFeasId,
        "tf_number": srNumber,
        "regulators": mRegulatorsId,
        "mr_regulator_id": sRegulatorsId,
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
      var res = await ApiHelper.postDataWithFile(urlEndPoint: Apis.saveLmcInstallation,
          body: para, context: context,
          imageRequestObject: [
        ImageRequestObject("meter_photo", meterPhoto.isEmpty ? "" : meterPhoto.toString()),
        //    ImageRequestObject("isometric_image", isometricPhoto.toString()),
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
