import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/global_constant.dart';
import '../features/ChangePassword/presentations/Screen/change_password_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = 'splash-screen';
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  bool _isLogin = false;

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool(GlobalConstants.isUserLogIn) ?? false;
    print("_isLogin--> $_isLogin");
    if(_isLogin) {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),);
    }else{
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login()));
    //  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
    }
  }
  Future<Timer> timeDuration() async {
    return Timer(Duration(seconds: 1), checkLogin);
  }

  @override
  void initState() {
    super.initState();
    timeDuration();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Image.asset('assets/icons/ic_launcher.png')
    );
  }
}
