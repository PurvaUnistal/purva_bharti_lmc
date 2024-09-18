import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/Utils.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/common_session_dialog_box.dart';
import 'package:lmc/Utils/common_widgets/connectivity_helper.dart';
import 'package:mime/mime.dart';

class ApiHelper {
  static Future<dynamic> getData({var urlEndPoint, required BuildContext context}) async {
    try {
      if(await ConnectivityHelper.allConnectivityCheck(context: context) == false){
        return null;
      }
      final res = await Dio().get(urlEndPoint);
      log("url-->${urlEndPoint}");
      log("resData-->${res.data}");
      if (res.statusCode == 200) {
        return res.data;
      } else if (res.statusCode == 403) {
        return SessionDialogUtils.logOut(context: context);
      } else if (res.statusCode == 401) {
        return res.data;
      } else if (res.statusCode == 415) {
        return res.data;
      } else {
        return res.data;
      }
    } on DioException catch (error) {
      log(error.message ??"");
      await Utils.errorSnackBar(msg: error.message.toString(), context: context);
    } catch (e) {
      log("catchGET-->${e.toString()}");
      await Utils.errorSnackBar(msg: "Something Went Wrong", context: context);
      throw 'Something Went Wrong';
    }
  }

  static Future<dynamic> postData(
      {
        required BuildContext context,
        required String urlEndPoint,
        Map<String, dynamic>? param,
        String? contentType,
        formData,
      }) async {
    try {
      if(await ConnectivityHelper.allConnectivityCheck(context: context) == false){
        return null;
      }
      String token = await SharedPref.getString(key: PrefsValue.token);
      var res = await Dio().post(urlEndPoint, data: param ?? FormData.fromMap(formData), options: Options(headers:  {"Authorization": token,},));
      log("url-->${urlEndPoint}");
      log("resData-->${res.data}");
      if (res.statusCode == 200) {
        return res.data;
      } else if (res.statusCode == 403) {
        return SessionDialogUtils.logOut(context: context);
      } else if (res.statusCode == 401) {
        return res.data;
      } else if (res.statusCode == 415) {
        return res.data;
      } else {
        return res.data;
      }
    } on DioException catch (error) {
      log(error.message!);
      await Utils.errorSnackBar(msg: error.response!.data["messages"].toString(), context: context);
    } catch (e) {
      log("catchPOST-->${e.toString()}");
      await Utils.errorSnackBar(msg: "Something Went Wrong", context: context);
      throw 'Something Went Wrong';
    }
  }

  static Future<dynamic> postDataWithFile({
    var urlEndPoint,
    var body,
    required List<ImageRequestObject> imageRequestObject,
    required BuildContext context
  }) async {
    try {
      if(await ConnectivityHelper.allConnectivityCheck(context: context) == false){
        return null;
      }
      final formData = FormData.fromMap(body);
      for(int i=0; i< imageRequestObject.length ; i++) {
        var element = imageRequestObject[i];
        if (element.path!.isNotEmpty && !element.path!.startsWith("http")) {
          final mimeTypeData = lookupMimeType(element.path!, headerBytes: [0xFF, 0xD8])!.split('/');
          formData.files.add(
            MapEntry(element.key!, await MultipartFile.fromFile(element.path!, contentType:DioMediaType(mimeTypeData[0], mimeTypeData[1]) )),
          );
        } else {
          body[element.key!] = element.path;
        }
      }
      final response = await Dio().post(urlEndPoint, data: formData,);
      log("url-->${urlEndPoint}");
      log("resData-->${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioException catch (error) {
      log(error.message!);
      if(error.response?.statusCode == 415){
        return await Utils.errorSnackBar(msg: error.response!.data["data"].toString(), context: context);
      } else{
        return await Utils.errorSnackBar(msg: error.message!.toString(), context: context);
      }
    } catch (e) {
      log("MultipartFile-->${e.toString()}");
      await Utils.errorSnackBar(msg: "Something Went Wrong", context: context);
      throw 'Something Went Wrong';

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

class ImageRequestObject {
  String? key;
  String? path;

  ImageRequestObject(this.key, this.path);
}