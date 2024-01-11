import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lmc/model/lmc_model.dart';
import '../ExportFile/export_file.dart';
import 'installation_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  final String selection;
  Home({Key key, this.selection}) : super(key: key);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<Home> implements LMCPresenterInterface {
  bool _showProgress = false;
  bool _loadMore = false;
  String area_id = '';
  OptionItem countryId;
  List<DropdownMenuItem<OptionItem>> _regionDropDown;
  final List<Notification> notifications = [];
  String _id = '';
  String _schema = '';
  String _token = '';
  int _offSet = 0;
  String bpNumber = '';
  String _firstNameLabel = '', _customerRegNoLabel = '';
  String _lmcFeasibilityDateLabel = '',
      _lmcProposedDateLabel = '',
      _areaLabel = '';
  String _guardianNameLabel = '',
      _propertyCategoryNameLabel = '',
      _propertyCategoryClassLabel = '';
  String _houseNoLabel = '',
      _localityLabel = '',
      _townLabel = '',
      _stateLabel = '',
      _districtLabel = '';
  String _pinCodeLabel = '';
  LMCDrop selectedUser;

  SharedPreferences prefs;
  TextEditingController remarksController = new TextEditingController();
  TextEditingController dateFromTo = new TextEditingController();
  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();
  BuildContext mContext;
  GlobalKey<ScaffoldState> _scaffoldKey;

  LmcPresenter _lmcPresenter;
  List<Rows> _lmcDataList = [];
  List<DropdownMenuItem<OptionItem>> readyForNgcItems = ([]);
  List<DropdownMenuItem<OptionItem>> typeOfNrItems = ([]);

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
    _lmcPresenter.getDataFromServer(_id, _schema, _token, _offSet.toString(),
        widget.selection, bpNumber, area_id);
  }

  Future<void> _getLabelsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConstants.token);
    var res = await http.get(Uri.parse(GlobalConstants.getLabels), headers: {
      'Authorization': token,
    });
    print("getLabels-->" + res.body);
    prefs.setString(GlobalConstants.hpclLabels, res.body);
    if (res.statusCode == 200) {
      HpclLabel hpclLabel = HpclLabel.fromJson(json.decode(res.body));
      _firstNameLabel = hpclLabel.steps.firstname;
      _customerRegNoLabel = hpclLabel.steps.reg;
      _guardianNameLabel = hpclLabel.registration.guardian;
      _houseNoLabel = hpclLabel.registration.house;
      _localityLabel = hpclLabel.registration.locality;
      _townLabel = hpclLabel.registration.town;
      _stateLabel = 'State';
      _districtLabel = hpclLabel.registration.district;
      _pinCodeLabel = hpclLabel.registration.pincode;
      _areaLabel = hpclLabel.registration.area;
      _propertyCategoryNameLabel = hpclLabel.registration.propertyCategory;
      _propertyCategoryClassLabel = hpclLabel.registration.propertyClass;
      _lmcFeasibilityDateLabel = hpclLabel.lmc.feasibilityDate;
      _lmcProposedDateLabel = hpclLabel.lmc.proposedDate;
      print("getLabels-->" + res.body);
      print("hpclLabel--> $hpclLabel");
    }
  }

  List<DataRow> _rowList = [
    DataRow(cells: <DataCell>[
      DataCell(Text('4')),
    ]),
  ];

  @override
  void initState() {
    super.initState();
    _multipleRequstPermission();
    getPref();
    _getLabelsData();
    getCountry();
    getReadyForNgc();
    _lmcDataList = [];
    _lmcPresenter = new LmcPresenter(this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _offSet++;
        print("_offSet-->" + _offSet.toString());
        setState(() {
          _loadMore = true;
        });
        _lmcPresenter.getDataFromServer(_id, _schema, _token,
            _offSet.toString(), '${widget.selection}', bpNumber, area_id);
      }
    });
  }

  Future<bool> _multipleRequstPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
    ].request();
    if (statuses[Permission.location].isGranted) {
      print("Location permission is isGranted.");
    }
    if (statuses[Permission.camera].isGranted) {
      print("Camera permission is isGranted.");
    }
    if (statuses[Permission.storage].isGranted) {
      print("Camera permission is isGranted.");
    }
    return true;
  }

  Future<String> getCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString(GlobalConstants.token) ?? '';
    String schema = pref.getString(GlobalConstants.schema) ?? '';
    String url = GlobalConstants.areaList + schema;
    print("token-->" + token);
    print("schema-->" + schema);
    print("url-->" + url);

    var res =
        await http.get(Uri.parse(url), headers: {"authorization": "$token"});
    var dataList = json.decode(res.body);
    print("areaList-->" + res.body);
    List<DropdownMenuItem<OptionItem>> menuItems = List.generate(
      dataList.length,
      (i) => DropdownMenuItem(
        value:
            OptionItem(id: dataList[i]['gid'], title: dataList[i]['area_name']),
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
  }

  var dataRow = [
    DataRow(cells: [
      DataCell(Text("Waiting")),
    ]),
  ];
  @override
  Widget build(BuildContext context) {
    mContext = context;
    double _width = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          'Home',
          style: AppTextStyle.appBarTitle,
        ),
      ),
      body: Stack(
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(" Select Area", style: ThemeStyle.selectArea)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                      _lmcPresenter.getDataFromServer(
                          _id,
                          _schema,
                          _token,
                          _offSet.toString(),
                          widget.selection,
                          bpNumber,
                          area_id);
                      //   _lmcPresenter.getDataFromServer(_id,_schema,_token,_offSet.toString(),widget.selection,bpNumber,area_id);
                      _showProgress = true;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                    hintText: "Search...",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _lmcPresenter.getDataFromServer(
                              _id,
                              _schema,
                              _token,
                              '1',
                              widget.selection,
                              searchController.text.toString(),
                              area_id);
                          _showProgress = true;
                        });
                      },
                    ),
                  ),
                  controller: searchController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Scrollbar(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _showProgress
                        ? Padding(
                            padding: const EdgeInsets.only(top: 200.0),
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
                            ? DataTable(
                                sortAscending: true,
                                columnSpacing: 12,
                                horizontalMargin: 0,
                                showCheckboxColumn: false,
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.grey),
                                columns: [
                                  DataColumn(label: Text("Area")),
                                  DataColumn(label: Text("Mobile No.")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Proposed Date")),
                                  DataColumn(label: Text("BP Number")),
                                ],
                                rows:
                                    //  _showProgress  ? []
                                    //    :
                                    _lmcDataList
                                        .mapIndexed((index, element) => DataRow(
                                                onSelectChanged: (value) {
                                                  _showDetailsDialog(
                                                      context,
                                                      'LMC Installation',
                                                      element);
                                                },
                                                cells: [
                                                  DataCell(
                                                      Text(element.areaName)),
                                                  DataCell(Text(
                                                      element.mobileNumber)),
                                                  DataCell(
                                                      Text(element.firstName)),
                                                  DataCell(Text(
                                                      element.proposedDate)),
                                                  DataCell(
                                                      Text(element.bpNumber)),
                                                ]))
                                        .toList()
                                //        :
                                //    [
                                //      // DataRow(
                                //      //   cells: [
                                //      //     DataCell(Text(("Data Not Found...")))
                                //      //   ]
                                //      // )
                                //    ].whereType<DataRow>().toList(),
                                // // Center(child: Text('Data Not Found'),),

                                )
                            : Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Text('Data Not Found'),
                              ),
                  )),
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
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                            ),
                            child: SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 5),
                            child: Text(
                              'Loading..',
                            ),
                          )
                        ],
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
    // if (lmcList == null || lmcList.length == 0) {
    if (lmcList == null) {
      setState(() {
        _showProgress = false;
        _loadMore = true;
        //    _loadMore = false;
      });
    } else if (mounted) {
      setState(() {
        _showProgress = false;
        _loadMore = false;
        _lmcDataList.clear();
        for (int i = 0; i < lmcList.length; i++) {
          if (lmcList
                  .elementAt(i)
                  .bpNumber
                  .contains(searchController.text.trim()) ||
              lmcList
                  .elementAt(i)
                  .mobileNumber
                  .contains(searchController.text.trim())) {
            print(" element mobile--> " +
                lmcList.elementAt(i).mobileNumber +
                " element bp--> " +
                lmcList.elementAt(i).bpNumber);
            _lmcDataList.add(lmcList.elementAt(i));
          }
        }
      });
    }
  }

  @override
  void showError([onError]) {
    if (onError.toString() == '403') {
      _sessionExpireDialog();
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
          ],
        );
      },
    );
  }

  _showDetailsDialog(BuildContext mContext, String title, Rows rows) async {
    return showDialog(
      context: context,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "LMC Installation",
                              style: TextStyle(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      (rows.isInstall == null)
                          ? Container(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: rows.dmaRegId == null
                                            ? InkWell(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    border: Border.all(
                                                      color: Colors.blue,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 20.0,
                                                      ),
                                                      Text(
                                                        'Feasibility',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  gotoFeasibility(
                                                      context, rows);
                                                  // Navigator.of(context).pop();
                                                  // Navigator.push(
                                                  //     mContext,
                                                  //     MaterialPageRoute(builder: (context) => FeasibilityScreen(rows: rows,)));
                                                  //_showFeasibilityDialog(context,'Feasibility Details Form',widget.rows);
                                                },
                                              )
                                            : Visibility(
                                                visible: false,
                                                child: InkWell(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      border: Border.all(
                                                        color: Colors.blue,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                          size: 20.0,
                                                        ),
                                                        Text(
                                                          'Installation',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    gotoInstallation(
                                                        context, rows);
                                                  },
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_customerRegNoLabel"),
                            Text(rows.crn ?? 'Registration No'),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_lmcFeasibilityDateLabel"),
                            Text(rows.feasibilityVisitDate ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_lmcProposedDateLabel"),
                            Text(rows.proposedDate ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_areaLabel"),
                            Text(rows.areaName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_firstNameLabel"),
                            Text(rows.firstName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_guardianNameLabel"),
                            Text(rows.guardianName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_propertyCategoryNameLabel"),
                            Text(rows.propName ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_propertyCategoryClassLabel"),
                            Text(rows.propClass ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_houseNoLabel"),
                            Text(rows.houseNumber ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_localityLabel"),
                            Expanded(child: Text(rows.locality ?? '')),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_townLabel"),
                            Text(rows.town ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_stateLabel"),
                            Text(rows.state ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_districtLabel"),
                            Text(rows.district ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$_pinCodeLabel"),
                            Text(rows.pinCode ?? ''),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.teal.shade100,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: Text('Installation'),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  primary: Colors.black,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () => {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            InstallationScreen(
                                                rows: rows, action: 'Push')))
                                    .then((value) {
                                  setState(() {
                                    _lmcPresenter.getDataFromServer(
                                        _id,
                                        _schema,
                                        _token,
                                        _offSet.toString(),
                                        widget.selection,
                                        bpNumber,
                                        area_id);
                                    _showProgress = true;
                                  });
                                })
                              },
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
    String received = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) =>
                InstallationScreen(rows: rows, action: 'Push')));
    if (received == 'Refresh') {
      Navigator.of(context).pop();
      getPref();
    }
  }

  gotoFeasibility(BuildContext context, Rows rows) async {
    String received = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) =>
                FeasibilityScreen(rows: rows, action: 'Push')));
    if (received == 'Refresh') {
      Navigator.of(context).pop();
      getPref();
    }
  }

  Future<void> getReadyForNgc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConstants.token);
    var res = await http.get(
        Uri.parse(
          GlobalConstants.getReadyForNgc,
        ),
        headers: {
          'Authorization': token,
        });
    print(res.body);
    final decoded = jsonDecode(res.body) as Map;
    decoded.forEach((k, v) {
      readyForNgcItems.add(DropdownMenuItem(
        value: OptionItem(id: k, title: v),
        child: Text(v),
      ));
    });
    setState(() {});
  }
}

String getDate(String savedDateString) {
  if (savedDateString != null && savedDateString != '') {
    String tempDate =
        new DateFormat("yyyy-MM-dd").format(DateTime.parse(savedDateString));
    return tempDate;
  }
  return '';
}

getTextField(String hintText, String fieldText,
    {TextInputType keyboardType = TextInputType.text}) {
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
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: hintText,
              hintText: hintText),
        ),
      ),
    ),
  );
}

class OptionItem {
  final String id;
  final String title;
  OptionItem({@required this.id, @required this.title});
}

getDropDown(dropListModel, OptionItem _value,
    {title, Function(OptionItem optionItem) onChanged}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    child: DropdownButtonFormField<OptionItem>(
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      ),
      value: _value,
      items: dropListModel
      /*List.generate(
            dropListModel.length,
                (i) => DropdownMenuItem(
              value: dropListModel[i],
              child: Text(dropListModel[i].title),
            ),
          )*/
      ,
      onChanged: onChanged,
    ),
  );
}

class Notification {
  final String title;
  final String body;
  final Color color;

  const Notification(
      {@required this.title, @required this.body, @required this.color});
}
