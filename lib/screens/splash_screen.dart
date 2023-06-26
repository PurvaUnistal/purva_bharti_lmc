import '../ExportFile/export_file.dart';

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
    String changePassword = prefs.getString(GlobalConstants.changePassword);
    print("_isLogin--> $_isLogin");
    if(changePassword == "0"){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ChangePasswordPage()),
            (Route<dynamic> route) => false,
      );
    }else {
      if(_isLogin) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()),);
      }else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login()));
      }
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
