import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/features/Login/presentation/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionDialogUtils {
  static SessionDialogUtils _instance = new SessionDialogUtils.internal();

  SessionDialogUtils.internal();

  factory SessionDialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,{required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Timeout'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Session was expire you need to login again?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Login'),
                onPressed: okBtnFunction(),
              ),
            ],
          );
        });
  }



  static logOut({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(PrefsValue.isUserLogIn, false);
      prefs.setString(PrefsValue.userInfo, '');
      prefs.setString(PrefsValue.userInfo, '');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}