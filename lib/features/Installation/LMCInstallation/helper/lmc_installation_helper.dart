import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/server_request.dart';

class LMCInstallationHelper{

  static final ctx = AppConfig.instanceInit()!.loginData.user ?? User();

  static Future<InstallationDoneModel?> getLMCInstallationApi({required BuildContext context, required String page, required String bpNumber, required String areaId}) async {

    Map<String, String> para = {
      "schema": ctx.schema ?? "",
      "user_id": ctx.id ?? "",
      "page": page,
      "bp_number": bpNumber,
      "area_id": areaId,
    };
    String json = Uri(queryParameters: para).query;
    try {
      var res = await ServerRequest.getData(urlEndPoint: Apis.getLMCInstallation + json);
      if (res != null) {
        return InstallationDoneModel.fromJson(res);
      }
    } catch (e) {
      log("getLMCInstallationApi-->${e.toString()}");
    }
    return null;
  }
}