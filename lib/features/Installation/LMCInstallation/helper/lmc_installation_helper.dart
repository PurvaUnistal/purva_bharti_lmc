import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/server_request.dart';

class LMCInstallationHelper{

  static final ctx = UserContext.getUserContext();

  static Future<InstallationDoneModel?> getLMCInstallationApi({required BuildContext context, required String page, required String bpNumber, required String areaId}) async {

    Map<String, String> para = {
      "schema": ctx.user.schema ?? "",
      "user_id": ctx.user.id ?? "",
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