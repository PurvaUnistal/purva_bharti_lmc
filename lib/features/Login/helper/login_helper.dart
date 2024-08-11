import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';
import 'package:lmc/service/Apis.dart';
import 'package:lmc/service/api_helper.dart';

class LoginHelper {
  static Future<dynamic> textFieldValidation({required String email, required String password, required BuildContext context}) async {
    try {
      if (email.isEmpty) {
        Utils.errorSnackBar(msg: AppString.emailValidation, context: context);
        return false;
      } else if (password.isEmpty) {
        Utils.errorSnackBar(msg: AppString.passwordValidation, context: context);
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      Utils.errorSnackBar(msg: e.toString(), context: context);
      return false;
    }
  }

  static getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  static Future<LoginModel?> loginData({required String emailId, required String password, required BuildContext context}) async {
    var deviceId = await getUniqueDeviceId();
    Map<String, String> para = {
      "email": emailId,
      "password": password,
      "device": deviceId,
    };
    try {
      var res = await ApiHelper.postData(urlEndPoint: Apis.loginUrl, body: jsonEncode(para), context: context);

      if (res != null && res["error"] == false) {
        await Utils.successSnackBar(msg: res["messages"], context: context);
        String str = Apis.loginUrl;
        await SharedPref.setString(key: PrefsValue.baseUrl, value: str.replaceAll("auth", ""));
        print(str.replaceAll("auth", ""));
        return LoginModel.fromJson(res);
      } else if (res != null && res["error"] == true) {
        await Utils.errorSnackBar(msg: res["messages"], context: context);
        return null;
      } else if (res != null && res["error"] == true && res["messages"] != null) {
        await Utils.errorSnackBar(msg: res["messages"], context: context);
        return null;
      }
    } catch (e) {
      log("catchLoginHelper-->${e.toString()}");
      Utils.errorSnackBar(msg: e.toString(), context: context);
      return null;
    }
  }
}
