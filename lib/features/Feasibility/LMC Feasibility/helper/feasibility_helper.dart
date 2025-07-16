import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class LMCFeasibilityHelper {

  static final ctx = UserContext.getUserContext();
  static Future<List<GetAllAreaModel>?> getAllAreaApi({required BuildContext context}) async {

    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.areaList + ctx.user.schema ?? "", context: context);
      return getAllAreaModelFromJson(res);
    } catch (e) {
      log("getAllAreaModelFromJson-->${e.toString()}");
    }
    return null;
  }

  static Future<FeasibilityModel?> getFeasibilityApi({required BuildContext context, required String page, required String bpNumber, required String areaId}) async {

    Map<String, String> para = {
      "schema": ctx.user.schema ?? "",
      "user_id": ctx.user.id ?? "",
      "page": page,
      "bp_number": bpNumber,
      "area_id": areaId,
    };
    String json = Uri(queryParameters: para).query;
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.getLMCFeasibility + json, context: context);
      if (res != null) {
        return FeasibilityModel.fromJson(jsonDecode(res));
      }
    } catch (e) {
      log("FeasibilityModel-->${e.toString()}");
    }
    return null;
  }
}
