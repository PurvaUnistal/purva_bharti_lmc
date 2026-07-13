import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/NGC/NGCTable/domain/model/LmcInstallationByNgcModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/server_request.dart';

class NgcTableHelper {

  static final ctx = UserContext.getUserContext();
  static Future<List<GetAllAreaModel>?> getAllAreaApi({required BuildContext context}) async {

    try {
      var res = await ServerRequest.getData(
          urlEndPoint: Apis.areaList + ctx.user.schema!);
      if(res != null){
        return List<GetAllAreaModel>.from(res.map((x) => GetAllAreaModel.fromJson(x)));
      }
    } catch (e) {
      log("getAllAreaModelFromJson-->${e.toString()}");
    }
    return null;
  }

  static Future<LMCInstallationByNgcModel?> getLmcInstallationByNgcApi({required BuildContext context, required String areaId, required String bpNumber}) async {

    Map<String, String> para = {
      "schema": ctx.user.schema ?? "",
      "user_id": ctx.user.id ?? "",
      "page": "",
      "bp_number": bpNumber,
      "area_id": areaId,
    };
    String json = Uri(queryParameters: para).query;
    log("json-->$json");
    String url = Apis.getLmcInstallationByNgc +json;
    try {
      final res = await ServerRequest.getData(
        urlEndPoint:url,
      );
      print("getLmcInstallationByNgc-->${url}");
      if (res != null) {
        return LMCInstallationByNgcModel.fromJson(res);
      }
    } catch (e) {
      log("LmcInstallationByNgcModel-->${e.toString()}");
    }
    return null;
  }
}
