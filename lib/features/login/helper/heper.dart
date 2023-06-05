import 'package:flutter/cupertino.dart';
import 'package:lmc/features/ApiProvider/api_provider.dart';
import 'package:lmc/features/login/domain/model/login_model.dart';
import 'package:lmc/utils/custom_toast.dart';

import '../../../utils/global_constant.dart';

class LoginHelper{

  static Future<dynamic>textValidation({String emailId, String password, BuildContext context}) async{

    try{
      if(emailId.isEmpty){
        CustomToast.showToast("Please enter email id");
        return false;
      } else if(password.isEmpty){
        CustomToast.showToast("Please enter Password");
        return false;
      }
      return true;
    }catch(e){
      CustomToast.showToast(e.toString());
      return false;
    }
  }

  static Future<dynamic> postLoginData({String emailId, String password, BuildContext context}) async {
try{

  String url = GlobalConstants.login;
  var res = await ApiProvider.postData(endPoint: url, body:"" );
}catch(e){

}

  }

}