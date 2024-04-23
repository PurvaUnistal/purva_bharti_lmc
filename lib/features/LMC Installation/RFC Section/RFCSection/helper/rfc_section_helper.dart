import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/FormMeterInstallation/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/model/RFCInstallationModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class RFCSectionHelper{

  static Future<RFCInstallationModel?> getRFCInstallationApi({
    required BuildContext context,
    required String page,
    required String bpNumber,
    required String areaId}) async {
    String schema =  await SharedPref.getString(key: PrefsValue.schema,);
    String userId =  await SharedPref.getString(key: PrefsValue.userId,);
    Map<String, String> para = {
      "schema" : schema,
      "user_id" : userId,
      "page" : page,
      "bp_number" : bpNumber,
      "area_id" : areaId,
    };
    String json =  Uri(queryParameters: para).query;
    try {
      var res = await ApiHelper.getData(
          urlEndPoint: Apis.getRFCInstallation + json, context: context);
      return RFCInstallationModel.fromJson(jsonDecode(res));
    } catch (e) {
      log("RFCInstallationModel-->${e.toString()}");
    }
    return null;
  }

}