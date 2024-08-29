import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NgcTableHelper {


  static Future<List<GetAllAreaModel>?> getAllAreaApi({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? schema = prefs.getString(PrefsValue.schema);
    try {
      var res = await ApiHelper.getData(
          urlEndPoint: Apis.areaList + schema!, context: context);
      if(res != null){
        return getAllAreaModelFromJson(res);
      }
    } catch (e) {
      log("getAllAreaModelFromJson-->${e.toString()}");
    }
    return null;
  }

  static Future<LMCInstallationByNgcModel?> getLmcInstallationByNgcApi({required BuildContext context, required String areaId, required String bpNumber}) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema,);
    String userId = await SharedPref.getString(key: PrefsValue.userId,);
    Map<String, String> para = {
      "schema": schema,
      "user_id": userId,
      "page": "",
      "bp_number": bpNumber,
      "area_id": areaId,
    };
    String json = Uri(queryParameters: para).query;
    log("json-->$json");
    String url = Apis.getLmcInstallationByNgc +json;
    try {
      final res = await ApiHelper.getData(
        urlEndPoint:url,
        context: context,
      );
      if (res != null) {
        return LMCInstallationByNgcModel.fromJson(jsonDecode(res));
      }
    } catch (e) {
      log("LmcInstallationByNgcModel-->${e.toString()}");
    }
    return null;
  }
}
