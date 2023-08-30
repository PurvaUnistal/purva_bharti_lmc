import '../ExportFile/export_file.dart';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  final _key = new GlobalKey<FormState>();
  bool _showProgress = false;
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      attemptLogIn(email, password);
    }
  }

  var value;


  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/icons/ic_launcher.png"),
                            SizedBox(height: 20.0),
                            Text(
                              'L M C',
                              style: AppTextStyle.appTitle,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Card(
                              elevation: 6.0,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                autofillHints: const [
                                  AutofillHints.username,
                                  AutofillHints.email
                                ],
                                textCapitalization: TextCapitalization.none,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                                validator: (e) {
                                  if (e.isEmpty) {
                                    CustomToast.showToast('Please Insert Email');
                                    return "Please Insert Email";
                                  } else if (!isValidEmail(e)) {
                                    CustomToast.showToast('Please Insert Valid Email');
                                    return "Please Insert Valid Email";
                                  }
                                  return null;
                                },
                                onSaved: (e) => email = e,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  labelStyle: AppTextStyle.textContent,
                                  labelText: "Email",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.person, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 6.0,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [AutofillHints.password],
                                inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                                validator: (e) {
                                  if (e.isEmpty) {
                                    return "Password Can't be Empty";
                                  }
                                  return null;
                                },
                                obscureText: _secureText,
                                onSaved: (e) => password = e,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(18),
                                  labelStyle: AppTextStyle.textContent,
                                  labelText: "Password",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.phonelink_lock, color: Colors.black),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: showHide,
                                    icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  height: 44.0,
                                  width: 200,
                                  child: ElevatedButton(
                                      child: Text(
                                        "Login",
                                        style: AppTextStyle.buttonTitle,
                                      ),
                                      onPressed: () {
                                        TextInput.finishAutofillContext();
                                          check();},
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            Color(0xFFf7d426),
                                          ),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                          ))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (_showProgress)
                ? Container(
                    color: Colors.white60,
                    child: Center(
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 5,
                                ),
                                child: SizedBox(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                  height: 20.0,
                                  width: 20.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 5),
                                child: Text(
                                  'Wait..',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String _email) {
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(_email);
  }

  getUniqueDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  Future<void> attemptLogIn(String username, String password) async {
    var deviceId = await getUniqueDeviceId();
    setState(() {
      _showProgress = true;
    });
    try {
      final data = {"email": username, "password": password, "device": deviceId};
      final jsonString = json.encode(data);
      var res = await http.post(Uri.parse(GlobalConstants.login), body: jsonString);
      print("login-->" + jsonString);
      print("login-->" + GlobalConstants.login);
      print("login-->" + res.body);
      setState(() {
        _showProgress = false;
      });
      print("login--> " + res.body);
      try {
        LoginModel lgd = new LoginModel.fromJson(json.decode(res.body));

        if (lgd.status == 200 && lgd.user.role.toLowerCase().contains('lmc')) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(GlobalConstants.isUserLogIn, true);
          prefs.setString(GlobalConstants.username, username);
          prefs.setString(GlobalConstants.password, password);
          prefs.setString(GlobalConstants.id, lgd.user.id);
          prefs.setString(GlobalConstants.token, lgd.token);
          prefs.setString(GlobalConstants.schema, lgd.user.schema);
          prefs.setString(GlobalConstants.name, lgd.user.name);
          prefs.setString(GlobalConstants.role, lgd.user.role);
          prefs.setString(GlobalConstants.changePassword, lgd.user.pwdChanged);
          // CustomToast.showToast(lgd.messages);
          if (lgd.user.role.toLowerCase().contains('lmc')) {
            CustomToast.showToast(lgd.messages);
         /*   if(lgd.user.pwdChanged == "0"){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                    (Route<dynamic> route) => false,
              );
            }else{*/
               Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
              (Route<dynamic> route) => false,
            );
         //   }

          } else {
            CustomToast.showToast('Invalid UserName and Password');
          }
        } else if (lgd.status == 401) {
          CustomToast.showToast('Invalid UserName and Password');
        } else {
          CustomToast.showToast('Invalid UserName and Password');
          //CustomToast.showToast(lgd.messages);
        }
      } catch (e) {
        print(e);
        CustomToast.showToast('$e');
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _showProgress = false;
      });
      CustomToast.showToast('Check Your Internet Connection');
    }
  }
}
