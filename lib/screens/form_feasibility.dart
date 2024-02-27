import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lmc/model/IndustryResponse.dart';
import 'package:lmc/model/lmc_model.dart';
import 'package:lmc/utils/commonWidgets/button_widget.dart';
import '../ExportFile/export_file.dart';

// ignore: must_be_immutable
class FeasibilityScreen extends StatefulWidget {
  Rows rows;
  String action;
  FeasibilityScreen({Key key, this.rows, this.action}) : super(key: key);

  @override
  FeasibilityScreenPage createState() => FeasibilityScreenPage();
}

class FeasibilityScreenPage extends State<FeasibilityScreen> {
  //List<DropdownMenuItem<MaterialData>> _materialDropdownItems;
  //MaterialData _materialName;
  //String _materialId;
  bool show = false;
  TextEditingController qtyController = TextEditingController();
  List<MaterialItem> _materialList = [];
  ProgressDialog pr;
  String _lmcFeasibilityDateLabel = '', _lmcProposedDateLabel = '';
  String _additionalLabel = '', _qtyLabel = '', _materialLabel = '';
  String _followUpDateLabel = '',
      _isFeasibleLabel = '',
      _reasonCommentLabel = '';
  TextEditingController feasibilityDateController =
      TextEditingController(text: "${DateTime.now().toLocal()}".split(' ')[0]);
  TextEditingController feasibilityDateController2 =
      TextEditingController(text: "${DateTime.now().toLocal()}".split(' ')[0]);
  TextEditingController followUpDateController =
      TextEditingController(text: '');
  TextEditingController reasonController = TextEditingController(text: '');
  List<IndustryList> list;
  bool _checkBoxStatus = true;
  DateTime _proposedDate = DateTime.now();
  DateTime _feasibilityVisitDate = DateTime.now();
  DateTime _followUpDate = DateTime.now();

  List<DropdownMenuItem<OptionItem>> dropDownFeasibleList = ([]);
  List<DropdownMenuItem<OptionItem>> dropDownFeasibleList2 = ([]);
  List<TextEditingController> _qtyControllerList = [];
  List<DropdownMenuItem<OptionItem>> readyForNgcItems = ([]);

  OptionItem _isFeasibleItem;
  OptionItem _isFeasibleItem2;
  IndustryResponse industryResponse;

  String _isFeasibleId;
  String _isFeasibleId2;

  String countryId, stateId;
  String responsible = '';
  Future<void> _getLabelsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = prefs.get(GlobalConstants.hpclLabels ?? '');
    var token = prefs.get(GlobalConstants.token);
    if (res == '') {
      var _res = await http.get(Uri.parse(GlobalConstants.getLabels), headers: {
        'Authorization': token,
      });
      res = _res.body;
      print("getLabels-->" + _res.body);
    }
    HpclLabel hpclLabel = HpclLabel.fromJson(json.decode(res));
    _lmcFeasibilityDateLabel = hpclLabel.lmc.feasibilityDate;
    _lmcProposedDateLabel = hpclLabel.lmc.proposedDate;
    _additionalLabel = hpclLabel.lmc.additional;
    _qtyLabel = hpclLabel.lmc.qty;
    _materialLabel = hpclLabel.lmc.material;
    _isFeasibleLabel = hpclLabel.lmc.isFeasible;
    responsible = hpclLabel.lmc.reason;
    _followUpDateLabel = hpclLabel.lmc.followUpDate;
    _reasonCommentLabel = "Comment";
  }

  Future<void> _getFreeMaterialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var schema = prefs.getString(GlobalConstants.schema);
    var token = prefs.get(GlobalConstants.token);
    var res = await http
        .get(Uri.parse(GlobalConstants.getFreeMaterialApi + schema), headers: {
      'Authorization': token,
    });

    print("getFreeMaterialUrlApi-->" +
        GlobalConstants.getFreeMaterialApi +
        schema);
    print("getFreeMaterialApi-->" + res.body);
    print("base url-->" + GlobalConstants.getFreeMaterialApi + schema);
    print("Authorization-->" + token);
    if (res.statusCode == 200) {
      FreeMaterial dataList = FreeMaterial.fromJson(json.decode(res.body));
      List<MaterialItem> materialList = [];
      for (int i = 0; i < dataList.data.length; i++) {
        TextEditingController qtyController =
            new TextEditingController(text: '0');
        _qtyControllerList.add(qtyController);
      }

      materialList = List.generate(
        dataList.data.length,
        (i) => MaterialItem(
            id: '${dataList.data[i].id}',
            name: '${dataList.data[i].materialName}',
            value: '0',
            controller: TextEditingController(text: '0')),
      );
      if (!mounted) return;
      setState(() {
        _materialList = materialList;
      });
    }
  }

  Future<void> getReadyForNgc() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConstants.token);
    var res = await http.get(
        Uri.parse(
          GlobalConstants.lmcReason,
        ),
        headers: {
          'Authorization': token,
        });
    print("lmcReason-->" + res.body);
    final decoded = jsonDecode(res.body) as Map;
    decoded.forEach((k, v) {
      dropDownFeasibleList2.add(DropdownMenuItem(
        value: OptionItem(id: k, title: v),
        child: Text(v),
      ));
    });
    _isFeasibleItem2 = dropDownFeasibleList2.first.value;
    _isFeasibleId2 = _isFeasibleItem2.id;
    setState(() {
      EasyLoading.dismiss();
    });
  }

  Future<void> isFeasibleDropdownList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConstants.token);
    var res = await http.get(
        Uri.parse(
          GlobalConstants.isFeasible,
        ),
        headers: {
          'Authorization': token,
        });
    print("isFeasible-->" + res.body);
    final decoded = jsonDecode(res.body) as Map;
    decoded.forEach((k, v) {
      dropDownFeasibleList.add(DropdownMenuItem(
        value: OptionItem(id: k, title: v.toString()),
        child: Text(v.toString()),
      ));
    });
    _isFeasibleItem = dropDownFeasibleList.first.value;
    _isFeasibleId = _isFeasibleItem.id;
    setState(() {
      EasyLoading.dismiss();
    });
  }

  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    super.initState();
    pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    isFeasibleDropdownList();
    getReadyForNgc();
    _getFreeMaterialData();
    _getLabelsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          'LMC Feasibility',
          style: AppTextStyle.toolbarHeadline,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 2,
                        ),
                        getDateTextField('$_lmcProposedDateLabel',
                            "${_proposedDate.toLocal()}".split(' ')[0],
                            controller: feasibilityDateController2),
                        getDateTextField('$_lmcFeasibilityDateLabel',
                            "${_feasibilityVisitDate.toLocal()}".split(' ')[0],
                            controller: feasibilityDateController),
                        SizedBox(
                          height: 15,
                        ),
                        getDropDown(
                          dropDownFeasibleList,
                          _isFeasibleItem,
                          title: _isFeasibleLabel,
                          onChanged: (OptionItem value) {
                            setState(() {
                              _isFeasibleItem = value;
                              _isFeasibleId = value.id;
                              if (_isFeasibleId == '1') {
                                reasonController.text = '';
                                followUpDateController.text = '';
                                _checkBoxStatus = true;
                              }
                              if (_isFeasibleId == '2') {
                                _checkBoxStatus = false;
                              }
                              if (_isFeasibleId == '3') {
                                _checkBoxStatus = true;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _isFeasibleId != '1'
                            ? getDropDown(
                                dropDownFeasibleList2,
                                _isFeasibleItem2,
                                title: responsible,
                                onChanged: (OptionItem value) {
                                  setState(() {
                                    _isFeasibleItem2 = value;
                                    _isFeasibleId2 = value.id;
                                    print("_isFeasibleId$_isFeasibleId2");
                                  });
                                },
                              )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        _isFeasibleId != '1'
                            ? getEditTextField('$_reasonCommentLabel',
                                enable: true, controller: reasonController)
                            : Container(),
                        _isFeasibleId == '3'
                            ? getDateTextField('$_followUpDateLabel',
                                "${_followUpDate.toLocal()}".split(' ')[0],
                                controller: followUpDateController)
                            : Container(),

                        // SizedBox(height:2,),
                        // getDateTextField(
                        //     '$_lmcProposedDateLabel',
                        //     "${_proposedDate.toLocal()}".split(' ')[0],
                        //     controller: feasibilityDateController2
                        // ),
                        // getDateTextField(
                        //     '$_lmcFeasibilityDateLabel',
                        //     "${_feasibilityVisitDate.toLocal()}".split(' ')[0],
                        //     controller: feasibilityDateController
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Checkbox(
                            //   checkColor: Colors.greenAccent,
                            //   activeColor: Colors.green,
                            //   value: _checkBoxStatus,
                            //   onChanged: (bool value) {
                            //     _checkBoxStatus = value;
                            //   },
                            // ),
                            _checkBoxStatus
                                ? Text(
                                    '$_additionalLabel',
                                    style: AppTextStyle.headline,
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                    _checkBoxStatus
                        ? Column(
                            children: _materialList.map((item) {
                              return ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: getTextField(
                                          _materialLabel, item.name),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: getQtyTextField(
                                          _qtyLabel, item.controller.text,
                                          enable: true,
                                          controller: item.controller),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )
                        : Container(),
                    show
                        ? Text("")
                        : ButtonWidget(
                            text: 'Submit',
                            onPressed: () async {
                              setState(() {
                                show = !show;
                              });
                              String _strProposedDate =
                                  "${_proposedDate.toLocal()}".split(' ')[0];
                              String _strVisitDate =
                                  "${_feasibilityVisitDate.toLocal()}"
                                      .split(' ')[0];
                              _postFeasibilityData(
                                  widget.rows,
                                  _strProposedDate,
                                  _strVisitDate,
                                  _materialList);
                            }),
                  ]);
            },
          ),
        ),
      ),
    );
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
        items: dropListModel,
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _postFeasibilityData(Rows rows, String strProposedDate,
      String strVisitDate, List<MaterialItem> materialList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var schema = prefs.getString(GlobalConstants.schema);
    var token = prefs.getString(GlobalConstants.token);
    var lmcId = rows.assignId;
    var dmaId = rows.dma;
    var bom = _checkBoxStatus ? '1' : '0';
    var _arrId = _materialList.asMap().values.map((e) => e.id).toList();
    var _arrQty =
        _materialList.asMap().values.map((e) => e.controller.text).toList();
    var _qtyArr = _arrQty
        .toString()
        .replaceAll(', ', ',')
        .replaceAll('[', '')
        .replaceAll(']', '');
    var _idArr = _arrId
        .toString()
        .replaceAll(', ', ',')
        .replaceAll('[', '')
        .replaceAll(']', '');

    if (_isFeasibleId != '1' && reasonController.text == '') {
      _toast('Enter comment for  feasibility');
      return;
    } else if (_isFeasibleId == '3' && followUpDateController.text == '') {
      _toast('Select follow up date');
      return;
    }
    var jsonVAr = {
      'lmcId': lmcId,
      'dmaId': dmaId,
      'proposed_date': strProposedDate,
      'feasibility_visit_date': strVisitDate,
      'schema': schema,
      'bom': bom,
      'material_id': _checkBoxStatus ? _idArr : '',
      'qty': _checkBoxStatus ? _qtyArr : '',
      'is_feasible': _isFeasibleId,
      'feas_reason': _isFeasibleId2,
      'comment': reasonController.text,
      'follow_up_date': followUpDateController.text,
    };
    print("jsonVAr-->${jsonVAr.toString()}");
    //return;
    await pr.show();

    var res = await http.post(
      Uri.parse(GlobalConstants.postFeasibilityDataApi),
      body: jsonVAr,
      //  headers: {'authorization': '$token'}
    );
    log("postFeasibilityDataApi-->${GlobalConstants.postFeasibilityDataApi}");
    print("postFeasibilityDataApi-->" + res.body);
    SuccessResponce _res = new SuccessResponce.fromJson(json.decode(res.body));
    if (_res.success == 200) {
      pr.hide();
      _showMyDialog(context, _res.data);
    } else {
      pr.hide();
      _showErrorDialog(context, _res.data);
      //print(res.body);
    }
  }

  getTextField(String hintText, String fieldText,
      {TextEditingController controller,
      Function onChanged,
      bool enable,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          controller: controller,
          onTap: onChanged,
          keyboardType: keyboardType,
          autofocus: false,
          enabled: enable ?? false,
          initialValue: fieldText,
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: hintText,
              hintText: hintText),
        ),
      ),
    );
  }

  getEditTextField(String hintText,
      {TextEditingController controller,
      Function onChanged,
      bool enable,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          controller: controller,
          onTap: onChanged,
          keyboardType: keyboardType,
          autofocus: false,
          enabled: enable ?? false,
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: hintText,
              hintText: hintText),
        ),
      ),
    );
  }

  getQtyTextField(String hintText, String fieldText,
      {TextEditingController controller,
      Function onChanged,
      bool enable,
      TextInputType keyboardType = TextInputType.number}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          controller: controller,
          onTap: onChanged,
          keyboardType: keyboardType,
          autofocus: false,
          enabled: enable ?? false,
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              labelText: hintText,
              hintText: hintText),
        ),
      ),
    );
  }

  getDateTextField(String hintText, String fieldText,
      {TextEditingController controller,
      Function onChanged,
      TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: InkWell(
          child: TextFormField(
            controller: controller,
            autofocus: false,
            enabled: false,
            decoration: new InputDecoration(
                border: OutlineInputBorder(),
                labelText: hintText,
                hintText: hintText),
          ),
          onTap: () {
            _selectDate(context).then((value) => setState(() {
                  controller.text = ("${value.toLocal()}".split(' ')[0]);
                }));
          },
        ),
      ),
    );
  }
}

class SuccessResponce {
  int success;
  bool error;
  String data;
  SuccessResponce({this.success, this.error, this.data});
  SuccessResponce.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    data = json['data'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    data['data'] = this.data;
    return data;
  }
}

Future<void> _showMyDialog(BuildContext mContext, String _msg) async {
  return showDialog<void>(
    context: mContext,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(_msg),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(mContext, 'Refresh');
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showErrorDialog(BuildContext mContext, String _msg) async {
  return showDialog<void>(
    context: mContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(_msg ?? ""),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(mContext).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<DateTime> _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2050),
  );
  if (picked != null) {
    return picked;
  }
  return DateTime.now();
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class OptionItem {
  final String id;
  final String title;
  OptionItem({@required this.id, @required this.title});
}

class MaterialItem {
  final String id;
  final String name;
  final String value;
  final TextEditingController controller;
  MaterialItem({
    @required this.id,
    @required this.name,
    @required this.value,
    this.controller,
  });
}

_toast(String _msg) {
  Fluttertoast.showToast(
      msg: _msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
