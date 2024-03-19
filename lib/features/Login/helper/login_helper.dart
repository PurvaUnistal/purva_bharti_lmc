import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lmc/Server/api_server.dart';
import 'package:lmc/Server/app_url.dart';
import 'package:lmc/Utils/common_widget/app_string.dart';
import 'package:lmc/Utils/utils.dart';
import 'package:lmc/features/Login/domain/model/login_model.dart';

class LoginHelper {
  static String p = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static Future<dynamic> textFieldValidation(
      {required String email,
        required password,
        required BuildContext context}) async {
    try {
      if (email.isEmpty) {
        Utils.errorSnackBar(msg: AppString.userName,context: context);
        return false;
      }
      /* else if(RegExp(p).hasMatch(email)){
        Utils.failureMeg(AppString.emailValid, context);
        return true;
      }*/
      else if (password.isEmpty) {
        Utils.errorSnackBar(msg: AppString.password,context: context);
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      Utils.errorSnackBar(msg: e.toString(),context: context);
      return false;
    }
  }

  static Future<dynamic> loginData({
    required String emailId,
    required String password,
    required BuildContext context}) async {
    var param = {
      "email" : emailId,
      "password" : password,
    };
    try {
      var res = await ApiServer.postData(urlEndPoint: AppUrl. login, context: context,
          body: param);
      if(res != null && res["status"] == 200 && res["messages"] == "User logged In successfully"){
        return LoginModel.fromJson(res);
      } if(res != null && res["status"] == 401){
        if(res["messages"] == "Unauthorised"){
          return Utils.errorSnackBar(msg:res["messages"],context: context);
        } else {
          return Utils.errorSnackBar(msg:res["messages"],context: context);
        }
      }else {
        return Utils.errorSnackBar(msg:res["messages"],context: context);
      }
    } catch (e) {
      log("catchLogin-->${e.toString()}");
      // return null;
    }

  }
}
