import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class FormFeasibilityHelper {
  static Future<List<GetConstantModel>?> getCheckFeasibilityApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "is_feasible",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("checkFeasibility-->${e.toString()}");
    }
    return null;
  }

  static Future<List<GetConstantModel>?> getLMCReasonApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "lmcReason",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("lmcReason-->${e.toString()}");
    }
    return null;
  }

  static Future<List<FreeMaterialData>?> getAllFreeMaterialApi({required BuildContext context,}) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    try {
      Map<String, String> para = {
        "schema":schema,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getAllFreeMaterial + json, context: context);
      AllFreeMaterialModel materialModel = AllFreeMaterialModel.fromJson(jsonDecode(res));
      return materialModel.data;
    } catch (e) {
      log("getAllFreeMaterial-->${e.toString()}");
    }
    return null;
  }

  static Future<List<GetConstantModel>?> getRFCApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "rfc",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(jsonDecode(res));
      return response;
    } catch (e) {
      log("getRFCApi-->${e.toString()}");
    }

    return null;
  }

  static Future<void> clearCache() async {
    Directory path = Directory("/data/user/0/com.app.pbg.lmc/cache/");

    if(await path.exists()) {
      List<FileSystemEntity> files = path.listSync();
      for(FileSystemEntity f in files) {
        if(f is File) {
          await f.delete();
        }
      }
    }

    Directory path2 = Directory("/data/user/0/com.app.pbg.lmc/cache/file_picker/");

    if(await path2.exists()) {
      path2.deleteSync(recursive: true);
    }
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String feasibilityDate,
    required String proposedDate,
    required GetConstantModel isFeasible,
    required GetConstantModel lmcReasonValue,
    required String reason,
  }) async {
    try {
      if (feasibilityDate.isEmpty) {
        Utils.errorSnackBar(msg: "The Feasibility Date field is required.", context: context);
        return false;
      } else if (isFeasible.key == null) {
        Utils.errorSnackBar(msg: "The Is Feasible field is required.", context: context);
        return false;
      } else if (proposedDate.isEmpty) {
        Utils.errorSnackBar(msg: "The LMC Proposed Date field is required.", context: context);
        return false;
      } else if(isFeasible.key == "2" || isFeasible.key == "3"){
        if (lmcReasonValue.key == null) {
          Utils.errorSnackBar(msg: "The LMC Reason field is required.", context: context);
          return false;
        } else if(lmcReasonValue.key == "Others"){
          if(reason.isEmpty){
            Utils.errorSnackBar(msg: "The Reason field is required.", context: context);
            return false;
          }
        }
        return true;
      }
      return true;
    } catch (e) {
      log("catchValidationSubmit--->${e.toString()}");
      return true;
    }
  }

  static Future<SaveFeasibleModel?> saveLmcFeasibility({
    required BuildContext context,
    required String proposedDate,
    required String feasibilityDate,
    required String comment,
    required String followUpDate,
    required GetConstantModel isFeasible,
    required String materialId,
    required String qtyLMC,
    required String extraPipe,
    required String extraPrice,
  }) async {
    String schema = await SharedPref.getString(key: PrefsValue.schema);
    String lmcId = await SharedPref.getString(key: PrefsValue.assignId);
    String dma = await SharedPref.getString(key: PrefsValue.dma);
    try {
      Map<String, String> para = {
        "lmcId": lmcId,
        "dmaId": dma,
        "proposed_date": proposedDate,
        "feasibility_visit_date": feasibilityDate,
        "schema": schema,
        "is_feasible": isFeasible.key,
        "comment":comment,
        "follow_up_date": followUpDate,
        "material_id": materialId,
        "qty_lmc": qtyLMC,
        "extra_pipe": extraPipe,
        "extra_price": extraPrice,
      };
      log("para-->${para}");
      log("Url-->${Apis.saveLmcFeasibility}");
      var res = await ApiHelper.postData(urlEndPoint: Apis.saveLmcFeasibility, body: para, context: context);
      if(res != null && res["error"] == false){
        return SaveFeasibleModel.fromJson(res);
      } else if(res != null && res["error"] == true){
        Utils.errorSnackBar(msg: res["data"], context: context);
        return null;
      }
    } catch (e) {
      log("saveLmcFeasibility-->${e.toString()}");
      return null;
    }
    return null;
  }
}
