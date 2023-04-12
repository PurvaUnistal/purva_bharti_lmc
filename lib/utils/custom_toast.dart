import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


}

class ValidateCustomToast{
  static _showToastMsg(String msgType, String msg) {
    if (msgType == "success") {
      return Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
    } else if (msgType == "error") {
      return Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      return Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
      );
    }
  }
}