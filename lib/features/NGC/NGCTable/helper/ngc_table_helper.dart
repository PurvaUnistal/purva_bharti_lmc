import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:new_lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:new_lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:new_lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:new_lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';
import 'package:new_lmc/service/Apis.dart';
import 'package:new_lmc/service/api_server_dio.dart';
// import 'package:new_lmc/service/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NgcTableHelper {


  static Future<List<GetAllAreaModel>?> getAllAreaApi({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? schema = prefs.getString(PrefsValue.schema);
    try {
      var res = await ApiHelper.getData(
          urlEndPoint: Apis.areaList + schema!, context: context);
      if(res != null){
        return List<GetAllAreaModel>.from(res.map((x) => GetAllAreaModel.fromJson(x)));
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
        return LMCInstallationByNgcModel.fromJson(res);
      }
    } catch (e) {
      log("LmcInstallationByNgcModel-->${e.toString()}");
    }
    return null;
  }
}
