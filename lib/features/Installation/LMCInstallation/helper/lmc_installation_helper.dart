import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/model/InstallationDoneModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_server_dio.dart';

class LMCInstallationHelper{
  static Future<InstallationDoneModel?> getLMCInstallationApi({required BuildContext context, required String page, required String bpNumber, required String areaId}) async {
    String schema = await SharedPref.getString(
      key: PrefsValue.schema,
    );
    String userId = await SharedPref.getString(
      key: PrefsValue.userId,
    );
    Map<String, String> para = {
      "schema": schema,
      "user_id": userId,
      "page": page,
      "bp_number": bpNumber,
      "area_id": areaId,
    };
    String json = Uri(queryParameters: para).query;
    try {
      var res = await ApiHelper.getData(urlEndPoint: Apis.getLMCInstallation + json, context: context);
      if (res != null) {
        return InstallationDoneModel.fromJson(res);
      }
    } catch (e) {
      log("getLMCInstallationApi-->${e.toString()}");
    }
    return null;
  }
}