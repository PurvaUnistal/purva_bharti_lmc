import 'package:lmc/screens/home_screen.dart';
import 'package:lmc/screens/home_feasibility.dart';
import '../ExportFile/export_file.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String role = '';
  String schema = '';
  String token = '';

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      role = prefs.getString(GlobalConstants.role).toLowerCase();
      schema = prefs.getString(GlobalConstants.schema) ?? "";
      token = prefs.getString(GlobalConstants.token) ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  void showError([onError]) {
    if (onError.toString() == '403') {

      _sessionExpireDialog();
    } else if (onError.toString() == '401') {
      getUserDetails();
    }
  }

  Future<void> _sessionExpireDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
              onPressed: () {
                Navigator.of(context).pop();
                _logOut();
              },
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
            title: Text(
              'L M C',
              style: AppTextStyle.appBarTitle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _showLogoutDialog();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<CircleBorder>(
                  CircleBorder(side: BorderSide(color: Colors.transparent)),
                )),
              ),
            ]),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              (role.contains('lmc')) ? Colors.white : Colors.grey[400],
                            ),
                            elevation: MaterialStateProperty.all<double>(4.0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            )),
                        onPressed: () {
                          if (role.contains('lmc'))
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeasibilityHomeScreen(
                                          selection: 'Feasibility',
                                        )));
                        },
                        child: Container(
                          height: 120.0,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.call_to_action_sharp,
                                          size: 18.0,
                                          color: Colors.teal,
                                        ),
                                        Text(
                                          " LMC Feasibility",
                                          style: AppTextStyle.tableTitle,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          primary: (role.contains('lmc')) ? Colors.white : Colors.grey[400],
                        ),
                        onPressed: () {
                          if (role.contains('lmc'))
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                          selection: 'Installation',
                                        )));
                        },
                        child: Container(
                          height: 120.0,
                          alignment: Alignment.center,
                          color: (role.contains('lmc')) ? Colors.white : Colors.grey[400],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.featured_play_list,
                                      size: 18.0,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " LMC Installation",
                                      style: AppTextStyle.tableTitle,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerRecords()));
                        },
                        child: Container(
                          height: 120.0,
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.image,
                                      size: 18.0,
                                      color: Colors.teal,
                                    ),
                                    Text(
                                      " Images",
                                      style: AppTextStyle.tableTitle,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.teal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  )),
                  Text("GA : " + schema),
                  Text("LMC Version : 1.1"),
                  Text("Release Date : 28-03-2023"),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _logOut();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logOut() async {
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
      print(e);
    }
  }
}
