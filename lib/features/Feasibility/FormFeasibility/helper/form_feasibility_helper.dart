import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class FormFeasibilityHelper {
  static Future<List<GetConstantModel>?> getCheckFeasibilityApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "is_feasible",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("checkFeasibility-->${e.toString()}");
    }
    return null;
  }

  static Future<List<GetConstantModel>?> getLMCReasonApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "lmcReason",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("lmcReason-->${e.toString()}");
    }
    return null;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    String? feasibilityDate,
    GetConstantModel? isFeasible,
  }) async {
    try {
      if (feasibilityDate!.isEmpty) {
        Utils.errorSnackBar(msg: "The Feasibility Date field is required.", context: context);
        return false;
      } else if (isFeasible!.key == null) {
        Utils.errorSnackBar(msg: "The Check Feasible field is required.", context: context);
        return false;
      }
      return true;
    } catch (e) {
      log("catchValidationSubmit--->${e.toString()}");
      return true;
    }
  }

  static Future<SaveFeasibleModel?> saveLmcFeasibility({
    required BuildContext context,
    required String feasibilityDate,
    required String comment,
    required String followUpDate,
    required GetConstantModel isFeasible,
  }) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    String lmcId = await SharedPref.getString(key: PrefsValue.assignId);
    String dma = await SharedPref.getString(key: PrefsValue.dma);
    try {
      Map<String, String> para = {
        "lmcId": lmcId,
        "dmaId": dma,
        "proposed_date": "",
        "feasibility_visit_date": feasibilityDate,
        "schema": schema,
        "is_feasible": isFeasible.key,
        "comment":comment,
        "follow_up_date": followUpDate,
      };
      var res = await ApiHelper.postData(urlEndPoint: Apis.saveLmcFeasibility, body: para, context: context);
      if(res != null && res["error"] == false){
        return SaveFeasibleModel.fromJson(res);
      } else if(res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
    } catch (e) {
      log("saveLmcFeasibility-->${e.toString()}");
      return null;
    }
    return null;
  }
}
