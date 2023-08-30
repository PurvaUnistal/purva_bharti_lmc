import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lmc/model/lmc_model.dart';
import 'package:lmc/screens/installation_screen.dart';
import '../ExportFile/export_file.dart';

class FeasibilityHomeScreen extends StatefulWidget {
  final String selection;
  const FeasibilityHomeScreen({Key key, this.selection}) : super(key: key);

  @override
  State<FeasibilityHomeScreen> createState() => _FeasibilityHomeScreenState();
}

class _FeasibilityHomeScreenState extends State<FeasibilityHomeScreen> implements LMCPresenterInterface {
  String _id = '';
  String _schema = '';
  String _token = '';
  int _offSet = 0;
  String bpNumber = '';
  bool _showProgress = false;
  bool _loadMore = false;
  LmcPresenter _lmcPresenter;
  BuildContext mContext;
  OptionItem countryId;
  String area_id = '';
  List<Rows> _lmcDataList = [];
  List<DropdownMenuItem<OptionItem>> _regionDropDown;
  final List<Notification> notifications = [];

  String firstNameLabel,
      areaLabel,
      customerRegNoLabel,
      guardianNameLabel,
      propertyCategoryNameLabel,
      propertyCategoryClassLabel,
      houseNoLabel,
      localityLabel,
      townLabel,
      stateLabel,
      districtLabel,
      pinCodeLabel = '';

  TextEditingController searchController = new TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  ScrollController _scrollController = new ScrollController();

  getPref() async {
    setState(() {
      if (!_showProgress) _showProgress = true;
    });
    _offSet = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _id = preferences.getString(GlobalConstants.id);
    _schema = preferences.getString(GlobalConstants.schema);
    _token = preferences.getString(GlobalConstants.token);
    if (_lmcDataList.length > 0) {
      _lmcDataList.clear();
    }
    _lmcPresenter.getDataFromServer(_id, _schema, _token, _offSet.toString(), widget.selection, bpNumber, area_id);

    setState(() {});
  }

  Future<void> _getLabelsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var res = await http.get(Uri.parse(GlobalConstants.getLabels),headers: { 'Authorization': _token,}).timeout(Duration(seconds: 10));
      print("getLabels-->" + res.body);
      prefs.setString(GlobalConstants.hpclLabels, res.body);
      if (res.statusCode == 200) {
        HpclLabel hpclLabel = HpclLabel.fromJson(json.decode(res.body));
        firstNameLabel = hpclLabel.steps.firstname;
        customerRegNoLabel = hpclLabel.steps.reg;
        guardianNameLabel = hpclLabel.registration.guardian;
        houseNoLabel = hpclLabel.registration.house;
        localityLabel = hpclLabel.registration.locality;
        townLabel = hpclLabel.registration.town;
        stateLabel = 'State';
        districtLabel = hpclLabel.registration.district;
        pinCodeLabel = hpclLabel.registration.pincode;
        areaLabel = hpclLabel.registration.area;
        propertyCategoryNameLabel = hpclLabel.registration.propertyCategory;
        propertyCategoryClassLabel = hpclLabel.registration.propertyClass;
      } else {
        return null;
      }
    } on TimeoutException catch (e, s) {
      print("TimeoutException-->${e.message.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Server Side Is Slow")));
    } catch (e) {
      print('catch error--> : $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getPref();
    _getLabelsData();
    getCountry();
    _lmcDataList = [];
    _lmcPresenter = new LmcPresenter(this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _offSet++;
        print("_offSet--->" + _offSet.toString());
        setState(() {
          _loadMore = true;
        });
        _lmcPresenter.getDataFromServer(_id, _schema, _token, _offSet.toString(), '${widget.selection}', bpNumber, area_id);
      }
    });

  }

  Future<String> getCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(GlobalConstants.token) ?? '';
    String schema = pref.getString(GlobalConstants.schema) ?? '';
    String url = GlobalConstants.areaList + schema;
    print(token);
    print(schema);
    print(url);
    try {
      var res = await http.get(Uri.parse(url), headers: {"authorization": "$token"}).timeout(Duration(seconds: 10));
      var dataList = json.decode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        List<DropdownMenuItem<OptionItem>> menuItems = List.generate(
          dataList.length,
          (i) => DropdownMenuItem(
            value: OptionItem(id: dataList[i]['gid'], title: dataList[i]['area_name']),
            child: Text(
              "${dataList[i]['area_name']}",
            ),
          ),
        );
        if (mounted) {
          setState(() {
            EasyLoading.dismiss();
            _regionDropDown = menuItems;
            // countryId = _regionDropDown.first.value;
          });
        }
        return "Success";
      } else {
        return null;
      }
    } on TimeoutException catch (e, s) {
      print("TimeoutException-->${e.message.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Server Side Is Slow")));
    } catch (e) {
      print('catch error--> : $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Home',
          style: AppTextStyle.appBarTitle,
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(" Select Area", style: ThemeStyle.selectArea),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  hint: Text("--Please Select Area--"),
                  items: _regionDropDown,
                  value: countryId,
                  onChanged: (newVal) {
                    area_id = newVal.id;
                    print('countryId -->' + newVal.id);
                    setState(() {
                      countryId = newVal;
                      _lmcPresenter.getDataFromServer(_id, _schema, _token, _offSet.toString(), widget.selection, bpNumber, area_id);
                      _showProgress = true;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                child: TextField(
                  controller: searchController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _lmcPresenter.getDataFromServer(_id, _schema, _token, '1', widget.selection, searchController.text.toString(), area_id);
                          _showProgress = true;
                        });
                      },
                    ),
                    hintText: 'Search ',
                  ),
                ),
              ),
              Container(
                height: 45,
                color: Colors.grey,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: _width,
                      child: Center(
                        child: Text(
                          'Area',
                          style: AppTextStyle.tableTitle,
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      child: Center(
                        child: Text(
                          'Mobile No.',
                          style: AppTextStyle.tableTitle,
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      child: Center(
                        child: Text(
                          'Name',
                          style: AppTextStyle.tableTitle,
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      child: Center(
                        child: Text(
                          'BP Number',
                          style: AppTextStyle.tableTitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (_showProgress)
                  ? Center(
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
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'Wait..',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : (_lmcDataList.length > 0)
                      ? Expanded(
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _lmcDataList.length,
                              itemBuilder: (BuildContext context, int index) {
                                Rows _rows = _lmcDataList.elementAt(index);
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                  title: Container(
                                      height: 60.0,
                                      color: (_rows.dmaRegId == null) ? Colors.black12 : Colors.blue[50],
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              _rows.areaName,
                                              style: AppTextStyle.textTitle,
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              _rows.mobileNumber,
                                              style: AppTextStyle.textTitle,
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              _rows.firstName,
                                              style: AppTextStyle.textTitle,
                                            ),
                                          )),
                                          Expanded(
                                              child: Center(
                                            child: Text(
                                              _rows.bpNumber == null ? '-' : _rows.bpNumber,
                                              style: AppTextStyle.textTitle,
                                            ),
                                          )),
                                        ],
                                      )),
                                  onTap: () {
                                    _showDetailsDialog(context, 'LMC Feasibility', _rows);
                                  },
                                );
                                // return new LmcListItem(rows: _rows,);
                              }),
                        )
                      : Expanded(
                          child: Center(
                            child: Text('Data Not Found'),
                          ),
                        )
            ],
          ),
          _loadMore
              ? Center(
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.all(
                          10,
                        ),
                        child: Text(
                          'No Data',
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
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

  @override
  void showDataList(List<Rows> lmcList) {
    //  if(lmcList == null || lmcList.length==0){
    if (lmcList == null) {
      setState(() {
        _showProgress = false;
        _loadMore = true;
        //    _loadMore = false;
      });
    } else if (mounted) {
      setState(() {
        //_listLength = lmcList.length;
        _showProgress = false;
        _loadMore = false;
        _lmcDataList.clear();
        for (int i = 0; i < lmcList.length; i++) {
          if (lmcList.elementAt(i).bpNumber.contains(searchController.text.trim()) || lmcList.elementAt(i).mobileNumber.contains(searchController.text.trim())) {
            print(" element mobile" + lmcList.elementAt(i).mobileNumber + " element bp" + lmcList.elementAt(i).bpNumber);
            _lmcDataList.add(lmcList.elementAt(i));
          }
        }
        // _lmcDataList.addAll(lmcList);
      });
    }
  }

  @override
  void showError([onError]) {
    if (onError.toString() == '403') {
      SessionDialogUtils.showCustomDialog(context,
          okBtnFunction: () => SessionDialogUtils.logOut(context));
     // _sessionExpireDialog();
    } else if (onError.toString() == '401') {
      getPref();
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
            /*    TextButton(
              child: Text('Not Yet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),*/
          ],
        );
      },
    );
  }

  _showDetailsDialog(BuildContext mContext, String title, Rows rows) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5,
                shadowColor: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListBody(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LMC Feasibility",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      (rows.isInstall == null)
                          ? Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    /*   Expanded(
                                child: Text('Action',)
                            ),
                            Expanded(
                              child:  Align(
                                alignment: Alignment.centerRight,
                                child: rows.dmaRegId==null
                                    ?InkWell(
                                  child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                        Text('Feasibility',style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    gotoFeasibility(context,rows);
                                    // Navigator.of(context).pop();
                                    // Navigator.push(
                                    //     mContext,
                                    //     MaterialPageRoute(builder: (context) => FeasibilityScreen(rows: rows,)));
                                    //_showFeasibilityDialog(context,'Feasibility Details Form',widget.rows);
                                  },
                                )
                                    :InkWell(
                                  child:Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20.0,
                                        ),
                                        Text('Installation',style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  onTap: (){
                                    gotoInstallation(context,rows);
                                  },
                                ),
                              ),
                            ),*/
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$customerRegNoLabel"),
                            Text(rows.crn ?? 'Registration No'),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$areaLabel"),
                            Text(rows.areaName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$firstNameLabel"),
                            Text(rows.firstName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$guardianNameLabel"),
                            Text(rows.guardianName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$propertyCategoryNameLabel"),
                            Text(rows.propName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$propertyCategoryClassLabel"),
                            Text(rows.propClass ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$houseNoLabel"),
                            Text(rows.houseNumber ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$localityLabel"),
                            Text(rows.locality ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$townLabel"),
                            Text(rows.town ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$stateLabel"),
                            Text(rows.state ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$districtLabel"),
                            Text(rows.district ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$pinCodeLabel"),
                            Text(rows.pinCode ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                textStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                primary: Colors.blue,
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              child: Text('No'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                primary: Colors.black,
                                textStyle: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop();
                                gotoFeasibility(context, rows);
                                //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => InstallationScreen(rows: rows, action: 'Push')))
                              },
                              child: Text('Check Feasibility'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  gotoInstallation(BuildContext context, Rows rows) async {
    String received = await Navigator.push(mContext, MaterialPageRoute(builder: (context) =>
        InstallationScreen(rows: rows, action: 'Push')));
    if (received == 'Refresh') {
      Navigator.of(context).pop();
      getPref();
    }
  }

  Future<void> gotoFeasibility(BuildContext context, Rows rows) async {
    String received = await Navigator.push(context, MaterialPageRoute(builder: (context) => FeasibilityScreen(rows: rows, action: 'Push'))).then((value) {
      setState(() {
        _showProgress = true;
      });
      return _lmcPresenter.getDataFromServer(_id, _schema, _token, _offSet.toString(), widget.selection, bpNumber, area_id);
    });
    if (received == 'Refresh') {
      Navigator.of(context).pop();
      getPref();
    }
  }
}

String getDate(String savedDateString) {
  if (savedDateString != null && savedDateString != '') {
    String tempDate = new DateFormat("yyyy-MM-dd").format(DateTime.parse(savedDateString));
    return tempDate;
  }
  return '';
}

getTextField(String hintText, String fieldText, {TextInputType keyboardType = TextInputType.text}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          keyboardType: keyboardType,
          autofocus: false,
          enabled: false,
          initialValue: fieldText,
          decoration: new InputDecoration(border: OutlineInputBorder(), labelText: hintText, hintText: hintText),
        ),
      ),
    ),
  );
}

class Notification {
  final String title;
  final String body;
  final Color color;
  const Notification({@required this.title, @required this.body, @required this.color});
}

class OptionItem {
  String id;

  OptionItem({this.id, this.title});

  String title;
}
