import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/common_session_dialog_box.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiHelper {

  static Future<dynamic> getData({var urlEndPoint, required BuildContext context}) async{
    try {
      final response = await get(
        Uri.parse(urlEndPoint),
      ).timeout(const Duration(minutes: 1));
      log("URL-->${urlEndPoint.toString()}");
      log(urlEndPoint + "==>" + response.body);
      if (response.statusCode == 200) {
        //   return jsonDecode(response.body.toString());
        return response.body.toString();
      } else {
        log("Api.error-->${Api.error}");
        return null;
      }
    } catch (e){
      log("ApiServer-->${e.toString()}");
      if (e is SocketException) {
        log("SocketException : ${e.toString()}");
        Utils.warningSnackBar(msg:"No Internet",context:context);
      } else if (e is TimeoutException) {
        log("TimeoutException : ${e.toString()}");
        Utils.warningSnackBar(msg:"Timeout, Please try again",context:context);
      } else {
        log("Unhandled exception : ${e.toString()}");
        Utils.warningSnackBar(msg:e.toString(),context:context);
      }
      return null;
    }
  }

  static Future<dynamic> postData(
      {required String urlEndPoint, var body, required BuildContext context}) async {
    try {
      var res = await post(Uri.parse(urlEndPoint), body: body);
      print(res.body);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else if (res.statusCode == 403) {
        return SessionDialogUtils.logOut(context: context);
      } else if (res.statusCode == 401) {
        return jsonDecode(res.body);
      }
    } catch (e) {
      print("catch--->" + e.toString());
      Utils.errorSnackBar(msg: e.toString(),context: context);
      return null;
    }
  }

  static Future<dynamic> postDataWithFile({
    var endPoint,
    var body,
    required BuildContext context,
    required String filePath1,
    required String keyWord1,
    required String filePath2,
    required String keyWord2
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(PrefsValue.token) ?? "";
    try {
      Map<String, String> headers = {"Authorization": token};
      var request = MultipartRequest("POST", Uri.parse(endPoint));
      if (filePath1.isNotEmpty) {
        final mimeTypeData = lookupMimeType(filePath1, headerBytes: [0xFF, 0xD8])!.split('/');
        var uploadFile1 = await MultipartFile.fromPath(keyWord1, filePath1, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        request.files.add(uploadFile1);
      }
      if (filePath2.isNotEmpty) {
        final mimeTypeData = lookupMimeType(filePath2, headerBytes: [0xFF, 0xD8])!.split('/');
        var uploadFile2 = await MultipartFile.fromPath(keyWord2, filePath2, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        request.files.add(uploadFile2);
      }
      request.fields.addAll(body);
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var result = json.decode(String.fromCharCodes(responseData));
        log("result-->${result.toString()}");
        return result;
      } else if (response.statusCode == 401) {
      /*  await PreferenceUtil.clearAll();
        return Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.splashView, (Route<dynamic> route) => false);*/
      } else if (response.statusCode == 415) {
        var responseData = await response.stream.toBytes();
        var result = json.decode(String.fromCharCodes(responseData));
        log(result.toString());
        return result;
      } else if (response.statusCode == 400) {
        var responseData = await response.stream.toBytes();
        var result = json.decode(String.fromCharCodes(responseData));
        log(result.toString());
        return result;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> isInternetConnected() async {
    bool isConnect = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect = true;
      }
    } on SocketException catch (_) {}

    return isConnect;
  }



}

enum Api { error }
