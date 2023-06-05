import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lmc/features/ApiProvider/api_error.dart';

import '../../utils/custom_toast.dart';
class ApiProvider{

  static Future<dynamic> postData({var endPoint,var body}) async{
    try{
      final res = await http.post(Uri.parse(endPoint),body: body);
      print(res.body);
      if(res.statusCode == 200){
        return jsonDecode(res.body);
      } else{
        CustomToast.showToast("Invalid Data");
        return null;
      }
    }catch (e) {
      if (e is SocketException) {
        CustomToast.showToast(e.toString());
        log("SocketException : ${e.toString()}");
      } else if (e is TimeoutException) {
        CustomToast.showToast(e.toString());
        log("TimeoutException : ${e.toString()}");
      } else {
        CustomToast.showToast(e.toString());
        log("Unhandled exception : ${e.toString()}");
      }
    }
    return null;
  }

  static Future<dynamic> getData({var endPoint}) async{
    try{
      final  res = await http.get(Uri.parse(endPoint));
      if(res.statusCode == 200){
        return jsonDecode(res.body);
      } else{
        CustomToast.showToast(Api.error.toString());
        return Api.error;
      }
    }catch (e) {
      CustomToast.showToast(e.toString());
      return Api.error;
    }
  }

}