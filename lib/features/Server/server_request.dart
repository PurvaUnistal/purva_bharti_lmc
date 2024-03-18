// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// class ServerRequest {
//
//    static BuildContext? context =  Singleton.instanceInit()?.context;
//    static var header = {
//      //"Authorization" : "Basic YmFzaWNBdXRoOlVuaXN0YWxAMTk5NA==",
//      "Content-Type" : "application/x-www-form-urlencoded"
//    };
//
//   static Future<dynamic> getData({required var urlEndPoint}) async {
//     try {
//       if(await ConnectivityHelper.allConnectivityCheck(context: context!) == false){
//         return null;
//       }
//       String url = APIs.baseUrl+urlEndPoint;
//       log(Uri.parse(url.toString()).toString());
//       final response = await get(Uri.parse(url.toString()),
//           headers: header).timeout(const Duration(minutes: 1));
//       log(response.body);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       }else if (response.statusCode == 500) {
//         return jsonDecode(response.body);
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         log("SocketException : ${e.toString()}");
//         return e.toString();
//       } else if (e is TimeoutException) {
//         log("TimeoutException : ${e.toString()}");
//         return e.toString();
//       } else {
//         log("Unhandled exception : ${e.toString()}");
//         return e.toString();
//       }
//     }
//     return null;
//   }
//
//   static Future<dynamic> putData({required var urlEndPoint, required var body}) async {
//     try {
//       if(await ConnectivityHelper.allConnectivityCheck(context: context!) == false){
//         return null;
//       }
//       String url = APIs.baseUrl+urlEndPoint;
//       log(url);
//       final response = await put(Uri.parse(url), headers: header,
//           body: jsonEncode(body)).timeout(const Duration(minutes: 1));
//       log(response.body);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       }else if (response.statusCode == 500) {
//         return jsonDecode(response.body);
//       }
//     } catch (e) {
//       if (e is SocketException) {
//         log("SocketException : ${e.toString()}");
//         return e.toString();
//       } else if (e is TimeoutException) {
//         log("TimeoutException : ${e.toString()}");
//         return e.toString();
//       } else {
//         log("Unhandled exception : ${e.toString()}");
//         return e.toString();
//       }
//     }
//     return null;
//   }
//
//   static Future<dynamic> backgroundServicePost({required var urlEndPoint, required var body}) async {
//     try {
// /*      if(await ConnectivityHelper.allConnectivityCheck(context: context!) == false){
//         return null;
//       }*/
//
//       String baseUrl =  await SharedPreferencesUtils.getString(key: PreferencesName.baseUrl);
//       print("Base Url ====================  ${baseUrl}");
//       String url = baseUrl+urlEndPoint;
//       log(url);
//       log(jsonEncode(body).toString());
//       log(header.toString());
//       final response = await post(Uri.parse(url), headers: header,
//           body: jsonEncode(body)).timeout(const Duration(minutes: 1));
//       log(response.body);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else if (response.statusCode == 500) {
//         return jsonDecode(response.body);
//       }
//     } catch (e) {
//       print(e.toString() + "Post Data ");
//       if (e is SocketException) {
//         log("SocketException : ${e.toString()}");
//         return e.toString();
//       } else if (e is TimeoutException) {
//         log("TimeoutException : ${e.toString()}");
//         return e.toString();
//       } else {
//         log("Unhandled exception : ${e.toString()}");
//         return e.toString();
//       }
//     }
//     return null;
//   }
//
//    static Future<dynamic> postData({required var urlEndPoint, required var body}) async {
//      try {
//        String url = APIs.baseUrl + urlEndPoint;
//        log(url);
//        log(jsonEncode(body).toString());
//        log(header.toString());
//        final response = await post(Uri.parse(url), headers: header,
//            body: jsonEncode(body)).timeout(const Duration(minutes: 1));
//        log(response.body);
//        if (response.statusCode == 200) {
//          updateCookie(response);
//          return jsonDecode(response.body);
//        } else if (response.statusCode == 500) {
//          return jsonDecode(response.body);
//        }
//      } catch (e) {
//        print(e.toString() + "Post Data ");
//        if (e is SocketException) {
//          log("SocketException : ${e.toString()}");
//          return e.toString();
//        } else if (e is TimeoutException) {
//          log("TimeoutException : ${e.toString()}");
//          return e.toString();
//        } else {
//          log("Unhandled exception : ${e.toString()}");
//          return e.toString();
//        }
//      }
//      return null;
//    }
//
//      static Future<dynamic> getGoogleData({required var url}) async {
//      try {
//        if(await ConnectivityHelper.allConnectivityCheck(context: context!) == false){
//          return null;
//        }
//        log(url.toString());
//        final response = await get(url,
//            headers: header).timeout(const Duration(minutes: 1));
//        log(response.body);
//        if (response.statusCode == 200) {
//          return jsonDecode(response.body);
//        }else if (response.statusCode == 500) {
//          return jsonDecode(response.body);
//        }
//      } catch (e) {
//        if (e is SocketException) {
//          log("SocketException : ${e.toString()}");
//          return e.toString();
//        } else if (e is TimeoutException) {
//          log("TimeoutException : ${e.toString()}");
//          return e.toString();
//        } else {
//          log("Unhandled exception : ${e.toString()}");
//          return e.toString();
//        }
//      }
//      return null;
//    }
//
//    static Future<dynamic> firebasePushNotification({var url, var body}) async {
//      try {
//        var headerData = {
//          HttpHeaders.authorizationHeader: "key=AAAA_2ZBpcw:APA91bHTro4TrfIIaFMqK0tULAKYBnStmCrdWysOMlPyDWGAQYJnPkyX35PIFA0XyNczynTLnO7G03_kArEhq1-49Yv57tyyftQXJcnw85JtGdkMGUR9P2Bi000DlZOLlf7YNU2Zj2En",
//          "Content-Type" : "application/json; charset=UTF-8"
//        };
//        log(url);
//        log(jsonEncode(body));
//        final response = await post(Uri.parse(url), headers: headerData, body: jsonEncode(body));
//        log(response.body);
//        if (response.statusCode == 200) {
//          return jsonDecode(response.body);
//        }
//      } catch (e) {
//        if (e is SocketException) {
//          log("SocketException : ${e.toString()}");
//        } else if (e is TimeoutException) {
//          log("TimeoutException : ${e.toString()}");
//        } else {
//          log("Unhandled exception : ${e.toString()}");
//        }
//      }
//      return null;
//    }
//
//    static Future<dynamic> postDataWithFile({required String urlEndPoint,
//      required var body, required BuildContext context, required String filePath, required String keyWord}) async {
//      try{
//        String url = APIs.baseUrl + urlEndPoint;
//        Uri uri =  Uri.parse(url);
//        log(url);
//        log(body.toString());
//
//        var request = new MultipartRequest("POST", uri);
//        if(filePath.isNotEmpty){
//          var uploadFile = await MultipartFile.fromPath(keyWord, filePath);
//          request.files.add(uploadFile);
//        }
//        request.fields.addAll(body);
//        request.headers.addAll(header);
//        var response = await request.send();
//        if(response.statusCode == 200){
//          var responseData = await response.stream.toBytes();
//          var result = json.decode(String.fromCharCodes(responseData));
//          log(result.toString());
//          return result;
//        } else if(response.statusCode == 415){
//          var responseData = await response.stream.toBytes();
//          var result = json.decode(String.fromCharCodes(responseData));
//          log(result.toString());
//          return result;
//        } else if(response.statusCode == 400){
//          var responseData = await response.stream.toBytes();
//          var result = json.decode(String.fromCharCodes(responseData));
//          log(result.toString());
//          return result;
//        }else {
//          return null;
//        }
//      }catch(e){
//        log(e.toString());
//        return null;
//      }
//    }
//
//    static updateCookie(Response response) {
//      String? rawCookie = response.headers['set-cookie'];
//      if (rawCookie != null) {
//        int index = rawCookie.indexOf(';');
//        header['cookie'] =
//        (index == -1) ? rawCookie : rawCookie.substring(0, index);
//      }
//    }
// }