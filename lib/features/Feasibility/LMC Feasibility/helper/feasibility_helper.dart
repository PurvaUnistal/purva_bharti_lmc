import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/server_request.dart';

class LMCFeasibilityHelper {

  static final ctx = AppConfig.instanceInit()!.loginData.user ?? User();

  static Future<FeasibilityModel?> getFeasibilityApi({required BuildContext context, required String page, required String bpNumber, required String areaId}) async {

    Map<String, String> para = {
      "schema": ctx.schema ?? "",
      "user_id": ctx.id ?? "",
      "page": page,
      "bp_number": bpNumber,
      "area_id": areaId,
    };
    String json = Uri(queryParameters: para).query;
    try {
      var res = await ServerRequest.getData(urlEndPoint: Apis.getLMCFeasibility + json);
    if (res != null) {
      final decoded = res is String ? jsonDecode(res) : res;
      return FeasibilityModel.fromJson(decoded);
    }
    } catch (e) {
      log("FeasibilityModel-->${e.toString()}");
    }
    return null;
  }
}
