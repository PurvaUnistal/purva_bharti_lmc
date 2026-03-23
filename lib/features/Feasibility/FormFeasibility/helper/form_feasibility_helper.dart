import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/UserContext.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/AllFreeMaterialModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/SaveFeasibleModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_server_dio.dart';

class FormFeasibilityHelper {

  static final ctx = UserContext.getUserContext();
  static Future<List<GetConstantModel>?> getCheckFeasibilityApi({required BuildContext context}) async {
    try {
      Map<String, String> para = {
        "key": "is_feasible",
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getConstant + json, context: context);
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
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
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
      return response;
    } catch (e) {
      log("lmcReason-->${e.toString()}");
    }
    return null;
  }

  static Future<List<FreeMaterialData>?> getAllFreePipeMaterial({
    required BuildContext context,
  }) async {

    String propertyCategoryId = await SharedPref.getString(
        key: PrefsValue.propertyCategoryId);
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "property_category_id": propertyCategoryId,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getAllFreePipeMaterial + json, context: context);
      AllFreeMaterialModel materialModel = AllFreeMaterialModel.fromJson(res);
      return materialModel.data;
    } catch (e) {
      log("getAllFreePipeMaterial-->${e.toString()}");
    }
    return null;
  }

  static Future<List<FreeMaterialData>?> getAllFreeMaterialApi({
    required BuildContext context,
  }) async {
    String propertyCategoryId = await SharedPref.getString(
        key: PrefsValue.propertyCategoryId);
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "property_category_id": propertyCategoryId,
      };
      String json = Uri(queryParameters: para).query;
      var res = await ApiHelper.getData(urlEndPoint: Apis.getAllFreeMaterial + json, context: context);
      AllFreeMaterialModel materialModel = AllFreeMaterialModel.fromJson(res);
      return materialModel.data;
    } catch (e) {
      log("getAllFreeMaterial-->${e.toString()}");
    }
    return null;
  }


  static Future<List<FreeMaterialData>?> getAllFreeMaterialCopperApi({
    required BuildContext context,
  }) async {
    String propertyCategoryId = await SharedPref.getString(
        key: PrefsValue.propertyCategoryId);
    try {
      Map<String, String> para = {
        "schema": ctx.user.schema ?? "",
        "property_category_id": propertyCategoryId,
      };
      String json = Uri(queryParameters: para).query;

      var res = await ApiHelper.getData(urlEndPoint: Apis.getAllFreeMaterialCopper + json, context: context);
      AllFreeMaterialModel materialModel = AllFreeMaterialModel.fromJson(res);
      return materialModel.data;
    } catch (e) {
      log("getAllFreeMaterialCopper-->${e.toString()}");
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
      List<GetConstantModel> response = GetConstantModel.mapToList(res);
      return response;
    } catch (e) {
      log("getRFCApi-->${e.toString()}");
    }

    return null;
  }

  static Future<void> clearCache() async {
    Directory path = Directory("/data/user/0/com.app.pbg.lmc/cache/");

    if (await path.exists()) {
      List<FileSystemEntity> files = path.listSync();
      for (FileSystemEntity f in files) {
        if (f is File) {
          await f.delete();
        }
      }
    }

    Directory path2 = Directory("/data/user/0/com.app.pbg.lmc/cache/file_picker/");

    if (await path2.exists()) {
      path2.deleteSync(recursive: true);
    }
  }

  static Future<dynamic> validationSubmit({
    required BuildContext context,
    required String feasibilityDate,
    required List<String> pipeLength,
    required String proposedDate,
    required GetConstantModel isFeasible,
    required GetConstantModel lmcReasonValue,
    required String reason,
    required String followUpDate,
  }) async {
    try {
      if (feasibilityDate.isEmpty) {
        Utils.errorSnackBar(msg: "The Feasibility Date field is required.", context: context);
        return false;
      } else if (isFeasible.key == null) {
        Utils.errorSnackBar(msg: "The Is Feasible field is required.", context: context);
        return false;
      }
      else if(isFeasible.key == "1"){
      /*  if (int.parse(pipeLength.reduce((value, element) => (int.parse(value) + int.parse(element)).toString())) <= 0) {
          Utils.errorSnackBar(msg: "Please enter at least one pipe detail.", context: context);
          return false;
        } else */
          if (proposedDate.isEmpty) {
          Utils.errorSnackBar(msg: "The LMC Proposed Date field is required.", context: context);
          return false;
        }
      }
       else if (isFeasible.key == "2" || isFeasible.key == "3") {
        if (lmcReasonValue.key == null) {
          Utils.errorSnackBar(msg: "The LMC Reason field is required.", context: context);
          return false;
        } else if (lmcReasonValue.key == "Others") {
          if (reason.isEmpty) {
            Utils.errorSnackBar(msg: "The Reason field is required.", context: context);
            return false;
          }
        }
      }
      if (isFeasible.key == "3") {
        if (followUpDate.isEmpty) {
          Utils.errorSnackBar(msg: "The Follow Up Date field is required.", context: context);
          return false;
        }
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
    required String giExtraPipe,
    required String giExtraPrice,
    required String copperExtraPipe,
    required String copperExtraPrice,
    required String totalExtraPipe,
    required String totalExtraPrice,
    required String manualPipe,
    required String manualPipeLength,
    required String tfStatus,
  }) async {

    String lmcId = await SharedPref.getString(key: PrefsValue.assignId);
    String dma = await SharedPref.getString(key: PrefsValue.dma);

    try {
      Map<String, String> para = {
        "lmcId": lmcId,
        "dmaId": dma,
        "user_id": ctx.user.id ?? "",
        "proposed_date": proposedDate,
        "feasibility_visit_date": feasibilityDate,
        "schema": ctx.user.schema ?? "",
        "is_feasible": isFeasible.key,
        "comment": comment,
        "follow_up_date": followUpDate,
        "material_id_lmc": materialId,
        "qty_lmc": qtyLMC,
        "gi_pipe" : giExtraPipe.isNotEmpty ? giExtraPipe.trim().toString() : "0.0",
        "gi_pipe_price" : giExtraPrice.isNotEmpty ? giExtraPrice.trim().toString() : "0.0",
        "cu_pipe" : copperExtraPipe.isNotEmpty ? copperExtraPipe.trim().toString() : "0.0",
        "cu_pipe_price" : copperExtraPrice.isNotEmpty ? copperExtraPrice.trim().toString() : "0.0",
        "extra_pipe": totalExtraPipe.isNotEmpty ? totalExtraPipe.trim().toString() : "0.0",
        "extra_price": totalExtraPrice.isNotEmpty ? totalExtraPrice.trim().toString() : "0.0",
        "manual_pipe": manualPipe.isNotEmpty ? manualPipe.trim().toString() : "0.0",
        "manual_pipe_length": manualPipeLength.isNotEmpty ? manualPipeLength.trim().toString() : "0.0",
        "tf_status": tfStatus,
      };
      log("para-->${para}");
      var res = await ApiHelper.postData(urlEndPoint: Apis.saveLmcFeasibility, formData: para, context: context);
      if (res != null && res["error"] == false) {
        return SaveFeasibleModel.fromJson(res);
      } else if (res != null && res["error"] == true) {
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
