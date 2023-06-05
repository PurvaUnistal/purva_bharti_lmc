import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lmc/utils/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/global_constant.dart';
import '../../ApiProvider/api_provider.dart';
import '../domain/model/change_password_model.dart';

class ChangePasswordHelper{

  static Future<dynamic> textFieldValidation({ String newPassword,  String confirmPassword, BuildContext context}) async {
    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    RegExp upperRegex=  RegExp(r'[A-Z]');
    try {
      if (newPassword.isEmpty && newPassword != null) {
        CustomToast.showToast("Password is required please enter");
        return false;
      }
      else if (newPassword.length  < 8){
        CustomToast.showToast("Password must be at least 8 characters long");
        return false;
      }
      else if(!upperRegex.hasMatch(newPassword)){
        CustomToast.showToast("The Password must be at least one Uppercase letter.");
        return false;
      }else if (confirmPassword.isEmpty) {
        CustomToast.showToast("Please enter password");
        return false;
      }else if(confirmPassword != newPassword){
        CustomToast.showToast("Password does not match. Please re-type again.");
        return false;
      }
      return true;
    } catch (e) {
      CustomToast.showToast(e.toString());
      return false;
    }
  }

 static Future<dynamic> fetchChangePassword(String userId, String password, String confirmPassword) async{
    ChangePasswordResponse changePasswordResponse =ChangePasswordResponse(
      userId: userId,
      password: password,
      confirmPassword: confirmPassword,
    );
    try{
      String url = GlobalConstants.resetPassword;
      var res = await ApiProvider.postData(endPoint:url,body: changePasswordResponse.toJson());
      if(res != null ){
        if(res["success"] != null && res["success"]== 200){
          if(res["message"] != null){
return res["message"];
          }
        }
      /*  ChangePasswordModel changePasswordModel = ChangePasswordModel();
        return changePasswordModel;*/
      } else{
        log("Null Value");
        return null;
      }
    }catch(e){
      CustomToast.showToast(e.toString());
    }
  }
}