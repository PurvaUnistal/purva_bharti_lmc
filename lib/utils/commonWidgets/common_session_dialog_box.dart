import '../../ExportFile/export_file.dart';

class SessionDialogUtils {
  static SessionDialogUtils _instance = new SessionDialogUtils.internal();

  SessionDialogUtils.internal();

  factory SessionDialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,{@required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Session Expired'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Your session has expired. Please sign in again.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Login'),
                onPressed: okBtnFunction,
              ),
            ],
          );
        });
  }

  static logOut(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(GlobalConstants.isUserLogIn, false);
      prefs.setString(GlobalConstants.username, '');
      prefs.setString(GlobalConstants.password, '');
      prefs.setString(GlobalConstants.id, '');
      prefs.setString(GlobalConstants.token, '');
      prefs.setString(GlobalConstants.schema, '');
      prefs.setString(GlobalConstants.name, '');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}