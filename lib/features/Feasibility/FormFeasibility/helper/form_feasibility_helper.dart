import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/CheckFeasibleModel.dart';
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
}