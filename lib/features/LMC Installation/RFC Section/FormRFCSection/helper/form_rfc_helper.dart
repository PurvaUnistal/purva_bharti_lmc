import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/MeterNoModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/FormRFCSection/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class FormRFCHelper {

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

  static Future<List<FreeMaterialData>?> getAllFreeMaterialApi({required BuildContext context,}) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getAllFreeMaterial + json, context: context);
      AllFreeMaterialModel materialModel = AllFreeMaterialModel.fromJson(jsonDecode(res));
      return materialModel.data;
    } catch (e) {
      log("getRegulators-->${e.toString()}");
    }
    return null;
  }

  static Future<List<GetConstantModel>?> getRFCApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "rfc",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("getRFCApi-->${e.toString()}");
    }

    return null;
  }
  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String regulators,
    required String latitudeTF,
    required String longitudeTF,
    required String latitudeHG,
    required String longitudeHG,
    required String workCompletedDate,
    required String isometricImg,
    required String installationImg,
    required String pneumaticImg,
  }) async {
    try {
      if (regulators == "null") {
        Utils.errorSnackBar(msg: "The Regulators field is required.", context: context);
        return false;
      } else if (workCompletedDate.isEmpty) {
        Utils.errorSnackBar(msg: "The Work Completed Date field is required.", context: context);
        return false;
      }
      return true;
    } catch (e) {
      log("catchValidationSubmit--->${e.toString()}");
      return true;
    }
  }

  static Future<SaveFeasibleModel?> saveRFCInstallation({
    required BuildContext context,
    required String regulators,
    required String latitudeTF,
    required String longitudeTF,
    required String latitudeHG,
    required String longitudeHG,
    required String workCompletedDate,
    required String isometricImg,
    required String installationImg,
    required String pneumaticImg,
    required String materialIdLMC,
    required String qtyLMC,
    required String extraPipe,
    required String extraPrice,
  }) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    String dma = await SharedPref.getString(key: PrefsValue.rfcDma);
    String installationId = await SharedPref.getString(key: PrefsValue.installationId);
    String lmcFeasId = await SharedPref.getString(key: PrefsValue.rfcLMCFeasId);
    try {
      Map<String, String> para = {
        "dma_id": dma,
        "installation_id":installationId,
        "regulators": regulators,
        "schema": schema,
        "latitude_tf":latitudeTF,
        "longitude_tf": longitudeTF,
        "latitude_hg": latitudeHG,
        "longitude_hg": longitudeHG,
        "work_completed_date": workCompletedDate,
        "material_id_lmc": materialIdLMC,
        "qty_lmc": qtyLMC,
        "extra_pipe": extraPipe,
        "extra_price": extraPrice,
      };
      log("para-->${para}");
      var res = await ApiHelper.postDataWithFile(
          urlEndPoint: Apis.saveLmcRFCInstallation, body: para, context: context,
        keyWord1: "isometric_image",filePath1: isometricImg.toString(),
        keyWord2: "rfc_form",filePath2: installationImg.toString(),
        keyWord3: "pneumatic_image",filePath3: pneumaticImg.toString(),
      );
      if(res != null && res["error"] == false){
        return SaveFeasibleModel.fromJson(res);
      } else if(res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
    } catch (e) {
      log("saveLmcRFCInstallation-->${e.toString()}");
      return null;
    }
    return null;
  }
}
