import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lmc/model/extra_price_pipe.dart';
import 'package:lmc/model/free_material.dart';
import 'package:lmc/model/hpcl_labels.dart';
import 'package:lmc/model/lmc_model.dart';
import 'package:lmc/model/meters_model.dart';
import 'package:lmc/style/text_style.dart';
import 'package:lmc/utils/global_constant.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/result_installation.dart';

// ignore: must_be_immutable
class InstallationScreen extends StatefulWidget {
  Rows rows;
  String action;
  InstallationScreen({Key key, this.rows, this.action}) : super(key: key);
  @override
  InstallationScreenPage createState() => InstallationScreenPage();
}

class InstallationScreenPage extends State<InstallationScreen> {
  bool hideButton = false;
  TextEditingController workStartDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
  TextEditingController conversionDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
  TextEditingController proposedDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
  TextEditingController regulatorNoController = TextEditingController(text: '');
  TextEditingController extraPipeController = TextEditingController(text: '0');
  TextEditingController extraPriceController = TextEditingController(text: '0');
  TextEditingController pipeController = TextEditingController(text: '0');
  TextEditingController fittingController = TextEditingController(text: '0');
  TextEditingController tfNoController = TextEditingController();
  TextEditingController tfLongitudeController = TextEditingController();
  TextEditingController tfLatitudeController = TextEditingController();
  TextEditingController houseLongitudeController = TextEditingController();
  TextEditingController houseLatitudeController = TextEditingController();
  TextEditingController workCompleteDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
  TextEditingController workAcknowledgmentDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));

  PhotoController meterImgController = PhotoController();
  PhotoController isometricImgController = PhotoController();
  PhotoController workCompleteController = PhotoController();
  PhotoController acknowledgmentImgController = PhotoController();
  TextEditingController meterNoController = TextEditingController(text: '');
  TextEditingController initialReadingController = TextEditingController(text: '');
  TextEditingController initialReadingController2 = TextEditingController(text: '');
  TextEditingController initialReadingController3 = TextEditingController(text: '');
  TextEditingController meterReadingDateController = TextEditingController(text: DateFormat("yyyy-MM-dd").format(DateTime.now()));

  Position tfPositional;
  Position housePositional;
  List<MaterialItem> _materialList = [];

  List<MeterData> meterDataList = [];

  List<String> meterNoList = [];
  List<String> meterNoIdList = [];
  String currentMeterNo = "";
  String currentMeterNoId = "";

  List<MeterData> meterDataList2 = [];
  List<String> meterNoList2 = [];
  List<String> meterNoIdList2 = [];
  String currentMeterNo2 = "";
  String currentMeterNoId2 = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<String> addedMeterNo = [];
  List<DropdownMenuItem<OptionItem>> typeOfNrItems = ([]);
  OptionItem _typeOfNrc;
  String _typeOfNrValue;
  String countryid, stateid;

  Future<void> _getFreeMaterialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var schema = prefs.getString(GlobalConstants.schema);
    var res = await http.get(Uri.parse(GlobalConstants.getFreeMaterialApi + schema));
    print("getFreeMaterialApi-->" + res.body);
    if (res.statusCode == 200) {
      FreeMaterial dataList = FreeMaterial.fromJson(json.decode(res.body));
      List<MaterialItem> materialList = [];

      materialList = List.generate(
        dataList.data.length,
        (i) =>
            MaterialItem(value: '0', id: '${dataList.data[i].id}', name: '${dataList.data[i].materialName}', label: '${dataList.data[i].materialUnit}', controller: TextEditingController(text: '0')),
      );
      if (!mounted) return;
      setState(() {
        _materialList = materialList;
      });
    }
  }

  Future<void> _getTypeOfNr() async {
    var res = await http.get(Uri.parse(GlobalConstants.getTypeOfNr));
    print("getTypeOfNr-->" + res.body);
    final decoded = jsonDecode(res.body) as Map;
    decoded.forEach((k, v) {
      typeOfNrItems.add(DropdownMenuItem(
        value: OptionItem(id: k, title: v),
        child: Text(v),
      ));
    });
    setState(() {
      _typeOfNrc = typeOfNrItems.first.value;
      _typeOfNrValue = _typeOfNrc.title;
    });
  }

  Future<void> _getMeters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(GlobalConstants.id);
    var token = prefs.getString(GlobalConstants.token);
    var schema = prefs.getString(GlobalConstants.schema);
    var url = GlobalConstants.getMeters + schema + '&meterSerial=dia&user_id=$id';
    var res = await http.get(Uri.parse(url), headers: {
      "authorization": token,
    });
    print("getMeters--> ${res.body.toString()}");
    Meters dataList = Meters.fromJson(json.decode(res.body));
    print("meterSerial${dataList.data.toString()}");
    if (dataList.success == 200) {
      List<String> _meterNoList = [];
      List<String> _meterNoIdList = [];
      meterDataList = List.generate(
        dataList.data.length,
        (i) => dataList.data[i],
      );
      _meterNoList = List.generate(dataList.data.length, (i) => ('${dataList.data[i].serialNumber}'));
      _meterNoIdList = List.generate(
        dataList.data.length,
        (i) => '${dataList.data[i].id}',
      );
      if (!mounted) return;
      setState(() {
        meterNoList.addAll(_meterNoList);
        meterNoIdList.addAll(_meterNoIdList);
      });
    }
  }

  Future<void> _getRegulators() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(GlobalConstants.id);
    var token = prefs.getString(GlobalConstants.token);
    var schema = prefs.getString(GlobalConstants.schema);
    var url = GlobalConstants.getMeters + schema + '&meterSerial=dia&user_id=$id';
    print("urls--> $url");
    var res = await http.get(Uri.parse(url), headers: {
      "authorization": token,
    });
    print("getMeters--> ${res.body.toString()}");
    Meters dataList2 = Meters.fromJson(json.decode(res.body));
    print("meterSerial${dataList2.data.toString()}");
    if (dataList2.success == 200) {
      List<String> _meterNoList2 = [];
      List<String> _meterNoIdList2 = [];
      meterDataList2 = List.generate(
        dataList2.data.length,
        (i) => dataList2.data[i],
      );
      _meterNoList2 = List.generate(dataList2.data.length, (i) => ('${dataList2.data[i].serialNumber}'));
      _meterNoIdList2 = List.generate(
        dataList2.data.length,
        (i) => '${dataList2.data[i].id}',
      );
      if (!mounted) return;
      setState(() {
        meterNoList2.addAll(_meterNoList2);
        meterNoIdList2.addAll(_meterNoIdList2);
      });
    }
  }

  List<DropdownMenuItem<OptionItem>> reasonArrItems = ([
    DropdownMenuItem(
      value: OptionItem(
        id: '0',
        title: 'Select Delay Reason',
      ),
      child: Text('Select Delay Reason'),
    ),
    DropdownMenuItem(
      value: OptionItem(
        id: '1',
        title: 'Pipeline not charged',
      ),
      child: Text('Pipeline not charged'),
    ),
    DropdownMenuItem(
      value: OptionItem(
        id: '2',
        title: 'Contractor not available',
      ),
      child: Text('Contractor not available'),
    ),
    DropdownMenuItem(
      value: OptionItem(
        id: '3',
        title: 'Customer hold',
      ),
      child: Text('Customer hold'),
    ),
    DropdownMenuItem(
      value: OptionItem(
        id: '4',
        title: 'Customer unavailable',
      ),
      child: Text('Customer unavailable'),
    ),
  ]);

  ProgressDialog pr;
  OptionItem _reasonIfDelay;
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

  Future<DateTime> conversionDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      return picked;
    }
    return DateTime.now();
  }

  AutoCompleteTextField<MeterData> textField;
  MeterData selected;
  AutoCompleteTextField<MeterData> textField2;
  MeterData selected2;
  List<DropdownMenuItem<OptionItem>> readyForNgcItems = ([]);
  String _readyForNgcValue;
  List<OptionItem> rfcList = [];
  Map<String, String> checkListJson = {
    // "cementing_of_holes": '0',
    // "clamping_pvc": '0',
    // "claminng_copper": '0',
    // "meter_testing":'0',
    // "paintaingofGIpipe": '0'
  };
  Future<void> isRfcList() async {
    var res = await http.get(Uri.parse(
      GlobalConstants.getRfc,
    ), headers: { 'Authorization': token,});
    print("getRfc--> " + res.body);
    final decoded = jsonDecode(res.body) as Map;
    decoded.forEach((k, v) {
      rfcList.add(OptionItem(id: k, title: v));
      Map<String, String> map = {
        '$k': '0',
      };
      checkListJson.addAll(map);
    });
    setState(() {});
  }

  Future<void> getReadyForNgc() async {
    var res = await http.get(Uri.parse(
      GlobalConstants.getReadyForNgc,
    ),headers: { 'Authorization': token,});
    print("getReadyForNgc--> " + res.body);
    final decoded = jsonDecode(res.body) as Map;
    decoded.forEach((k, v) {
      readyForNgcItems.add(DropdownMenuItem(
        value: OptionItem(id: k, title: v),
        child: Text(v),
      ));
    });
    setState(() {
      _readyForNgcValue = readyForNgcItems.first.value.title;
    });
  }

  getTextFormField(TextEditingController controller, {Function(String) onChanged, String hintText, String fieldText, int maxLimit, bool focusable = false, TextInputType keyboardType}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLimit ?? 20,
          autofocus: focusable,
          decoration: new InputDecoration(border: OutlineInputBorder(), labelText: hintText, hintText: fieldText ?? ""),
          onChanged: onChanged,
        ),
      ),
    );
  }

  getTextMeterFormField(TextEditingController controller, {Function(String) onChanged, String hintText, String fieldText, int maxLimit, bool focusable = false, TextInputType keyboardType}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: 1,
          autofocus: focusable,
          decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              labelText: hintText,
              counterText: "",
              hintText: fieldText ?? ""),
          onChanged: onChanged,
        ),
      ),
    );
  }

  getLatLongTextField(TextEditingController controller, {Function(String) onChanged, String hintText, String fieldText, bool focusable = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.headline1,
        child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          enabled: focusable,
          decoration: new InputDecoration(border: OutlineInputBorder(), labelText: fieldText ?? hintText ?? "", hintText: hintText ?? fieldText ?? ""),
          onChanged: (value) {
            if (onChanged != null) onChanged(value);
          },
        ),
      ),
    );
  }

  getTextField(String hintText, String fieldText, {TextEditingController controller, Function onChanged, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: TextFormField(
          controller: controller,
          onTap: onChanged,
          keyboardType: keyboardType,
          autofocus: false,
          enabled: false,
          initialValue: fieldText,
          decoration: new InputDecoration(border: OutlineInputBorder(), labelText: hintText, hintText: hintText),
        ),
      ),
    );
  }

  getDropDown(dropListModel, OptionItem _value, {title, Function(OptionItem optionItem) onChanged}) {
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

  _getCurrentLocation(String which) async {
    await Geolocator.getCurrentPosition().then((Position position) => {
          // await Geolocator.getLastKnownPosition().then((Position position) => {
          setState(
            () {
              if (which == 'TF') {
                tfPositional = position;
                tfLatitudeController.text = position.latitude.toString();
                tfLongitudeController.text = position.longitude.toString();
              } else {
                housePositional = position;
                houseLatitudeController.text = position.latitude.toString();
                houseLongitudeController.text = position.longitude.toString();
              }
            },
          )
        });
  }

  _uploadImage() async {
    Map<String, String> headers = {
      "authorization": token,
      'content-type': 'multipart/form-data',
    };
    if (workStartDateController.text == '') {
      _toast('Select Work Start Date');
      return;
    } else if (((DateTime.parse(workStartDateController.text).difference(DateTime.parse(proposedDateController.text)).inDays > 0) && (_reasonIfDelay.title == 'Select Delay Reason'))) {
      _toast('Select Delay Reason');
      return;
    } else if (meterNoController.text == '') {
      _toast('Enter Meter No.');
      return;
    } else if (initialReadingController.text + initialReadingController2.text + initialReadingController3.text == '') {
      _toast('Enter Meter Reading');
      return;
    } else if (meterReadingDateController.text == '') {
      _toast('Select Meter Reading Date');
      return;
    } else if (regulatorNoController.text == '') {
      _toast('Enter Regulator No.');
      return;
    } else if (meterImgController.imagePath == null || meterImgController.imagePath.path == '') {
      _toast('Choose Meter Photo');
      return;
    } else if (tfLatitudeController.text == '') {
      _toast('Enter SR Location Coordinate');
      return;
    } else if (tfLongitudeController.text == '') {
      _toast('Enter SR Location Coordinate');
      return;
    } else if (houseLatitudeController.text == '') {
      _toast('Enter House Location Coordinate');
      return;
    } else if (houseLongitudeController.text == '') {
      _toast('Enter House Location Coordinate');
      return;
    } else if (workCompleteDateController.text == '') {
      _toast('Select Work Complete Date');
      return;
    }
    // else if(workCompleteController.imagePath==null||workCompleteController.imagePath.path=='') {
    //   _toast('Choose Work Complete Photo');
    //   return;
    // }
    if (meterNoController.text != '') {
      int i = meterNoList.indexWhere((element) => element == (meterNoController.text));
      if (i > -1) {
        currentMeterNoId = meterNoIdList.elementAt(i);
      } else {
        _toast('Enter Valid Meter No.');
        return;
      }
    } else if (meterNoController.text == '') {
      _toast('Enter Meter No.');
      return;
    }
    var _arrId = _materialList.asMap().values.map((e) => e.id).toList();
    var _arrQty = _materialList.asMap().values.map((e) => e.controller.text).toList();
    var _qtyArr = _arrQty.toString().replaceAll(', ', ',').replaceAll('[', '').replaceAll(']', '');
    var _idArr = _arrId.toString().replaceAll(', ', ',').replaceAll('[', '').replaceAll(']', '');
    String _extrePipe = '0';
    String _extrePrice = '0';
    if (extraPipeController.text.toLowerCase().contains('meter'))
      _extrePipe = extraPipeController.text.split(' ').first;
    else
      _extrePipe = extraPipeController.text;
    if (extraPriceController.text.toLowerCase().contains('inr'))
      _extrePrice = extraPriceController.text.split(' ').first;
    else
      _extrePrice = extraPriceController.text;
    Map<String, String> requestBody = <String, String>{
      "dma_id": widget.rows.dma,
      "actual_work_start": workStartDateController.text,
      "meter_number": meterNoController.text,
      "delay_reason": _reasonIfDelay.title == 'Select Reason Delay' ? '' : _reasonIfDelay.title,
      "meter_reading_date": meterReadingDateController.text,
      "meter_reading": initialReadingController.text + initialReadingController2.text + initialReadingController3.text,
      "tf_number": (tfNoController.text),
      "latitude_tf": tfLatitudeController.text,
      "longitude_tf": tfLongitudeController.text,
      "latitude_hg": houseLatitudeController.text,
      "longitude_hg": houseLongitudeController.text,
      "work_completed_date": workCompleteDateController.text,
      "proposed_date": proposedDateController.text,
      "schema": schema,
      "material_id": currentMeterNoId,
      'material_id_lmc': _idArr,
      'qty_lmc': _qtyArr,
      'extra_pipe': _extrePipe,
      'extra_price': _extrePrice,
      'conversion_date': conversionDateController.text,
      'type_of_nr': _typeOfNrValue,
      'ngc': _readyForNgcValue,
      'regulators': currentMeterNoId2,
      'feasibility_id': widget.rows.lmcFeasId,
    };
    print("request+1 " + requestBody.toString());
    setState(() {
      hideButton = !hideButton;
    });
    await pr.show();
    String url = GlobalConstants.saveLmcInstallation;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields.addAll(requestBody);
    if (!(meterImgController == null || meterImgController.imagePath.path == '')) {
      var pic1 = await http.MultipartFile.fromPath("meter_photo", meterImgController.imagePath.path);
      request.files.add(pic1);
    }
    print("Request --> " + requestBody.toString());
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("saveLmcInstallation-->" + responseString);
    pr.hide();
    Result _res = new Result.fromJson(json.decode(responseString));
    try {
      if (_res.success == 200) {
        _showMyDialog(context, _res.data);
      } else if (_res.success == 403) {
        _showMyDialog(context, _res.data);
      } else {
        _showErrorDialog(context, " " + _res.toString());
      }
    } catch (e) {
      _showMyDialog(context, e.toString());
      pr.hide();
    }
  }

  String reasonLabel = '',
      meterNoLabel = '',
      materialLabel = '',
      proposedDateLabel = '',
      takePhotoLabel = 'Take Photo',
      takeMeterPhotoLabel = 'Meter Photo',
      btnTfLocationLabel = 'SR Get Location',
      btnHouseLocationLabel = 'House Get Location',
      btnSubmit = 'Submit',
      actualWorkStartLabel = 'Actual Work Start *',
      conversionLabel = 'Conversion Date *',
      initialReadingLabel = 'Meter Initial Reading *',
      readingDateLabel = 'Meter Reading Date *',
      meterPhotoLabel = 'Meter Photo *',
      tfNoLabel = 'TF Number',
      tfLatitudeLabel = 'Latitude SR',
      tfLongitudeLabel = 'Longitude SR',
      houseLatLabel = 'Latitude (House Gate)',
      houseLongLabel = 'Longitude (House Gate)',
      workCompleteDateLabel = 'Work Completed Date *',
      workCompleteImgLabel = 'Work Completed Image *',
      isometricImgLabel = 'Isometric Image ',
      extraPipeLabel = 'Extra Pipe',
      extraPriceLabel = 'Extra Price',
      typeOfNrLabel = 'Type Of NR',
      regulatorNoLabel = 'Regulators *';

  Future<void> _getLabelsData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConstants.token);
    var res = prefs.get(GlobalConstants.hpclLabels ?? '');
    if (res == '') {
      var _res = await http.get(Uri.parse(GlobalConstants.getLabels),headers: { 'Authorization': token,});
      print("getLabels-->" + _res.body);
      res = _res.body;
    }
    HpclLabel hpclLabel = HpclLabel.fromJson(json.decode(res));
    proposedDateLabel = hpclLabel.lmc.proposedDate;
    materialLabel = hpclLabel.lmc.material;
    actualWorkStartLabel = hpclLabel.lmc.workStart;
    reasonLabel = hpclLabel.lmc.reasonIfDelay;
    meterNoLabel = hpclLabel.lmc.meterNumber;
    initialReadingLabel = hpclLabel.lmc.meterInitialReading;
    readingDateLabel = hpclLabel.lmc.readingDate;
    meterPhotoLabel = hpclLabel.lmc.meterPhoto;
    tfNoLabel = hpclLabel.lmc.tfNumber;
    tfLatitudeLabel = hpclLabel.lmc.latitudeTf;
    tfLongitudeLabel = hpclLabel.lmc.longitudeTf;
    houseLatLabel = hpclLabel.lmc.latitudeHg;
    houseLongLabel = hpclLabel.lmc.longitudeHg;
    workCompleteDateLabel = hpclLabel.lmc.workCompletedDate;
    workCompleteImgLabel = hpclLabel.lmc.workCompletedImage;
    typeOfNrLabel = hpclLabel.lmc.typeNr;
    regulatorNoLabel = hpclLabel.lmc.regulators;
    setState(() {
      _showProgress = false;
    });
  }

  Future<void> _getExtraPipeDetails(String _qty) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(GlobalConstants.token);
    var schema = prefs.get(GlobalConstants.schema);
    double quantity = 0.00;
    for (int i = 0; i < _materialList.length; i++) {
      MaterialItem e = _materialList[i];
      if (e.name.toLowerCase().contains('pipe')) {
        if (e.controller.text != '') {
          quantity = quantity + double.parse(e.controller.text);
          setState(() {
            print("extra$quantity");
            quantity = quantity;
          });
        } else {
          setState(() {
            print("extra$quantity");
            e.controller.text = '0';
            //  e.controller.text = '0';
            quantity = 0.00;
          });
        }
      }
    }

    print("quantity--> $quantity");
    if (quantity > 15.0) {
      Map<String, String> requestBody = <String, String>{
        "schema": schema,
        "pipeQty": quantity.toString(),
      };
      var _res = await http.post(Uri.parse(GlobalConstants.getExtraPipeDetails), body: requestBody, headers: {'authorization': '$token'});
      print("getExtraPipeDetails--> ${_res.body.toString()}");
      ExtraPipePrice extraPipePrice = new ExtraPipePrice.fromJson(json.decode(_res.body));
      if (!extraPipePrice.error && extraPipePrice.data != null) {
        setState(() {
          extraPriceController.text = extraPipePrice.data.price.toString() + ' ' + extraPipePrice.data.priceUm;
          extraPipeController.text = extraPipePrice.data.qty.toString() + ' ' + extraPipePrice.data.pipeUm;
        });
      } else {
        setState(() {
          extraPriceController.text = '0';
          extraPipeController.text = '0';
        });
      }
    } else {
      setState(() {
        extraPriceController.text = '0';
        extraPipeController.text = '0';
      });
    }
  }

  @override
  void initState() {
    getSharedPref();
    _getCurrentLocation('TF');
    _getCurrentLocation('');
    super.initState();
    pr = ProgressDialog(context);
    pr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    _reasonIfDelay = reasonArrItems.first.value;
    _getLabelsData();
    _getMeters();
    _getRegulators();
    isRfcList();
    getReadyForNgc();
    _getTypeOfNr();
    _getFreeMaterialData();
  }

  String token, schema;
  Future<dynamic> getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString(GlobalConstants.token);
      schema = prefs.getString(GlobalConstants.schema);
    });
  }

  SimpleAutoCompleteTextField _autoCompleteTextView;
  SimpleAutoCompleteTextField _autoCompleteTextView2;
  bool _showProgress = true;

  @override
  Widget build(BuildContext context) {
    print("Date propose ${widget.rows.proposedDate}");
    proposedDateController.text = '${"${widget.rows.proposedDate}".split(' ')[0]}';
    _autoCompleteTextView = SimpleAutoCompleteTextField(
      //  key: key,
      decoration: new InputDecoration(
        labelStyle: new TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        hintText: 'XYZ-000-00',
        hintMaxLines: 1,
        fillColor: Colors.black,
        contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      controller: meterNoController,
      suggestions: meterNoList,
      textChanged: (text) => {
        currentMeterNo = text,
      },
      clearOnSubmit: false,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          //addedMeterNo.clear();
          //addedMeterNo.add(text);
          try {
            int i = meterNoList.indexWhere((element) => element.contains(text));
            currentMeterNoId = meterNoIdList.elementAt(i);
          } catch (e) {
            _toast(e.toString());
          }
        }
      }),
    );

    _autoCompleteTextView2 = SimpleAutoCompleteTextField(
      key: key,
      decoration: new InputDecoration(
        labelStyle: new TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        hintText: 'XYZ-000-00',
        hintMaxLines: 1,
        fillColor: Colors.black,
        contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      controller: regulatorNoController,
      suggestions: meterNoList2,
      textChanged: (text) => {
        currentMeterNo2 = text,
      },
      clearOnSubmit: false,
      textSubmitted: (text) => setState(() {
        if (text != "") {
          //addedMeterNo.clear();
          //addedMeterNo.add(text);
          try {
            int i = meterNoList2.indexWhere((element) => element.contains(text));
            currentMeterNoId2 = meterNoIdList2.elementAt(i);
          } catch (e) {
            _toast(e.toString());
          }
        }
      }),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'LMC Installation',
          style: AppTextStyle.toolbarHeadline,
        ),
      ),
      body: (!_showProgress)
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                      SizedBox(
                        height: 10,
                      ),
                      getTextField("BP NUMBER", '${widget.rows.bpNumber}'),
                      SizedBox(
                        height: 10,
                      ),
                      getDropDown(
                        typeOfNrItems,
                        _typeOfNrc,
                        title: typeOfNrLabel,
                        onChanged: (OptionItem value) {
                          setState(() {
                            _typeOfNrc = value;
                            _typeOfNrValue = value.title;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getDateTextField(proposedDateLabel, '${"${widget.rows.proposedDate}".split(' ')[0]}', controller: proposedDateController),
                      SizedBox(
                        height: 15,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(color: Colors.black),
                        child: InkWell(
                          child: TextFormField(
                            controller: workStartDateController,
                            autofocus: false,
                            enabled: false,
                            decoration: new InputDecoration(border: OutlineInputBorder(), labelText: actualWorkStartLabel, hintText: actualWorkStartLabel),
                          ),
                          onTap: () {
                            _selectDate(context).then((value) {
                              setState(() {
                                workStartDateController.text = ("${value.toLocal()}".split(' ')[0]);
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      getDropDown(
                        reasonArrItems,
                        _reasonIfDelay,
                        title: reasonLabel,
                        onChanged: (OptionItem value) {
                          setState(() {
                            _reasonIfDelay = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: _materialList.map((item) {
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: getTextField(materialLabel, item.name),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                (item.name.toLowerCase()).contains('pipe')
                                    ? Expanded(
                                        flex: 3,
                                        child: getQtyTextField(
                                          item.label,
                                          item.controller.text,
                                          enable: true,
                                          controller: item.controller,
                                          onChanged: (value) {
                                            if (value != null) _getExtraPipeDetails(value.toString());
                                          },
                                        ),
                                      )
                                    : Expanded(
                                        flex: 3,
                                        child: getQtyTextField(
                                          item.label,
                                          item.controller.text,
                                          enable: true,
                                          controller: item.controller,
                                        ),
                                      ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      getLatLongTextField(extraPipeController, hintText: extraPipeLabel, fieldText: extraPipeLabel, keyboardType: TextInputType.number),
                      getLatLongTextField(extraPriceController, hintText: extraPriceLabel, fieldText: extraPriceLabel, keyboardType: TextInputType.number),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                meterPhotoLabel,
                                style: AppTextStyle.headline,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              meterNoLabel,
                              style: AppTextStyle.headline,
                            ),
                          ),
                          _autoCompleteTextView,
                          Padding(padding: const EdgeInsets.all(4.0)),
                          Text(
                            initialReadingLabel,
                            style: AppTextStyle.headline,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  width: 35,
                                  margin: EdgeInsets.fromLTRB(0, 0, 1, 0),
                                  child: Center(child: getTextMeterFormField(initialReadingController, fieldText: '0', keyboardType: TextInputType.number, maxLimit: 1))),
                              Container(
                                  width: 35,
                                  margin: EdgeInsets.fromLTRB(0, 0, 1, 0),
                                  child: Center(child: getTextMeterFormField(initialReadingController2, fieldText: '0', keyboardType: TextInputType.number, maxLimit: 1))),
                              Container(
                                  width: 35,
                                  margin: EdgeInsets.fromLTRB(0, 0, 1, 0),
                                  child: Center(child: getTextMeterFormField(initialReadingController3, fieldText: '0', keyboardType: TextInputType.number, maxLimit: 1))),
                            ],
                          ),
                          DefaultTextStyle(
                            style: TextStyle(color: Colors.black),
                            child: InkWell(
                              child: TextFormField(
                                controller: meterReadingDateController,
                                autofocus: false,
                                enabled: false,
                                decoration: new InputDecoration(border: OutlineInputBorder(), labelText: readingDateLabel, hintText: readingDateLabel),
                              ),
                              onTap: () {
                                _selectDate(context).then((value) {
                                  setState(() {
                                    meterReadingDateController.text = ("${value.toLocal()}".split(' ')[0]);
                                  });
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("$regulatorNoLabel"),
                          ),
                          _autoCompleteTextView2,
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              meterImgController.imagePath != null
                                  ? Container(
                                      child: Row(
                                      children: [
                                        Image.file(
                                          meterImgController.imagePath,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ))
                                  : Container(
                                      child: Row(children: [
                                      Image.asset(
                                        'assets/icons/place_holder.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    ])),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context).primaryColor,
                                      ),
                                      child: Text(
                                        takeMeterPhotoLabel,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        _openImageSource(context, meterImgController);
                                      }),
                                ]),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      getTextFormField(tfNoController, hintText: tfNoLabel, fieldText: '', keyboardType: TextInputType.number, maxLimit: 10),
                      getLatLongTextField(tfLatitudeController..text = tfPositional != null ? tfPositional.longitude.toString() : "", hintText: tfLatitudeLabel, focusable: true),
                      getLatLongTextField(tfLongitudeController..text = tfPositional != null ? tfPositional.latitude.toString() : "", hintText: tfLongitudeLabel, focusable: true),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              btnTfLocationLabel,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              _getCurrentLocation('TF');
                            }),
                      ]),
                      getLatLongTextField(houseLatitudeController..text = housePositional != null ? housePositional.longitude.toString() : "", hintText: houseLatLabel, focusable: true),
                      getLatLongTextField(houseLongitudeController..text = housePositional != null ? housePositional.latitude.toString() : "", hintText: houseLongLabel, focusable: true),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              btnHouseLocationLabel,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              _getCurrentLocation('');
                            }),
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(color: Colors.black),
                        child: InkWell(
                          child: TextFormField(
                            controller: workCompleteDateController,
                            autofocus: false,
                            enabled: false,
                            decoration: new InputDecoration(border: OutlineInputBorder(), labelText: workCompleteDateLabel, hintText: workCompleteDateLabel),
                          ),
                          onTap: () {
                            _selectDate(context).then((value) => setState(() {
                                  workCompleteDateController.text = ("${value.toLocal()}".split(' ')[0]);
                                }));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          DefaultTextStyle(
                            style: TextStyle(color: Colors.black),
                            child: InkWell(
                              child: TextFormField(
                                controller: conversionDateController,
                                autofocus: false,
                                enabled: false,
                                decoration: new InputDecoration(border: OutlineInputBorder(), labelText: conversionLabel, hintText: conversionLabel),
                              ),
                              onTap: () {
                                conversionDate(context).then((value) => setState(() {
                                      conversionDateController.text = ("${value.toLocal()}".split(' ')[0]);
                                    }));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Checklist Before RFC',
                                style: AppTextStyle.headline,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: rfcList.map((item) {
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                value: checkListJson[item.id] == '0' ? false : true,
                                title: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${item.title}',
                                    style: AppTextStyle.textContent,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    if (val)
                                      checkListJson[item.id] = '1';
                                    else
                                      checkListJson[item.id] = '0';
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                          child: hideButton
                              ? null
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                  child: Container(
                                    width: 200,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        btnSubmit,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    _uploadImage();
                                  }),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            )
          : Container(
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
            ),
    );
  }

  Future<void> getImage(PhotoController photoController, ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      //File _image;
      final pickedFile = await picker.getImage(source: imageSource, maxHeight: 900, maxWidth: 1000, imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          //_image=File(pickedFile.path);
          if (photoController != null) photoController.imagePath = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      _toast(e.toString());
    }
  }

  String getDate(String savedDateString) {
    if (savedDateString != null && savedDateString != '') {
      String tempDate = new DateFormat("yyyy-MM-dd").format(DateTime.parse(savedDateString));
      return tempDate;
    }
    return '';
  }

  String getCurrentDate() {
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return date;
  }

  Future<void> _openImageSource(
    BuildContext mContext,
    PhotoController controller,
  ) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose One'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Gallery',
                      style: AppTextStyle.textTitle,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      getImage(controller, ImageSource.gallery).then((value) => setState(() {}));
                    }),
                ListTile(
                  title: Text('Camera', style: AppTextStyle.textTitle),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(controller, ImageSource.camera).then((value) => setState(() {}));
                  },
                ),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
                //Navigator.pop(mContext,'Refresh');
                //Navigator.of(mContext).pop('Refresh');
              },
            ),
          ],
        );
      },
    );
  }

  getDateTextField(String hintText, String fieldText, {TextEditingController controller, Function onChanged, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.black),
        child: InkWell(
          child: TextFormField(
            controller: controller,
            autofocus: false,
            enabled: false,
            decoration: new InputDecoration(border: OutlineInputBorder(), labelText: hintText, hintText: hintText),
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

_toast(String _msg) {
  Fluttertoast.showToast(msg: _msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
}

class PhotoController {
  File imagePath;
}

getQtyTextField(String hintText, String fieldText, {TextEditingController controller, Function(String) onChanged, bool enable, TextInputType keyboardType = TextInputType.number}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    child: DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        autofocus: false,
        enabled: enable ?? false,
        decoration: new InputDecoration(border: OutlineInputBorder(), labelText: hintText, hintText: hintText),
      ),
    ),
  );
}

getDropDown(dropListModel, OptionItem _value, {title, Function(OptionItem optionItem) onChanged}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
    child: DropdownButtonFormField<OptionItem>(
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      ),
      value: _value,
      items: List.generate(
        dropListModel.length,
        (i) => DropdownMenuItem(
          value: dropListModel[i],
          child: Text(dropListModel[i].title),
        ),
      ),
      onChanged: onChanged,
    ),
  );
}

class OptionItem {
  final String id;
  final String title;
  OptionItem({@required this.id, @required this.title});
}

class MaterialItem {
  final String id;
  final String name;
  final String value;
  final String label;
  final TextEditingController controller;
  MaterialItem({@required this.id, @required this.name, @required this.value, @required this.label, this.controller});
}

Future<void> _showMyDialog(BuildContext mContext, String _msg) async {
  return showDialog<void>(
    context: mContext,
    barrierDismissible: false,
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
              print("_msg--->" + _msg);
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
              Text(_msg),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              print("_msg--->" + _msg);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
