import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/CheckFeasibleModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class FormFeasibilityHelper{

  static Future<List<CheckFeasibleModel>?> getCheckFeasibilityApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key" : "is_feasible",
      };
      String json =  Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(
          urlEndPoint: Apis.getConstant + json, context: context);
      List<CheckFeasibleModel> response = CheckFeasibleModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("checkFeasibility-->${e.toString()}");
    }
    return null;
  }

  static Future<List<CheckFeasibleModel>?> getLMCReasonApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key" : "lmcReason",
      };
      String json =  Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(
          urlEndPoint: Apis.getConstant + json, context: context);
      List<CheckFeasibleModel> response = CheckFeasibleModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("lmcReason-->${e.toString()}");
    }
    return null;
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
     String? feasibilityDate,
    CheckFeasibleModel? isFeasible,
  }) async {
    try {
      if (feasibilityDate!.isEmpty) {
        Utils.errorSnackBar(msg : "The Feasibility Date field is required.", context:context);
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
    required CheckFeasibleModel isFeasible,
  }) async {
   String schema = await SharedPref.getString(key: PrefsValue.schema);
   String lmcId = await SharedPref.getString(key: PrefsValue.lmcId);
   String dma = await SharedPref.getString(key: PrefsValue.dma);
    try {
      Map<String, String> para = {
        "lmcId" : lmcId,
        "dmaId" : dma,
        "proposed_date" : "",
        "feasibility_visit_date" : feasibilityDate,
        "schema" : schema,
        "bom" : "",
        "material_id" : "",
        "qty" : "",
        "is_feasible" : isFeasible.key!,
        "comment" : "",
        "follow_up_date" : "",
      };
      var res = await ApiHelper.postData(urlEndPoint: Apis.saveLmcFeasibility,body: para, context: context);
      return SaveFeasibleModel.fromJson(res);
    } catch (e) {
      log("lmcReason-->${e.toString()}");
    }
    return null;
  }
}