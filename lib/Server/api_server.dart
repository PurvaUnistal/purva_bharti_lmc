import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lmc/Server/api_error.dart';
import 'package:lmc/Utils/utils.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ApiServer {

  static Future<dynamic> getData({var urlEndPoint, required BuildContext context}) async{
    try {
      final response = await get(
        Uri.parse(urlEndPoint),
      ).timeout(const Duration(minutes: 1));
      log("URL-->${urlEndPoint.toString()}");
      log(urlEndPoint + "==>" + response.body);
      if (response.statusCode == 200) {
           return jsonDecode(response.body.toString());
      //  return response.body.toString();
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

  static Future<dynamic> postData({var urlEndPoint, required BuildContext context, var body}) async {
    try {
      final response = await post(Uri.parse(urlEndPoint), body: json.encode(body)).timeout(const Duration(minutes: 1));
      log("urlEndPoint ===== ${urlEndPoint}");
      log("get Res ===== ${response.body}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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

  static Future<dynamic> postDataWithFile({
    required var endPoint,
    required var body, required BuildContext context, required String filePath, required String keyWord}) async {
    try{
      var request = MultipartRequest("POST", Uri.parse(endPoint));
      if(filePath.isNotEmpty){
        final mimeTypeData =
        lookupMimeType(filePath, headerBytes: [0xFF, 0xD8])!.split('/');
        var uploadFile = await MultipartFile.fromPath(keyWord, filePath,
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        request.files.add(uploadFile);
      }
      request.fields.addAll(body);
      //   request.headers.addAll(header);
      var response = await request.send();
      if(response.statusCode == 200){
        var responseData = await response.stream.toBytes();
        var result = json.decode(String.fromCharCodes(responseData));
        log("result-->${result.toString()}");
        return result;
      } else if(response.statusCode == 415){
        var responseData = await response.stream.toBytes();
        var result = json.decode(String.fromCharCodes(responseData));
        log(result.toString());
        return result;
      } else if(response.statusCode == 400){
        var responseData = await response.stream.toBytes();
        var result = json.decode(String.fromCharCodes(responseData));
        log(result.toString());
        return result;
      }else {
        return null;
      }
    }catch(e){
      log(e.toString());
      return null;
    }
  }


  static  Future<File?> cameraCapture() async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 5);
    File files = File(file!.path);
    return files;
  }

  static Future<File?> galleryCapture() async {
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 5);
    File files = File(file!.path);
    return files;
  }
}
