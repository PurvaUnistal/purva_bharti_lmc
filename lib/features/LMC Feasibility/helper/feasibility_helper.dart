import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/features/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class FeasibilityHelper{
  static Future<List<GetAllAreaModel>?> getAllAreaApi({required BuildContext context}) async {
   String schema =  await PreferenceUtil.getString(key: PrefsValue.schema,);
    try {
      dynamic res = await ApiHelper.getData(
          urlEndPoint: Apis.areaList + schema, context: context);
      return getAllAreaModelFromJson(res);
    } catch (e) {
      log("getAllAreaModelFromJson-->${e.toString()}");
    }
    return null;
  }
}